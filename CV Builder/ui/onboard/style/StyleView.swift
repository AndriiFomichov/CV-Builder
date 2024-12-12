//
//  StyleView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct StyleView: View {
    
    @Binding var style: Style
    var clickHandler: () -> Void
    
    @State var isSelected = false
    @State private var scale: CGFloat = 1.0
    @State private var isAnimating = false

    var body: some View {
        VStack (spacing: 0) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))
                
                Image("style_preview_" + String(style.id)).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 8.0)).scaleEffect(scale).padding().padding(4)
                
            }.padding(8)
            
            HStack {
                VStack {
                    Text(NSLocalizedString(style.name, comment: "")).font(.headline).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                    
                    Text(NSLocalizedString(style.description, comment: "")).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                }
                
                HStack {
                    
                    if isSelected {
                        Image(systemName: "checkmark").font(.headline).bold().foregroundStyle(.white)
                    } else {
                        Text(NSLocalizedString("select", comment: "")).font(.headline).bold().foregroundStyle(.white).multilineTextAlignment(.leading).fixedSize().lineLimit(1)
                    }
                    
                }.padding(10).padding(.horizontal, isSelected ? 2 : 8).frame(height: 44).background() {
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.accent)
                }
                
            }.padding([.leading, .bottom, .trailing], 8)
            
        }.background() {
            RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
        }.overlay {
            RoundedRectangle(cornerRadius: 16.0).fill(.clear).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 3))
//                .borderLoadingAnimation(isAnimating: $isAnimating)
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
//            if style.isSelected {
//                withAnimation(.linear(duration: 1)) {
//                    self.isAnimating = true
//                } completion: {
//                    self.isAnimating = false
//                }
//            }
        }.padding(2)
    }
}

#Preview {
    @Previewable @State var style = PreloadedDatabase.getStyleId(id: 1)
    StyleView(style: $style, clickHandler: {})
}
