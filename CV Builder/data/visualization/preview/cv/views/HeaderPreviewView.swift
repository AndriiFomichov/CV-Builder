//
//  HeaderPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 07.12.2024.
//

import SwiftUI

struct HeaderPreviewView: View {
    
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
    
    var marginsSize: Int
    
    var body: some View {
        if headerPosition == 1 {
            HeaderVerticalPreviewView(text: text, font: font, textColor: textColor, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, headerDotAdded: headerDotAdded, headerLineAdded: headerLineAdded, dotColor: dotColor, dotSize: dotSize, dotBackAdded: dotBackAdded, dotStrokeAdded: dotStrokeAdded, strokeWidth: strokeWidth, strokeColor: strokeColor, linePosition: linePosition, lineColor: lineColor, lineCirclesAdded: lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: lienWidth, cornersRadius: cornersRadius, marginsSize: marginsSize)
        } else {
            HeaderHorizontalPreviewView(text: text, font: font, textColor: textColor, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, headerPosition: headerPosition, headerDotAdded: headerDotAdded, headerLineAdded: headerLineAdded, dotColor: dotColor, dotSize: dotSize, dotBackAdded: dotBackAdded, dotStrokeAdded: dotStrokeAdded, strokeWidth: strokeWidth, strokeColor: strokeColor, linePosition: linePosition, lineColor: lineColor, lineCirclesAdded: lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: lienWidth, cornersRadius: cornersRadius, marginsSize: marginsSize)
        }
//        HeaderHorizontalPreviewView(text: text, font: font, textColor: textColor, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, headerPosition: headerPosition, headerDotAdded: headerDotAdded, headerLineAdded: headerLineAdded, dotColor: dotColor, dotSize: dotSize, dotBackAdded: dotBackAdded, dotStrokeAdded: dotStrokeAdded, strokeWidth: strokeWidth, strokeColor: strokeColor, linePosition: linePosition, lineColor: lineColor, lineCirclesAdded: lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: lienWidth, cornersRadius: cornersRadius, marginsSize: marginsSize)
    }
}

struct HeaderVerticalPreviewView: View {
    
    var text: String
    var font: Int
    var textColor: String
    var gravity: Alignment
    var size: Int
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool
    var isUppercased: Bool
    
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
    
    var marginsSize: Int
    
    var body: some View {
        VerticalLayout {
            
            HStack (spacing: CGFloat(marginsSize)) {
                
                if headerDotAdded {
                    DotPreviewView(color: dotColor, width: dotSize, height: dotSize, strokeWidth: strokeWidth, strokeColor: strokeColor, backAdded: dotBackAdded, strokeAdded: dotStrokeAdded)
                }
                
                TextPreviewView(text: text, font: font, color: textColor, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, isInfinite: false)
            }
            
        }.rotationEffect(Angle(degrees: -90))
    }
}

struct VerticalLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let size = subviews.first!.sizeThatFits(.unspecified)
        return .init(width: size.height, height: size.width)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        subviews.first!.place(at: .init(x: bounds.midX, y: bounds.midY), anchor: .center, proposal: .unspecified)
    }
}

struct HeaderHorizontalPreviewView: View {
    
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
    
    var marginsSize: Int
    
    var body: some View {
        VStack (alignment: .leading, spacing: CGFloat(marginsSize)) {
            
            HStack (alignment: .center, spacing: CGFloat(marginsSize)) {
                if headerDotAdded {
                    DotPreviewView(color: dotColor, width: dotSize, height: dotSize, strokeWidth: strokeWidth, strokeColor: strokeColor, backAdded: dotBackAdded, strokeAdded: dotStrokeAdded)
                }
                
                TextPreviewView(text: text, font: font, color: textColor, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, isInfinite: false)
                
                Spacer().overlay {
                    if headerLineAdded && linePosition == 0 {
                        LinePreviewView(color: lineColor, width: lienWidth, cornersRadius: cornersRadius, orientation: 0, dotAdded: lineCirclesAdded, dotBackColor: dotColor, dotStrokeColor: strokeColor, dotBackAdded: dotBackAdded, dotStrokeAdded: dotStrokeAdded)
                    }
                }
            }
            
            if headerLineAdded && linePosition == 1 {
                LinePreviewView(color: lineColor, width: lienWidth, cornersRadius: cornersRadius, orientation: 0, dotAdded: lineCirclesAdded, dotBackColor: dotColor, dotStrokeColor: strokeColor, dotBackAdded: dotBackAdded, dotStrokeAdded: dotStrokeAdded)
            }
        }
    }
}

#Preview {
    HeaderPreviewView(text: "My text own ewdewf efwfewfewefewffwe wef34535 3454534 345455334", font: 0, textColor: "#000CA0", gravity: .leading, size: 14, isBold: true, isItalic: false, isUnderline: true, isUppercased: true, headerPosition: 1, headerDotAdded: true, headerLineAdded: true, dotColor: "#CF45CA", dotSize: 10, dotBackAdded: true, dotStrokeAdded: true, strokeWidth: 1, strokeColor: "#000CA0", linePosition: 0, lineColor: "#000CA0", lineCirclesAdded: false, lineCirclesColor: "#CF45CA", lienWidth: 2, cornersRadius: 12.0, marginsSize: 8)
}
