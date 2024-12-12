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
    
    var keyboardType: UIKeyboardType = .default
    var options: [String]? = nil
    
    @State var isFilled = false
    @State var optionsShown = false
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: icon).font(.headline).foregroundStyle(isFilled ? .accent : .textAdditional)
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo).stroke(isFilled ? .accent : .textAdditional.opacity(0.0), style: StrokeStyle(lineWidth: 2))
            }.padding(8)
            
            TextField("", text: $text, prompt: Text(hint).foregroundStyle(.textAdditional)).keyboardType(keyboardType).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4)
            
            if let options {
                Menu {
                    ForEach(options, id: \.self) { option in
                        if option.contains(text) || text.isEmpty {
                            Button(option, action: {
                                text = option
                            })
                        }
                    }
                } label: {
                    ArrowExpandView(optionsShown: $optionsShown).padding(8)
                }
            }
            
        }.frame(maxWidth: .infinity).background() {
            
            RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            
        }.onAppear() {
            withAnimation {
                isFilled = !text.isEmpty
            }
        }.onChange(of: text) {
            withAnimation {
                isFilled = !text.isEmpty
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    TextInputView(text: $text, icon: "gear", hint: "Enter text", options: [ "Red", "Blue", "White"])
}
