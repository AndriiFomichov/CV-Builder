//
//  StyleTwoGeneralBlockLeftPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct StyleTwoGeneralBlockLeftPreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if let generalBlock = cv.generalBlock {
            VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                
                if !generalBlock.name.isEmpty {
                    TextPreviewView(text: generalBlock.name, font: cv.nameFont, color: cv.headerTextColor, gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                }
                
                if !generalBlock.jobTitle.isEmpty {
                    TextPreviewView(text: generalBlock.jobTitle, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased).opacity(0.8)
                }
                
                if !generalBlock.location.isEmpty {
                    TextPreviewView(text: generalBlock.location, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                }
                
            }
        }
    }
}

#Preview {
    StyleTwoGeneralBlockLeftPreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
