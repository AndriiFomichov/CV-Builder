//
//  ToggleInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

struct ToggleInputView: View {
    
    @Binding var isSelected: Bool
    let icon: String
    let text: String
    
    @State var isSelectedState = false
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: isSelectedState ? "checkmark.circle.fill" : icon).font(.headline).foregroundStyle(isSelectedState ? .accent : .textAdditional).contentTransition(.symbolEffect(.replace))
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 24.0).fill(.windowTwo)
            }.padding(8)
            
            Text(text).font(.title2).bold().foregroundStyle(isSelectedState ? .accent : .textAdditional).fixedSize().frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).padding(.trailing, 4).padding(.vertical, 4)
            
            Toggle("", isOn: $isSelected).toggleStyle(SwitchToggleStyle(tint: .accent)).padding(.trailing, 8)
            
        }.frame(maxWidth: .infinity).background() {
            RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
        }.onAppear() {
            withAnimation {
                isSelectedState = isSelected
            }
        }.onChange(of: isSelected) {
            withAnimation {
                isSelectedState = isSelected
            }
        }.onTapGesture {
            isSelected.toggle()
        }
    }
}

#Preview {
    @Previewable @State var isSelected = false
    ToggleInputView(isSelected: $isSelected, icon: "case.fill", text: "Still working here")
}
