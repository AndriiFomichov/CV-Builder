//
//  GuideItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation

class GuideItem {
    
    var header: String
    var description: String
    var tip: String
    var illustration: String
    var lineIllustration: String
    var isHeaderHighlighted: Bool
    var isHeaderLarge: Bool
    var alignment: Int
    
    init(header: String, description: String, tip: String, illustration: String, lineIllustration: String, isHeaderHighlighted: Bool, isHeaderLarge: Bool, alignment: Int) {
        self.header = header
        self.description = description
        self.tip = tip
        self.illustration = illustration
        self.lineIllustration = lineIllustration
        self.isHeaderHighlighted = isHeaderHighlighted
        self.isHeaderLarge = isHeaderLarge
        self.alignment = alignment
    }
    
    static func getDefault () -> GuideItem {
        return GuideItem(header: "Header", description: "description", tip: "tip", illustration: "tip_job_speicific_one_illustration", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: true, isHeaderLarge: false, alignment: 0)
    }
}
