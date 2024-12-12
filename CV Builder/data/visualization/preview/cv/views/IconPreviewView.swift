//
//  IconPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 06.12.2024.
//

import SwiftUI

struct IconPreviewView: View {
    
    var iconName: String
    var size: Int
    var font: String
    var isBold: Bool
    var foregroundColor: String
    var backgroundColor: String
    var cornersRadius: CGFloat
    var strokeWidth: Int
    var strokeColor: String
    
    var backAdded: Bool
    var strokeAdded: Bool
    
    var body: some View {
        ZStack {
            if backAdded {
                RoundedRectangle(cornerRadius: cornersRadius).fill(Color(hex: backgroundColor)).stroke(strokeAdded ? Color(hex: strokeColor) : .clear, style: StrokeStyle(lineWidth: CGFloat(strokeWidth)))
            }
            
            Image(systemName: iconName).font(SwiftUI.Font.custom(NSLocalizedString(font, comment: ""), size: backAdded ? CGFloat(size) * 0.7 : CGFloat(size))).foregroundStyle(Color(hex: foregroundColor)).bold(isBold)
            
        }.frame(width: CGFloat(size) * 1.5, height: CGFloat(size) * 1.5)
    }
}

#Preview {
    IconPreviewView(iconName: "gear", size: 24, font: "Roboto", isBold: true, foregroundColor: "#CA4545", backgroundColor: "#ACFFFF", cornersRadius: 12, strokeWidth: 1, strokeColor: "#CA1212", backAdded: true, strokeAdded: true)
}
