//
//  ContentItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import Foundation

class ContentItem {
    
    var enitityId: String
    var blockId: Int
    var position: Int
    var header: String
    var description: String
    var text: String
    var isLoading: Bool
    
    init(enitityId: String, blockId: Int, position: Int, header: String, description: String, text: String, isLoading: Bool) {
        self.enitityId = enitityId
        self.blockId = blockId
        self.position = position
        self.header = header
        self.description = description
        self.text = text
        self.isLoading = isLoading
    }
    
    static func getDefault () -> ContentItem {
        return ContentItem(enitityId: "0", blockId: 0, position: 0, header: "Header", description: "Description", text: "Your text", isLoading: false)
    }
}
