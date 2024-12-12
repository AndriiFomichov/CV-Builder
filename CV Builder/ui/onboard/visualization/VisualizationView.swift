//
//  VisualizationView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct VisualizationView: View {
    
    @Binding var item: VisualizationItem
    var clickHandler: () -> Void
    
    @State var isSelected = false
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack (spacing: 0) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))
                
                CVMakerPreviewView(cv: item.wrapper, isLoading: .constant(false), pageUpdateHandler: {
                    
                    savePagesUpdated()
                    
                }, doubleTapHandler: { i, b in }).padding(.horizontal)
                
            }.padding(8)
            
            HStack {
                VStack {
                    Text(NSLocalizedString(item.wrapper.wrapperName, comment: "")).font(.headline).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
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
        }.onTapGesture {
            clickHandler()
        }.onAppear() {
            withAnimation {
                self.isSelected = item.isSelected
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.5)) {
                scale = item.isSelected ? 1.1 : 1.0
            }
        }.onChange(of: item.isSelected) {
            withAnimation {
                self.isSelected = item.isSelected
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.5)) {
                scale = item.isSelected ? 1.1 : 1.0
            }
        }.padding(2)
    }
    
    private func savePagesUpdated () {
        self.item.wrapper = self.item.wrapper
    }
}

#Preview {
    @Previewable @State var item = VisualizationItem.getDefault()
    VisualizationView(item: $item, clickHandler: {})
}
