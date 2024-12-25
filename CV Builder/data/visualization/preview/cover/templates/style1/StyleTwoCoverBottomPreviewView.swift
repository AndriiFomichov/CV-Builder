//
//  StyleTwoCoverBottomPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.12.2024.
//

import SwiftUI

struct StyleTwoCoverBottomPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var body: some View {
        if let block = cv.contactBlock {
            VStack (spacing: CGFloat(cv.marginsSize)) {
                
                LinePreviewView(color: cv.lineColor, width: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), orientation: 0, dotAdded: cv.lineCirclesAdded, dotBackColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: CGFloat(cv.marginsSize / 3)) {
                    ForEach (0...2, id: \.self) { index in
                        if index == 0 {
                            ContactInfoItemPreviewView(cv: cv, block: block, text: block.email, icon: "envelope.fill", mainTextColor: cv.mainTextColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        } else if index == 1 {
                            ContactInfoItemPreviewView(cv: cv, block: block, text: block.phone, icon: "phone.fill", mainTextColor: cv.mainTextColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        } else if index == 2 {
                            ContactInfoItemPreviewView(cv: cv, block: block, text: block.websiteLink, icon: "globe", mainTextColor: cv.mainTextColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StyleTwoCoverBottomPreviewView(cv: CVEntityWrapper.getDefault())
}
