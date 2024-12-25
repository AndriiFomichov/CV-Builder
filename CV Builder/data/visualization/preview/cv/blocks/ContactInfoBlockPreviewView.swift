//
//  ContactInfoBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct ContactInfoBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var headerTextColor: String
    var mainTextColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var iconColor: String
    var iconBackgroundColor: String
    var iconStrokeColor: String
    
    var addBlockPadding: Bool = false
    
    var body: some View {
        if let block = cv.contactBlock {
            BlockContainerPreviewView(isMainBlock: block.isMainBlock, marginsSize: cv.marginsSize, text: block.textContact, font: cv.headersFont, textColor: headerTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: block.styleHeaderPosition, headerDotAdded: cv.headerDotAdded, headerLineAdded: cv.headerLineAdded, dotColor: dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, linePosition: cv.headerLinePosition, lineColor: lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addBlockPadding: addBlockPadding) {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: CGFloat(cv.marginsSize / 3)) {
                    ForEach (0...2, id: \.self) { index in
                        if index == 0 && !block.email.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: block, text: block.email, icon: "envelope.fill", mainTextColor: mainTextColor, iconColor: iconColor, iconBackgroundColor: iconBackgroundColor, iconStrokeColor: iconStrokeColor)
                        } else if index == 1 && !block.phone.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: block, text: block.phone, icon: "phone.fill", mainTextColor: mainTextColor, iconColor: iconColor, iconBackgroundColor: iconBackgroundColor, iconStrokeColor: iconStrokeColor)
                        } else if index == 2 && !block.websiteLink.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: block, text: block.websiteLink, icon: "globe", mainTextColor: mainTextColor, iconColor: iconColor, iconBackgroundColor: iconBackgroundColor, iconStrokeColor: iconStrokeColor)
                        }
                    }
                }
                
            }
        }
    }
}

struct ContactInfoItemPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var block: ContactInfoBlockEntityWrapper
    var text: String
    var icon: String
    
    var mainTextColor: String
    
    var iconColor: String
    var iconBackgroundColor: String
    var iconStrokeColor: String
    
    var body: some View {
        HStack (spacing: 0) {
            
            if block.styleIconAdded {
                IconPreviewView(iconName: icon, size: cv.iconSize, font: cv.textFont, isBold: cv.iconIsBold, foregroundColor: iconColor, backgroundColor: iconBackgroundColor, cornersRadius: CGFloat(cv.cornersRadius), strokeWidth: cv.strokeWidth, strokeColor: iconStrokeColor, backAdded: cv.iconBackAdded, strokeAdded: cv.iconStrokeAdded).padding(.trailing, CGFloat(cv.marginsSize / 3))
            }
            
            TextPreviewView(text: text, font: cv.textFont, color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    ContactInfoBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "", iconColor: "", iconBackgroundColor: "", iconStrokeColor: "")
}
