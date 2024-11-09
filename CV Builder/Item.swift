//
//  Item.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 09.11.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
