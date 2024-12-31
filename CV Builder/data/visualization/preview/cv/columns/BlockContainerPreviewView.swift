//
//  BlockContainerPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 09.12.2024.
//

import SwiftUI

struct BlockContainerPreviewView<Content: View>: View {
    
    var isMainBlock: Bool
    var marginsSize: Int
    
    var text: String
    var font: Int
    var textColor: String
    var gravity: Alignment
    var size: Int
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool
    var isUppercased: Bool
    
    var headerPosition: Int
    var headerDotAdded: Bool
    var headerLineAdded: Bool
    
    var dotColor: String
    var dotSize: Int
    var dotBackAdded: Bool
    var dotStrokeAdded: Bool
    
    var strokeWidth: Int
    var strokeColor: String
    
    var linePosition: Int
    var lineColor: String
    var lineCirclesAdded: Bool
    var lineCirclesColor: String
    var lienWidth: Int
    
    var cornersRadius: CGFloat
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var addDivider: Bool
    var addBlockPadding: Bool
    var addBottomPadding: Bool
    
    let content: () -> Content
    
    var body: some View {
        VStack (spacing: 0) {
            
            HStack (spacing: 0) {
                
                if headerPosition == 1 && isMainBlock {
                    HeaderPreviewView(text: text, font: font, textColor: textColor, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, headerPosition: headerPosition, headerDotAdded: headerDotAdded, headerLineAdded: headerLineAdded, dotColor: dotColor, dotSize: dotSize, dotBackAdded: dotBackAdded, dotStrokeAdded: dotStrokeAdded, strokeWidth: strokeWidth, strokeColor: strokeColor, linePosition: linePosition, lineColor: lineColor, lineCirclesAdded: lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: lienWidth, cornersRadius: cornersRadius, marginsSize: marginsSize).padding(.trailing, CGFloat(marginsSize / 2))
                }
                
                VStack (spacing: 0) {
                    
                    if headerPosition == 0 || headerPosition == 1 && !isMainBlock {
                        HeaderPreviewView(text: text, font: font, textColor: textColor, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, headerPosition: 0, headerDotAdded: headerDotAdded, headerLineAdded: headerLineAdded, dotColor: dotColor, dotSize: dotSize, dotBackAdded: dotBackAdded, dotStrokeAdded: dotStrokeAdded, strokeWidth: strokeWidth, strokeColor: strokeColor, linePosition: linePosition, lineColor: lineColor, lineCirclesAdded: lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: lienWidth, cornersRadius: cornersRadius, marginsSize: marginsSize).padding(.bottom, CGFloat(marginsSize / 3))
                    }
                    
                    content()
                }
            }
            
            if addDivider {
                RoundedRectangle(cornerRadius: cornersRadius).fill(Color(hex: lineColor)).frame(height: CGFloat(lienWidth)).padding(.top, CGFloat(marginsSize))
            }
            
        }.padding(CGFloat(addBlockPadding ? marginsSize : 0)).background() {
            if !blockBackgroundColor.isEmpty {
                RoundedRectangle(cornerRadius: CGFloat(0)).fill(Color(hex: blockBackgroundColor))
            }
        }.overlay {
            if !blockStrokeColor.isEmpty {
                RoundedRectangle(cornerRadius: CGFloat(0)).fill(.clear).stroke(Color(hex: blockStrokeColor), style: StrokeStyle(lineWidth: CGFloat(strokeWidth)))
            }
        }.padding(.bottom, CGFloat(addBottomPadding ? marginsSize : 0))
    }
}

#Preview {
    BlockContainerPreviewView (isMainBlock: true, marginsSize: 12, text: "My text own", font: 0, textColor: "#000CA0", gravity: .leading, size: 14, isBold: true, isItalic: false, isUnderline: true, isUppercased: true, headerPosition: 0, headerDotAdded: false, headerLineAdded: false, dotColor: "", dotSize: 10, dotBackAdded: true, dotStrokeAdded: true, strokeWidth: 1, strokeColor: "#000CA0", linePosition: 0, lineColor: "#000CA0", lineCirclesAdded: false, lineCirclesColor: "#CF45CA", lienWidth: 2, cornersRadius: 12.0, blockBackgroundColor: "", blockStrokeColor: "", addDivider: true, addBlockPadding: true, addBottomPadding: true, content: {  HStack{} })
}
