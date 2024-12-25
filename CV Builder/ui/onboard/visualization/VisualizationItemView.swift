//
//  VisualizationItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.12.2024.
//

import SwiftUI

struct VisualizationItemView: View {
    
    @Binding var item: VisualizationItem
    var clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: item.icon).font(.headline).foregroundStyle(isSelected ? .accent : .textAdditional)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                }.padding(8)
                
                Text(item.name).font(.title2).bold().foregroundStyle(isSelected ? .accent : .textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2).padding(.trailing, 4).padding(.vertical, 4).lineLimit(2)
                
                SelectedIndicatorView(isSelected: $isSelected, type: 1).padding(8).padding(.trailing, 4)
                
            }.frame(maxWidth: .infinity).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
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
    VisualizationItemView(item: .constant(VisualizationItem.getDefault()), clickHandler: {})
}
