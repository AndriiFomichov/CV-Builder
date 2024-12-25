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
        HStack (spacing: 0) {
            
            StyleOneCoverSidePreviewView(cv: cv, width: width, height: height).frame(width: width * 0.3)
            
            VStack (spacing: CGFloat(cv.marginsSize * 2)) {
                
                if let coverLetter = cv.coverLetter {
                    HeaderHorizontalPreviewView(text: coverLetter.textCoverLetter, font: cv.headersFont, textColor: cv.headerTextColor, gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: 0, headerDotAdded: cv.headerDotAdded, headerLineAdded: false, dotColor: cv.dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: cv.dotStrokeColor, linePosition: 0, lineColor: cv.lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: cv.lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), marginsSize: cv.marginsSize)
                    
                    ZStack (alignment: .top) {
                        TextFieldPreviewView(initialText: coverLetter.text, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: coverLetter.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isDisabled: isDisabled, textChangeHandler: textChangeHandler)
                    }
                }
               
            }.padding(CGFloat(cv.marginsSize)).padding(.vertical, CGFloat(cv.marginsSize))
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#F5F5F5")
        }
    }
}

#Preview {
    StyleOneCoverPreviewView(cv: CVEntityWrapper.getDefault(), textChangeHandler: { t in })
}
