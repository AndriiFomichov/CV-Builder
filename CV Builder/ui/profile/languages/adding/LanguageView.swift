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
                    
                    Image(item.icon).resizable().scaledToFit().frame(width: 24, height: 24)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo).stroke(isSelected ? .accent : .clear, style: StrokeStyle(lineWidth: 2))
                }.padding(8)
                
                VStack {
                    
                    Text(item.name).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                }.padding(.vertical, 4)
                
                SelectedIndicatorView(isSelected: $isSelected).padding(8)
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                
            }
            
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

