//
//  SelectionInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.12.2024.
//

import SwiftUI

struct SelectionInputView: View {
    
    @Binding var text: String
    let icon: String
    let hint: String
    
    var options: [MenuItem]? = nil
    var selectionHandler: (_ item: MenuItem) -> Void
    
    @State var isSelected = false
    @State var optionsShown = false
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : icon).font(.headline).foregroundStyle(isSelected ? .accent : .textAdditional).contentTransition(.symbolEffect(.replace))
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 24.0).fill(.windowTwo)
            }.padding(8)
            
            if let options {
                SelectionMenuView(currentText: $text, options: options, selectionHandler: selectionHandler) {
                    HStack (spacing: 0) {
                        Text(text.isEmpty ? hint : text).font(.title2).bold().foregroundStyle(isSelected ? .accent : .textAdditional).fixedSize().frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).padding(.trailing, 4).padding(.vertical, 4)
                        
                        ArrowExpandView(optionsShown: $optionsShown).padding(8)
                    }
                }
            }
            
        }.frame(maxWidth: .infinity).background() {
            
            RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
            
        }.onAppear() {
            withAnimation {
                isSelected = !text.isEmpty
            }
        }.onChange(of: text) {
            withAnimation {
                isSelected = !text.isEmpty
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    SelectionInputView(text: $text, icon: "gear", hint: "Select text", options: [ MenuItem.getDefault(), MenuItem.getDefault() ], selectionHandler: { i in })
}
