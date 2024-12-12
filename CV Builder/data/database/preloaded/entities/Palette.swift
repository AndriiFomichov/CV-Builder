//
//  Palette.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 10.12.2024.
//

import Foundation

class Palette {
    
    var mainColor: String
    
    var headerTextColor: String
    var mainTextColor: String
    
    var iconColor: String
    var iconBackgroundColor: String
    var iconStrokeColor: String
    
    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var qrForegroundColor: String
    var qrBackgroundColor: String
    
    var progressForegroundColor: String
    var progressBackgroundColor: String
    
    var chipTextColor: String
    var chipBackgroundColor: String
    var chipStrokeColor: String
    
    init(mainColor: String, headerTextColor: String, mainTextColor: String, iconColor: String, iconBackgroundColor: String, iconStrokeColor: String, lineColor: String, lineCirclesColor: String, dotColor: String, dotStrokeColor: String, qrForegroundColor: String, qrBackgroundColor: String, progressForegroundColor: String, progressBackgroundColor: String, chipTextColor: String, chipBackgroundColor: String, chipStrokeColor: String) {
        self.mainColor = mainColor
        self.headerTextColor = headerTextColor
        self.mainTextColor = mainTextColor
        self.iconColor = iconColor
        self.iconBackgroundColor = iconBackgroundColor
        self.iconStrokeColor = iconStrokeColor
        self.lineColor = lineColor
        self.lineCirclesColor = lineCirclesColor
        self.dotColor = dotColor
        self.dotStrokeColor = dotStrokeColor
        self.qrForegroundColor = qrForegroundColor
        self.qrBackgroundColor = qrBackgroundColor
        self.progressForegroundColor = progressForegroundColor
        self.progressBackgroundColor = progressBackgroundColor
        self.chipTextColor = chipTextColor
        self.chipBackgroundColor = chipBackgroundColor
        self.chipStrokeColor = chipStrokeColor
    }
}
