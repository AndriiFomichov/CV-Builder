//
//  InterestView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct InterestView: View {
    
    @Binding var item: Interest
    let clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            
            HStack (spacing: 0) {
                
                Image(systemName: item.icon).font(.headline).foregroundStyle(isSelected ? .white : .text)
                
                Text(item.name).font(.subheadline).foregroundStyle(isSelected ? .white : .text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                
            }.frame(maxWidth: .infinity).padding(8).padding(.horizontal, 4).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(isSelected ? Color.accent : Color.window)
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
    InterestView(item: .constant(Interest.getDefault()), clickHandler: {})
}
