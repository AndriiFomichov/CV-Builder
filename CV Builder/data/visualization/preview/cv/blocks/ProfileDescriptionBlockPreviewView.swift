//
//  ProfileDescriptionBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct ProfileDescriptionBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    var headerTextColor: String
    var mainTextColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String

    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var addDivider: Bool = false
    var addBlockPadding: Bool = false
    var addBottomPadding: Bool = false
    
    var body: some View {
        if let block = cv.profileDescBlock {
            BlockContainerPreviewView(isMainBlock: block.isMainBlock, marginsSize: cv.marginsSize, text: block.textAboutMe, font: cv.headersFont, textColor: headerTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: block.styleHeaderPosition, headerDotAdded: cv.headerDotAdded, headerLineAdded: cv.headerLineAdded, dotColor: dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, linePosition: cv.headerLinePosition, lineColor: lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addDivider: addDivider, addBlockPadding: addBlockPadding, addBottomPadding: addBottomPadding) {
                
                TextPreviewView(text: block.profileDescription, font: cv.textFont, color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
                
            }.overlay {
                if block.styleQuotesAdded && !block.isMainBlock {
                    VStack {
                        HStack {
                            IconPreviewView(iconName: "quote.closing", size: 16, font: cv.textFont, isBold: false, foregroundColor: cv.mainColor, backgroundColor: "", cornersRadius: 0.0, strokeWidth: 0, strokeColor: "", backAdded: false, strokeAdded: false).offset(x: -4, y: -4)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            IconPreviewView(iconName: "quote.closing", size: 16, font: cv.textFont, isBold: false, foregroundColor: cv.mainColor, backgroundColor: "", cornersRadius: 0.0, strokeWidth: 0, strokeColor: "", backAdded: false, strokeAdded: false).offset(x: 4, y: addBottomPadding ? -6 : 4)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    ProfileDescriptionBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "")
}
