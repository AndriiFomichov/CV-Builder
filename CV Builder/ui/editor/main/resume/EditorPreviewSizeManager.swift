//
//  EditorPreviewSizeManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 04.12.2024.
//

import Foundation

class EditorPreviewSizeManager {
    
    static func getFinalWidth (geoWidth: CGFloat, geoHeight: CGFloat, margin: CGFloat = 0.0) -> CGFloat {
        if geoWidth / (geoHeight - margin) < 0.707070707 {
            return geoWidth
        } else {
            return geoHeight * 0.707070707
        }
    }
    
    static func getFinalHeight (geoWidth: CGFloat, geoHeight: CGFloat, margin: CGFloat = 0.0) -> CGFloat {
        if geoWidth / (geoHeight - margin) < 0.707070707 {
            return geoWidth * 1.41429316
        } else {
            return geoHeight - margin
        }
    }
    
}
