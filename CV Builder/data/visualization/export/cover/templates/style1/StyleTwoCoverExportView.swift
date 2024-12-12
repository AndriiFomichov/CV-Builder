//
//  StyleTwoCoverExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct StyleTwoCoverExportView: View {
    
    var cv: CVEntityWrapper
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        VStack {
            
            if let coverLetter = cv.coverLetter {
                TextPreviewView(text: coverLetter.text, font: getFontByStyle(), color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).padding(CGFloat(cv.marginsSize * 2))
            }
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: cv.mainColor)
        }
    }
    
    private func getFontByStyle () -> String {
        return PreloadedDatabase.getFontId(id: cv.textFont).name
    }
}

#Preview {
    StyleTwoCoverExportView(cv: CVEntityWrapper.getDefault())
}
