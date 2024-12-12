//
//  PurchaseManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import StoreKit
import SwiftyUserDefaults

@MainActor
class PurchaseManager: NSObject, ObservableObject {
    
    private let productIds = ["slidey_monthly_premium_1", "slidey_annual_premium_1"]
    
    @Published var products: [Product] = []
    @Published var purchasedProductIDs = Set<String>()
    @Published var isPremium: Bool?
    @Published var isCanceled = false
    
    @Published var productsLoaded = false
    private var updates: Task<Void, Never>? = nil

    override init() {
        super.init()
        self.updates = observeTransactionUpdates()
        Task {
            await updatePurchasedProducts()
        }
        SKPaymentQueue.default().add(self)
    }

    deinit {
        self.updates?.cancel()
    }

    func isUserPremium() -> Bool {
       return !self.purchasedProductIDs.isEmpty
    }
    
    @MainActor
    func loadProducts() async throws -> [Subscription] {
        if !productsLoaded {
            self.products = try await Product.products(for: productIds)
            self.productsLoaded = true
        }
        return getSubscriptionsList()
    }
    
    private func getSubscriptionsList () -> [Subscription] {
        var list: [Subscription] = []
        if products.count > 0 && productsLoaded {
            for i in 0..<products.count {
                list.append(getSubscriptionFromProduct(product: products[i], position: i))
            }
            
            if list[0].period != NSLocalizedString("annual_plan", comment: "") {
                list.swapAt(0, 1)
            }
            
            updateSaveAmount(list: &list)
        }
        return list
    }

    private func getSubscriptionFromProduct (product: Product, position: Int) -> Subscription {
        var freeTrialText: String?
        var period = ""
        var periodShort = ""
        var periodInt = 0
        
        if let subscriptionInfo = product.subscription {
            if let introductoryOffer = subscriptionInfo.introductoryOffer {
                if introductoryOffer.period.unit == Product.SubscriptionPeriod.Unit.day {
                    freeTrialText = NSLocalizedString("free_trial_then", comment: "").replacingOccurrences(of: "7", with: String(introductoryOffer.periodCount))
                } else if introductoryOffer.period.unit == Product.SubscriptionPeriod.Unit.week {
                    freeTrialText = NSLocalizedString("free_trial_then", comment: "").replacingOccurrences(of: "7", with: String(7 * introductoryOffer.periodCount))
                } else if introductoryOffer.period.unit == Product.SubscriptionPeriod.Unit.month {
                    freeTrialText = NSLocalizedString("free_trial_then", comment: "").replacingOccurrences(of: "7", with: String(30 * introductoryOffer.periodCount))
                }
            }
            
            if subscriptionInfo.subscriptionPeriod.unit == Product.SubscriptionPeriod.Unit.month {
                if subscriptionInfo.subscriptionPeriod.value == 1 {
                    period = NSLocalizedString("monthly_plan", comment: "")
                    periodShort = NSLocalizedString("month", comment: "")
                } else if subscriptionInfo.subscriptionPeriod.value == 3 {
                    period = NSLocalizedString("quarterly_plan", comment: "") // 3 months
                    periodShort = NSLocalizedString("quarter", comment: "")
                } else if subscriptionInfo.subscriptionPeriod.value == 6 {
                    period = NSLocalizedString("semi_annual_plan", comment: "") // semi_annual
                    periodShort = NSLocalizedString("semi_annual", comment: "")
                }
                periodInt = 1
            } else if subscriptionInfo.subscriptionPeriod.unit == Product.SubscriptionPeriod.Unit.year {
                period = NSLocalizedString("annual_plan", comment: "")
                periodShort = NSLocalizedString("annual", comment: "")
                periodInt = 2
            } else if subscriptionInfo.subscriptionPeriod.unit == Product.SubscriptionPeriod.Unit.week {
                period = NSLocalizedString("weekly_plan", comment: "")
                periodShort = NSLocalizedString("week", comment: "")
                periodInt = 3
            }
        }
        
        return Subscription(position: position, price: product.displayPrice + " / " + periodShort, freeTrial: freeTrialText, period: period, isSelected: periodInt == 2, product: product)
    }
    
    private func updateSaveAmount (list: inout [Subscription]) {
        if list.count >= 2 {
            var priceAnnual = 1.0
            var priceMonthly = 1.0
            for subscription in list {
                if let product = subscription.product {
                    if let subscriptionInfo = product.subscription {
                        if subscriptionInfo.subscriptionPeriod.unit == Product.SubscriptionPeriod.Unit.year {
                            priceAnnual = Double(truncating: product.price as NSNumber)
                        } else if subscriptionInfo.subscriptionPeriod.unit == Product.SubscriptionPeriod.Unit.month {
                            priceMonthly = Double(truncating: product.price as NSNumber)
                        }
                    }
                }
            }
            
            if priceAnnual != 1.0 && priceMonthly != 1.0 {
                let priceAnnualPerMonth = priceAnnual / 12
                let savePercent = abs((priceAnnualPerMonth * 100 / priceMonthly) - 100)
                for i in 0..<list.count {
                    let subscription = list[i]
                    if let product = subscription.product {
                        if let subscriptionInfo = product.subscription {
                            if subscriptionInfo.subscriptionPeriod.unit == Product.SubscriptionPeriod.Unit.year {
                                subscription.saveAmount = NSLocalizedString("save_percent", comment: "").replacingOccurrences(of: "44", with: String(Int(savePercent)))
                                list[i] = subscription
                            }
                        }
                    }
                }
            }
        }
    }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        switch result {
        case let .success(.verified(transaction)):
            // Successful purchase
            await transaction.finish()
            await self.updatePurchasedProducts()
        case let .success(.unverified(_, error)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            break
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            break
        case .userCancelled:
            self.isCanceled.toggle()
            break
        @unknown default:
            self.isCanceled.toggle()
            break
        }
    }

    private func updatePurchasedProducts() async {
        print("Purchase update started")
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }

            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
            print("Purchase update started 1")
            
            await transaction.finish()
            
            let premium = isUserPremium()
            Defaults.KEY_ACCOUNT_TYPE = premium ? 1 : 0
            isPremium = premium
            AiManager.updateAttempts()
            print("Purchase update started 2")
        }
        
        let premium = isUserPremium()
        Defaults.KEY_ACCOUNT_TYPE = premium ? 1 : 0
        isPremium = premium
        print("Purchase update started 3")
        AnalyticsManager.saveUserProperty(propertyName: "plan", value: String(premium ? 1 : 0))
    }

    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await verificationResult in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
//                await handle(transactionVerification: verificationResult)
            }
        }
    }
    
    @MainActor
    private func handle(transactionVerification verificationResult: VerificationResult <Transaction> ) async {
        guard case .verified(let transaction) = verificationResult else {
            return
        }

        if transaction.revocationDate == nil {
            self.purchasedProductIDs.insert(transaction.productID)
        } else {
            self.purchasedProductIDs.remove(transaction.productID)
        }
        
        await transaction.finish()
        
        let premium = isUserPremium()
        Defaults.KEY_ACCOUNT_TYPE = premium ? 1 : 0
        isPremium = premium
    }
    
    func restorePurchases () async {
        do {
            try await AppStore.sync()
        } catch let error {
            print(error)
        }
    }
}

extension PurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

    }

    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}
