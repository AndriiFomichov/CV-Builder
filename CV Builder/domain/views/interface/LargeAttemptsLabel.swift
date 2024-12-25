//
//  LargeAttemptsLabel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.12.2024.
//

import SwiftUI

struct LargeAttemptsLabel: View {
    
    @Binding var text: String
    
    @State var currentText = ""
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 24, height: 24)
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
            }.padding(8)
            
            Text(currentText).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 8).padding(.vertical, 8)
            
        }.background() {
            RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
        }.onAppear() {
            self.currentText = text
        }.onChange(of: text) {
            withAnimation {
                self.currentText = text
            }
        }
    }
}

#Preview {
    LargeAttemptsLabel(text: .constant("3 attempts left"))
}
