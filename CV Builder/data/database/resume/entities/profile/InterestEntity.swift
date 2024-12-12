//
//  InterestEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation
import SwiftData

@Model
class InterestEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var name: String
    
    var position: Int
    
    init(name: String, position: Int) {
        self.name = name
        self.position = position
    }
}
