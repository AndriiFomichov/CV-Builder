//
//  StyleTwoCoverPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct StyleTwoCoverPreviewView: View {
    
    var cv: CVEntityWrapper
    let textChangeHandler: (_ text: String) -> Void
    var isDisabled: Bool = false
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        VStack {
            
            if let coverLetter = cv.coverLetter {
                TextFieldPreviewView(initialText: coverLetter.text, font: getFontByStyle(), color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isDisabled: isDisabled, textChangeHandler: textChangeHandler).padding(CGFloat(cv.marginsSize * 2))
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
    StyleTwoCoverPreviewView(cv: CVEntityWrapper.getDefault(), textChangeHandler: { t in })
}
