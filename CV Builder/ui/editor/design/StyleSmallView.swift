//
//  StyleSmallView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 02.12.2024.
//

import SwiftUI

struct StyleSmallView: View {
    
    @Binding var style: Style
    var clickHandler: () -> Void
    
    @State var isSelected = false

    var body: some View {
        Button (action: clickHandler) {
            
            VStack (spacing: 0) {
                
                Image("style_preview_" + String(style.id)).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 16.0)).aspectRatio(0.707070707, contentMode: .fit).padding(8)
                
            }.background() {
                RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
            }.overlay {
                RoundedRectangle(cornerRadius: 20.0).fill(.clear).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
            }.scaleEffect(isSelected ? 1.02 : 1.0)
            
        }.onAppear() {
            withAnimation {
                isSelected = style.isSelected
            }
        }.onChange(of: style.isSelected) {
            withAnimation {
                isSelected = style.isSelected
            }
        }.padding(2)
    }
}

#Preview {
    @Previewable @State var style = PreloadedDatabase.getStyleId(id: 1)
    StyleSmallView(style: $style, clickHandler: {
        style.isSelected.toggle()
    })
}
