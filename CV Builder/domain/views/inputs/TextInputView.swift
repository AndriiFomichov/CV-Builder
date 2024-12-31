//
//  TextInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

struct TextInputView: View {
    
    @Binding var text: String
    let icon: String
    let hint: String
    
    var limit: Int = -1
    var keyboardType: UIKeyboardType = .default
    var options: [MenuItem]? = nil
    
    @State var isFilled = false
    @State var optionsShown = false
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: isFilled ? "checkmark.circle.fill" : icon).font(.headline).foregroundStyle(isFilled ? .accent : .textAdditional).contentTransition(.symbolEffect(.replace))
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 24.0).fill(.windowTwo)
            }.padding(8)
            
            TextField("", text: $text, prompt: Text(hint).foregroundStyle(.textAdditional)).keyboardType(keyboardType).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4)
            
            if let options {
                SelectionMenuView(currentText: $text, options: options, selectionHandler: { item in
                    text = item.name
                }) {
                    ArrowExpandView(optionsShown: $optionsShown).padding(8)
                }
            }
            
        }.frame(maxWidth: .infinity).background() {
            
            RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
            
        }.onAppear() {
            withAnimation {
                isFilled = !text.isEmpty
            }
        }.onChange(of: text) {
            if limit != -1 {
                text = String(text.prefix(limit))
            }
            withAnimation {
                isFilled = !text.isEmpty
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    TextInputView(text: $text, icon: "gear", hint: "Enter text", options: [ MenuItem.getDefault(), MenuItem.getDefault() ])
}
