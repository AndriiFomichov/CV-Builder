//
//  CustomActionInfo.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.12.2024.
//

import Foundation

class CustomActionInfo {
    
    var text: String
    var block: ContentBlock?
    var item: ContentItem?
    var action: Int
    var index: Int
    var itemIndex: Int
    var isMain: Bool
    
    init() {
        self.text = ""
        self.block = nil
        self.item = nil
        self.action = -1
        self.index = -1
        self.itemIndex = -1
        self.isMain = true
    }
    
    init(text: String, block: ContentBlock? = nil, item: ContentItem? = nil, action: Int, index: Int, itemIndex: Int = -1, isMain: Bool) {
        self.text = text
        self.block = block
        self.item = item
        self.action = action
        self.index = index
        self.itemIndex = itemIndex
        self.isMain = isMain
    }
}
