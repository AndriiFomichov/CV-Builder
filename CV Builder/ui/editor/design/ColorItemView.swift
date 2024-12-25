//
//  ColorItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 02.12.2024.
//

import SwiftUI

struct ColorItemView: View {
    
    @Binding var item: ColorItem
    var clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            
            RoundedRectangle(cornerRadius: 32.0).fill(Color(hex: item.palette.mainColor)).aspectRatio(1.0, contentMode: .fit).padding(8).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
            }.overlay {
                RoundedRectangle(cornerRadius: 32.0).fill(.clear).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
            }.scaleEffect(isSelected ? 1.02 : 1.0).padding(2)
            
        }.onAppear() {
            withAnimation {
                isSelected = item.isSelected
            }
        }.onChange(of: item.isSelected) {
            withAnimation {
                isSelected = item.isSelected
            }
        }
    }
}

#Preview {
    ColorItemView(item: .constant(ColorItem.getDefault()), clickHandler: {})
}
