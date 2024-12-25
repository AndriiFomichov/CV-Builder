//
//  LanguageView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct LanguageView: View {
    
    @Binding var item: Language
    let clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(item.icon).resizable().scaledToFit().frame(width: 18, height: 18).scaleEffect(isSelected ? 1.08 : 1.0)
                    
                }.frame(width: 36, height: 36).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                }.padding(8)
                
                VStack {
                    
                    Text(item.name).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                }.padding(.vertical, 4)
                
                SelectedIndicatorView(isSelected: $isSelected, type: 1).padding(8)
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 32.0).fill(Color.window).stroke(isSelected ? .accent : .clear, style: StrokeStyle(lineWidth: 2))
                
            }.scaleEffect(isSelected ? 1.02 : 1.0)
            
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
    LanguageView(item: .constant(Language.getDefault()), clickHandler: {})
}

