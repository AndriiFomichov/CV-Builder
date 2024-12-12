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
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack (spacing: 0) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))
                
                Image("style_preview_" + String(style.id)).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 8.0)).scaleEffect(scale).aspectRatio(0.707070707, contentMode: .fit).padding()
                
            }.padding(8)
            
        }.background() {
            RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
        }.overlay {
            RoundedRectangle(cornerRadius: 16.0).fill(.clear).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 3))
        }.onTapGesture {
            clickHandler()
        }.onAppear() {
            withAnimation {
                self.isSelected = style.isSelected
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.5)) {
                scale = style.isSelected ? 1.1 : 1.0
            }
        }.onChange(of: style.isSelected) {
            withAnimation {
                self.isSelected = style.isSelected
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.5)) {
                scale = style.isSelected ? 1.1 : 1.0
            }
        }.padding(2)
    }
}

#Preview {
    @Previewable @State var style = PreloadedDatabase.getStyleId(id: 1)
    StyleSmallView(style: $style, clickHandler: {})
}
