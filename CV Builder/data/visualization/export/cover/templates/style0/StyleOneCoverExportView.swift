//
//  StyleOneCoverExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct StyleOneCoverExportView: View {

    var cv: CVEntityWrapper
    
    var width: CGFloat = 520.0
    var height: CGFloat = 800.0
    
    var body: some View {
        VStack {
            
            if let coverLetter = cv.coverLetter {
                TextPreviewView(text: coverLetter.text, font: getFontByStyle(), color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).padding(CGFloat(cv.marginsSize))
            }
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#F5F5F5")
        }
    }
    
    private func getFontByStyle () -> String {
        return PreloadedDatabase.getFontId(id: cv.textFont).name
    }
}

#Preview {
    StyleOneCoverExportView(cv: CVEntityWrapper.getDefault())
}
