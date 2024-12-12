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
                
                SwiftUI.Image(systemName: icon).font(.headline).foregroundStyle(isSelectedState ? .accent : .textAdditional)
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo).stroke(isSelectedState ? .accent : .textAdditional.opacity(0.0), style: StrokeStyle(lineWidth: 2))
            }.padding(8)
            
            Text(text).font(.title2).bold().foregroundStyle(isSelectedState ? .accent : .textAdditional).fixedSize().frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4)
            
            Toggle("", isOn: $isSelected).toggleStyle(SwitchToggleStyle(tint: .accent)).padding(.trailing, 8)
            
        }.frame(maxWidth: .infinity).background() {
            RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
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
