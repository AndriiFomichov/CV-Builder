//
//  StyleFourCoverPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleFourCoverPreviewView: View {
    
    var cv: CVEntityWrapper
    let textChangeHandler: (_ text: String) -> Void
    var isDisabled: Bool = false
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        HStack (spacing: 0) {
            
            VStack (spacing: CGFloat(cv.marginsSize * 2)) {
                
                if let coverLetter = cv.coverLetter {
                    ZStack (alignment: .center) {
                        Color.clear
                        TextFieldPreviewView(initialText: coverLetter.text, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: coverLetter.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isDisabled: isDisabled, textChangeHandler: textChangeHandler)
                    }
                    
                    HeaderHorizontalPreviewView(text: coverLetter.textCoverLetter, font: cv.headersFont, textColor: cv.headerTextColor, gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: 0, headerDotAdded: cv.headerDotAdded, headerLineAdded: false, dotColor: cv.dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: cv.dotStrokeColor, linePosition: 0, lineColor: cv.lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: cv.lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), marginsSize: cv.marginsSize)
                }
               
            }.padding(CGFloat(cv.marginsSize * 2)).padding(.vertical, CGFloat(cv.marginsSize))
            
            StyleFourCoverSidePreviewView(cv: cv, width: width, height: height).frame(width: width * 0.3)
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#EDEDEF")
        }
    }
}

#Preview {
    StyleFourCoverPreviewView(cv: CVEntityWrapper.getDefault(), textChangeHandler: { t in })
}