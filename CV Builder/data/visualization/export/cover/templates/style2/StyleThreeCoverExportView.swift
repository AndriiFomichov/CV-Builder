//
//  StyleThreeCoverExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleThreeCoverExportView: View {
    
    var cv: CVEntityWrapper
    var addWatermark: Bool
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        VStack (spacing: CGFloat(cv.marginsSize * 2)) {
            
            HStack (spacing: CGFloat(cv.marginsSize)) {
                
                VStack (spacing: CGFloat(cv.marginsSize * 2)) {

                    if let coverLetter = cv.coverLetter {
                        
                        StyleThreeGeneralBlockTopPreviewView(cv: cv, text: coverLetter.textCoverLetter)
                        
                        ZStack (alignment: .top) {
                            Color.clear
                            TextPreviewView(text: coverLetter.text, font: cv.textFont, color: cv.mainTextColor, gravity: .topLeading, size: coverLetter.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
                        }
                    }
                }
                
                StyleThreeCoverSidePreviewView(cv: cv, width: width, height: height).frame(width: width * 0.3)
                
            }.frame(width: (width - CGFloat(cv.marginsSize * 4)))
            
            StyleThreeBottomPreviewView(cv: cv, width: width, height: height).frame(width: (width - CGFloat(cv.marginsSize * 4)))
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#F3F5F7")
        }.overlay {
            WatermarkView(added: addWatermark)
        }
    }
}

#Preview {
    StyleThreeCoverExportView(cv: CVEntityWrapper.getDefault(), addWatermark: true)
}
