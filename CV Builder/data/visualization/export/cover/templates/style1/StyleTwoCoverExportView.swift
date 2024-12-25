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
        VStack (spacing: CGFloat(cv.marginsSize * 2)) {
            
            StyleTwoCoverHeaderPreviewView(cv: cv, width: width, height: height)
            
            ZStack (alignment: .top) {
                Color.clear
                if let coverLetter = cv.coverLetter {
                    TextPreviewView(text: coverLetter.text, font: cv.textFont, color: cv.mainTextColor, gravity: .topLeading, size: coverLetter.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
                }
            }
            
            StyleTwoCoverBottomPreviewView(cv: cv)
            
        }.padding(CGFloat(cv.marginsSize * 2)).contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: cv.mainColor)
        }
    }
}

#Preview {
    StyleTwoCoverExportView(cv: CVEntityWrapper.getDefault())
}
