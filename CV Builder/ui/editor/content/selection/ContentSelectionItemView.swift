//
//  ContentSelectionItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct ContentSelectionItemView: View {
    
    @Binding var item: ContentBlock
    var clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: item.icon).font(.headline).foregroundStyle(isSelected ? .accent : .textAdditional)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 24.0).fill(.windowTwo)
                }.padding(8)
                
                VStack {
                    
                    Text(item.name).font(.title2).bold().foregroundStyle(isSelected ? .accent : .textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)

                }.padding(.vertical, 8)
                
                Image(systemName: isSelected ? "checkmark.seal.fill" : "circle").font(.title2).foregroundStyle(LinearGradient(colors: isSelected ? [ .accentLight, .accent ] : [ .textAdditional ], startPoint: .topLeading, endPoint: .bottomTrailing)).contentTransition(.symbolEffect(.replace)).padding(8)
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
                
            }
        }.onAppear() {
            withAnimation {
                isSelected = item.isAdded
            }
        }.onChange(of: item.isAdded) {
            withAnimation {
                isSelected = item.isAdded
            }
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 32.0, style: .continuous))
    }
}

#Preview {
    ContentSelectionItemView(item: .constant(ContentBlock.getDefault()), clickHandler: {})
}
