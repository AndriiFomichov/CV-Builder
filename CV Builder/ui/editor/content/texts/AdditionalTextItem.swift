//
//  AdditionalTextItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.12.2024.
//

import Foundation

class AdditionalTextItem {
    
    var id: Int
    var textInitial: String
    var text: String
    var icon: String
    
    init(id: Int, text: String, icon: String) {
        self.id = id
        self.textInitial = text
        self.text = text
        self.icon = icon
    }
    
    static func getDefault () -> AdditionalTextItem {
        return AdditionalTextItem(id: 0, text: "Text", icon: "gear")
    }
}
