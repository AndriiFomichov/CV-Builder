//
//  AdditionalTextItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.12.2024.
//

import SwiftUI

struct AdditionalTextItemView: View {
    
    @Binding var item: AdditionalTextItem
    
    @State var isFilled = false
    @State var text = ""
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: item.icon).font(.headline).foregroundStyle(isFilled ? .accent : .textAdditional).contentTransition(.symbolEffect(.replace))
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 24.0).fill(.windowTwo)
            }.padding(8)
            
            TextField("", text: $text, prompt: Text(NSLocalizedString("enter_text", comment: "")).foregroundStyle(.textAdditional)).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4)

        }.frame(maxWidth: .infinity).background() {
            
            RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
            
        }.onAppear() {
            text = item.text
            withAnimation {
                isFilled = !text.isEmpty
            }
        }.onChange(of: text) {
            item.text = String(text.prefix(100))
            withAnimation {
                isFilled = !text.isEmpty
            }
        }
    }
}

#Preview {
    AdditionalTextItemView(item: .constant(AdditionalTextItem.getDefault()))
}
