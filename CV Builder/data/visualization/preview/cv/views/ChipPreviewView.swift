//
//  ChipPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct ChipPreviewView: View {
    
    var text: String
    var font: String
    var color: String
    var gravity: Alignment
    var size: Int
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool
    var isUppercased: Bool
    
    var marginsSize: Int
    var cornersRadius: Int
    
    var backColor: String
    var backAdded: Bool
    
    var strokeWidth: Int
    var strokeColor: String
    var strokeAdded: Bool
    
    var body: some View {
        HStack (spacing: 0) {
            TextPreviewView(text: text, font: font, color: color, gravity: gravity, size: size, isBold: isBold, isItalic: isItalic, isUnderline: isUnderline, isUppercased: isUppercased, isInfinite: false).padding(.vertical, CGFloat(marginsSize / 3)).padding(.horizontal, CGFloat(marginsSize / 2))
        }.background() {
            RoundedRectangle(cornerRadius: CGFloat(cornersRadius)).fill(backAdded ? Color(hex: backColor) : Color.clear).stroke(!strokeColor.isEmpty && strokeAdded ? Color(hex: strokeColor) : Color.clear, style: StrokeStyle(lineWidth: CGFloat(strokeWidth)))
        }
    }
}

#Preview {
    ChipPreviewView(text: "My text own", font: "Roboto Mono", color: "#000CA0", gravity: .leading, size: 14, isBold: true, isItalic: false, isUnderline: true, isUppercased: true, marginsSize: 14, cornersRadius: 14, backColor: "", backAdded: true, strokeWidth: 3, strokeColor: "", strokeAdded: true)
}
