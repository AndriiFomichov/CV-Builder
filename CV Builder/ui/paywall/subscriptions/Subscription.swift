//
//  Subscription.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import StoreKit

class Subscription: Identifiable {
    
    var id: UUID = UUID()
    var position: Int
    var price: String
    var freeTrial: String?
    var period: String
    var saveAmount: String?
    var isSelected: Bool
    var product: Product?
    
    init(position: Int, price: String, freeTrial: String? = nil, period: String, saveAmount: String? = nil, isSelected: Bool, product: Product?) {
        self.position = position
        self.price = price
        self.freeTrial = freeTrial
        self.period = period
        self.saveAmount = saveAmount
        self.isSelected = isSelected
        self.product = product
    }
    
    static func getDefault () -> Subscription {
        return Subscription(position: 0, price: "$4,99", freeTrial: "7 days free trial, then", period: "Yearly", saveAmount: "Save 45%", isSelected: true, product: nil)
    }
}
