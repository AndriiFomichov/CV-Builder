//
//  CertificatesBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct CertificatesBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var headerTextColor: String
    var mainTextColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var addBlockPadding: Bool = false
    
    var body: some View {
        if let block = cv.certificatesBlock {
            BlockContainerPreviewView(isMainBlock: block.isMainBlock, marginsSize: cv.marginsSize, text: block.textLanguages, font: getFontByStyle(cv.headersFont), textColor: headerTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: block.styleHeaderPosition, headerDotAdded: cv.headerDotAdded, headerLineAdded: cv.headerLineAdded, dotColor: dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, linePosition: cv.headerLinePosition, lineColor: lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addBlockPadding: addBlockPadding) {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: CGFloat(cv.marginsSize / 3)) {
                    ForEach(0..<block.list.count, id:\.self) { item in
                        CertificatesItemPreviewView(cv: cv, block: block, item: block.list[item], mainTextColor: mainTextColor, dotColor: dotColor, dotStrokeColor: dotStrokeColor)
                    }
                }
                
            }
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

struct CertificatesItemPreviewView: View {
    
    var cv: CVEntityWrapper
    var block: CertificatesBlockEntityWrapper
    var item: CertificateBlockItemEntityWrapper
    
    var mainTextColor: String
    
    var dotColor: String
    var dotStrokeColor: String
    
    var body: some View {
        HStack (spacing: CGFloat(cv.marginsSize / 3)) {
            if block.styleIsBulletedList {
                DotPreviewView(color: dotColor, width: cv.dotSize, height: cv.dotSize, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, backAdded: cv.dotBackAdded, strokeAdded: cv.dotStrokeAdded)
            }
            
            TextPreviewView(text: item.name, font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    CertificatesBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "")
}
