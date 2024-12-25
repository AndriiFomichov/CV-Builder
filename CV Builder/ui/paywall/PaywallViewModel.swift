//
//  PaywallViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import Foundation
import StoreKit

class PaywallViewModel: ObservableObject {
    
    var benefitsId = 0
    var source = ""
    
    @Published var header = ""
    @Published var description = ""
    @Published var subscriptionsList: [Subscription] = []
    @Published var subscriptionsShown = false
    @Published var btnMainSelected = false
    @Published var plansLoading = false
    @Published var purchaseLoading = false
    @Published var btnNextText = NSLocalizedString("start_subscription", comment: "")
    @Published var tip = ""
    @Published var btnNextDescription = ""
    @Published var freeTrialVisible = false
    @Published var chargeDate = ""
    @Published var freeTrialStateTwoDay = ""
    @Published var freeTrialStateThreeDay = ""
    
    @Published var dismissed = false
    
    @Published var connectionDialogShown = false
    @Published var successDialogShown = false
    @Published var errorDialogShown = false
    
    var purchaseManager: PurchaseManager?
    
    func updateData (purchaseManager: PurchaseManager, benefitsId: Int, source: String) {
        self.purchaseManager = purchaseManager
        self.benefitsId = benefitsId
        self.source = source
        
        updateHeader()
        updateDescription()
        
        AnalyticsManager.saveEvent(event: Events.PAYWALL_OPENED, characteristics: [ "benefits", "source" ], values: [ String(self.benefitsId), self.source ])
        
        Task {
            await fetchSubscriptions()
        }
    }
    
    private func updateHeader () {
        header = PaywallData.getPaywallHeader(benefitsId: benefitsId, name: "")
    }
    
    private func updateDescription () {
        description = PaywallData.getDescription(benefitsId: benefitsId)
    }
    
    @MainActor
    private func fetchSubscriptions () async {
        if Reachability.isConnectedToNetwork() {
            plansLoading = true
            
            do {
                if let purchaseManager {
                    subscriptionsList = try await purchaseManager.loadProducts()
                }
            } catch let error {
                print(error)
            }
            
            AnalyticsManager.saveEvent(event: Events.PAYWALL_PLANS_LOADED, characteristics: [ "benefits", "source" ], values: [ String(benefitsId), source ])
        
            plansLoading = false
            
            if subscriptionsList.count > 0 {
                updateSelectedPlanDetails()
                btnMainSelected = true
                subscriptionsShown = true
            } else {
                btnMainSelected = false
                subscriptionsShown = false
                errorDialogShown = true
            }
        } else {
            btnMainSelected = false
            subscriptionsShown = false
            connectionDialogShown = true
        }
    }
    
    func selectSubscription (position: Int) {
        if position != getSelectedPlanPosition() {
            for i in 0...subscriptionsList.count-1 {
                let subscription = subscriptionsList[i]
                if i == position {
                    subscription.isSelected = true
                } else {
                    subscription.isSelected = false
                }
                subscriptionsList[i] = subscription
            }
            updateSelectedPlanDetails()
        }
    }
    
    private func updateSelectedPlanDetails () {
        let selectedPosition = getSelectedPlanPosition()
        if selectedPosition != -1 && selectedPosition < subscriptionsList.count {
            updatePlanDetails(subscription: subscriptionsList[selectedPosition])
        }
    }
    
    private func updatePlanDetails (subscription: Subscription) {
        if let product = subscription.product {
            
            if let subs = product.subscription {
                
                if let introductoryOffer = subs.introductoryOffer {
                    btnNextText = NSLocalizedString("start_free_trial", comment: "")
                    tip = NSLocalizedString("tip_free_trial", comment: "")
                    freeTrialVisible = true
                    
                    var daysOfOffer = 0
                    
                    if introductoryOffer.period.unit == Product.SubscriptionPeriod.Unit.day {
                        daysOfOffer = introductoryOffer.periodCount
                    } else if introductoryOffer.period.unit == Product.SubscriptionPeriod.Unit.week {
                        daysOfOffer = 7 * introductoryOffer.periodCount
                    } else if introductoryOffer.period.unit == Product.SubscriptionPeriod.Unit.month {
                        daysOfOffer = 30 * introductoryOffer.periodCount
                    }
                    
                    freeTrialStateTwoDay = NSLocalizedString("free_trial_day_five", comment: "").replacingOccurrences(of: "5", with: String(daysOfOffer - 2))
                    freeTrialStateThreeDay = NSLocalizedString("free_trial_day_seven", comment: "").replacingOccurrences(of: "7", with: String(daysOfOffer))
                    
                    let calendar = Calendar.current
                    let chargeDate = calendar.date(byAdding: .day, value: daysOfOffer, to: Date())
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM d, YYYY"
                    self.chargeDate = dateFormatter.string(from: chargeDate!)
                    
                    if let freeTrial = subscription.freeTrial {
                        btnNextDescription = freeTrial + "\n" + subscription.price
                    } else {
                        btnNextDescription = subscription.price
                    }
                    
                } else {
                    btnNextText = NSLocalizedString("start_subscription", comment: "")
                    tip = NSLocalizedString("tip_base", comment: "")
                    freeTrialVisible = false
                    btnNextDescription = subscription.price
                }
                
            } else {
                btnNextText = NSLocalizedString("start_subscription", comment: "")
                freeTrialVisible = false
                tip = ""
                btnNextDescription = ""
            }
            
        } else {
            btnNextText = NSLocalizedString("start_subscription", comment: "")
            freeTrialVisible = false
            tip = ""
            btnNextDescription = ""
        }
    }
    
    @MainActor
    func startPurchase () {
        if let purchaseManager {
            if purchaseManager.isUserPremium() {
                dismissed = true
            } else {
                if !plansLoading && !purchaseLoading {
                    let selectedPosition = getSelectedPlanPosition()
                    if selectedPosition != -1 && selectedPosition < subscriptionsList.count {
                        
                        AnalyticsManager.saveEvent(event: Events.PAYWALL_PURCHASE_STARTED, characteristics: [ "benefits", "source" ], values: [ String(benefitsId), source ])
                        
                        purchaseLoading = true
                        btnMainSelected = false
                        
                        let subscription = subscriptionsList[selectedPosition]
                        if let product = subscription.product {
                            Task {
                                do {
                                    try await purchaseManager.purchase(product)
                                } catch let error {
                                    print(error)
                                    errorDialogShown = true
                                    purchaseLoading = false
                                    btnMainSelected = false
                                }
                            }
                        } else {
                            errorDialogShown = true
                            purchaseLoading = false
                            btnMainSelected = false
                        }
                    } else {
                        errorDialogShown = true
                        purchaseLoading = false
                        btnMainSelected = false
                    }
                }
            }
        } else {
            errorDialogShown = true
            purchaseLoading = false
            btnMainSelected = false
        }
    }
    
    @MainActor
    func handlePurchaseUpdate () {
        btnNextText = NSLocalizedString("continue", comment: "")
        
        purchaseLoading = false
        btnMainSelected = true
        
        if let purchaseManager {
            if purchaseManager.isUserPremium() {
                successDialogShown = true
            }
        } else {
            errorDialogShown = true
        }
    }
    
    @MainActor
    func handlePurchaseError () {
        btnNextText = NSLocalizedString("continue", comment: "")
        errorDialogShown = true
        purchaseLoading = false
        btnMainSelected = false
    }
    
    @MainActor
    func handlePurchaseCanceled () {
        purchaseLoading = false
        btnMainSelected = true
    }
    
    private func getSelectedPlanPosition () -> Int {
        var position = -1
        for i in 0..<subscriptionsList.count {
            let subscription = subscriptionsList[i]
            if subscription.isSelected {
                position = i
                break
            }
        }
        return position
    }
    
    func restorePurchases () {
        if let purchaseManager = purchaseManager {
            Task {
                await purchaseManager.restorePurchases()
            }
        }
    }
}
