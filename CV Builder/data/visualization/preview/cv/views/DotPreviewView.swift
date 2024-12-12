//
//  DotPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 06.12.2024.
//

import SwiftUI

struct DotPreviewView: View {
    
    var color: String
    var width: Int
    var height: Int
    
    var strokeWidth: Int
    var strokeColor: String
    
    var backAdded: Bool
    var strokeAdded: Bool
    
    var body: some View {
        Circle().fill(!color.isEmpty && backAdded ? Color(hex: color) : .clear).stroke(!strokeColor.isEmpty && strokeAdded ? Color(hex: strokeColor) : .clear, style: StrokeStyle(lineWidth: CGFloat(strokeWidth))).frame(width: CGFloat(width), height: CGFloat(height))
    }
}

#Preview {
    DotPreviewView(color: "#FFFFFF", width: 4, height: 4, strokeWidth: 1, strokeColor: "#000000", backAdded: true, strokeAdded: true)
}
