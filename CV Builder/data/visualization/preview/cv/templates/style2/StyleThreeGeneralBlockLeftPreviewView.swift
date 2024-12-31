//
//  StyleThreeGeneralBlockLeftPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.12.2024.
//

import SwiftUI

struct StyleThreeGeneralBlockLeftPreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack (spacing: CGFloat(cv.marginsSize * 2)) {
            
            StyleThreeGeneralBlockTopPreviewView(cv: cv, text: cv.textResume)
            
            VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                if let generalBlock = cv.generalBlock {
                    
                    if !generalBlock.name.isEmpty {
                        TextPreviewView(text: generalBlock.name, font: cv.nameFont, color: cv.headerTextColor, gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                    }
                    
                    if !generalBlock.jobTitle.isEmpty {
                        TextPreviewView(text: generalBlock.jobTitle, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased).opacity(0.8)
                    }
                    
                    if !generalBlock.location.isEmpty {
                        TextPreviewView(text: generalBlock.location, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.6)
                    }
                }
                
            }
        }
    }
}

struct StyleThreeGeneralBlockTopPreviewView: View {
    
    var cv: CVEntityWrapper
    var text: String
    
    var body: some View {
        HStack (spacing: 0) {
            
            TextPreviewView(text: text, font: cv.headersFont, color: "#FFFFFF", gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, isInfinite: false).padding(CGFloat(cv.marginsSize / 3)).padding(.trailing, CGFloat(cv.marginsSize * 2)).background() {
                RoundedRectangle(cornerRadius: CGFloat(cv.cornersRadius)).fill(Color(hex: cv.mainColor))
            }
            
            ZStack (alignment: .bottom) {
                Color.clear
                RoundedRectangle(cornerRadius: CGFloat(cv.cornersRadius)).fill(Color(hex: cv.lineColor)).frame(height: CGFloat(cv.lineWidth))
            }
            
        }.fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    StyleThreeGeneralBlockLeftPreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
