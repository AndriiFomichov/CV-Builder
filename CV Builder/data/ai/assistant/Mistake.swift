//
//  Mistake.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class Mistake {
    
    var blockId: Int
    var blockName: String
    var textPrevious: String
    var textNew: String
    var textNewUpdateIndexs: [Int]
    
    init(blockId: Int, blockName: String, textPrevious: String, textNew: String,textNewUpdateIndexs: [Int]) {
        self.blockId = blockId
        self.blockName = blockName
        self.textPrevious = textPrevious
        self.textNew = textNew
        self.textNewUpdateIndexs = textNewUpdateIndexs
    }
    
    static func getDefault () -> Mistake {
        return Mistake(blockId: 0, blockName: "Profile description", textPrevious: "My own tetx", textNew: "My own text", textNewUpdateIndexs: [9,10])
    }
}
