//
//  StyleOneCoverPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 03.12.2024.
//

import SwiftUI

struct StyleOneCoverPreviewView: View {
    
    var cv: CVEntityWrapper
    let textChangeHandler: (_ text: String) -> Void
    var isDisabled: Bool = false
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        VStack {
            
            if let coverLetter = cv.coverLetter {
                TextFieldPreviewView(initialText: coverLetter.text, font: getFontByStyle(), color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isDisabled: isDisabled, textChangeHandler: textChangeHandler).padding(CGFloat(cv.marginsSize))
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
    StyleOneCoverPreviewView(cv: CVEntityWrapper.getDefault(), textChangeHandler: { t in })
}
