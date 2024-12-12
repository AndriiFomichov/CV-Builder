//
//  FontView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 03.12.2024.
//

import SwiftUI

struct FontView: View {
    
    @Binding var font: Font
    var category: Int
    var index: Int
    let clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button(action: clickHandler) {
            ZStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 12.0).fill(Color.windowTwo)
                    
                    ZStack {
                        
                        Text(String(NSLocalizedString(font.name, comment: "").first!)).font(SwiftUI.Font.custom(NSLocalizedString(font.name, comment: ""), size: 64)).foregroundStyle(Color.window).frame(alignment: .center).multilineTextAlignment(.center)
                        
                        Text(NSLocalizedString(font.name, comment: "")).font(SwiftUI.Font.custom(NSLocalizedString(font.name, comment: ""), size: 20)).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                        
                    }.padding(8).opacity(isSelected ? 1.0 : 0.8)
                    
                }
                
            }.clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(8).background {
                
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                
            }.overlay {
                
                RoundedRectangle(cornerRadius: 16.0).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
                
            }.aspectRatio(1.0, contentMode: .fit).padding(2)
            
        }.onAppear() {
            withAnimation {
                self.isSelected = font.isSelected
            }
        }.onChange(of: font.isSelected) {
            withAnimation {
                self.isSelected = font.isSelected
            }
        }
    }
}

#Preview {
    FontView(font: .constant(Font.getDefault()), category: 0, index: 0, clickHandler: {})
}
