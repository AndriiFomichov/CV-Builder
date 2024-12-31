//
//  StyleThreeBottomPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.12.2024.
//

import SwiftUI

struct StyleThreeBottomPreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        HStack (spacing: 0) {
            
            IconPreviewView(iconName: "checkmark.seal.fill", size: cv.textSize, font: cv.textFont, isBold: false, foregroundColor: "#FFFFFF", backgroundColor: cv.iconBackgroundColor, cornersRadius: CGFloat(cv.cornersRadius), strokeWidth: cv.strokeWidth, strokeColor: cv.iconStrokeColor, backAdded: cv.iconBackAdded, strokeAdded: cv.iconStrokeAdded).padding(CGFloat(cv.marginsSize / 3)).padding(.bottom, CGFloat(cv.marginsSize / 2)).background() {
                RoundedRectangle(cornerRadius: CGFloat(cv.cornersRadius)).fill(Color(hex: cv.mainColor))
            }
            
            ZStack (alignment: .top) {
                Color.clear
                RoundedRectangle(cornerRadius: CGFloat(cv.cornersRadius)).fill(Color(hex: cv.lineColor)).frame(height: CGFloat(cv.lineWidth))
            }
            
        }.fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    StyleThreeBottomPreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
