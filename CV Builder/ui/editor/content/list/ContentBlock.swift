//
//  ContentBlock.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import Foundation

class ContentBlock {
    
    var blockId: Int
    var name: String
    var icon: String
    var text: String
    var isTextAdded: Bool
    var items: [ContentItem]
    var position: Int
    var isMainBlock: Bool
    var isAdded: Bool
    var isLoading: Bool
    
    init(blockId: Int, name: String, icon: String, text: String, isTextAdded: Bool, items: [ContentItem], position: Int, isMainBlock: Bool, isAdded: Bool, isLoading: Bool) {
        self.blockId = blockId
        self.name = name
        self.icon = icon
        self.text = text
        self.isTextAdded = isTextAdded
        self.items = items
        self.position = position
        self.isMainBlock = isMainBlock
        self.isAdded = isAdded
        self.isLoading = isLoading
    }
    
    static func getDefault () -> ContentBlock {
        return ContentBlock(blockId: 0, name: "Profile", icon: "gear", text: "Text", isTextAdded: false, items: [ ContentItem.getDefault(), ContentItem.getDefault() ], position: 0, isMainBlock: true, isAdded: true, isLoading: false)
    }
}
