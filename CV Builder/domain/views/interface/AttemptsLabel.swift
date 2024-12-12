//
//  AttemptsLabel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct AttemptsLabel: View {
    
    @Binding var text: String
    
    @State var currentText = ""
    
    var body: some View {
        Text(currentText).font(.subheadline).foregroundStyle(.textAdditional).multilineTextAlignment(.center).padding(6).padding(.horizontal, 8).fixedSize().background() {
            RoundedRectangle(cornerRadius: 8.0).fill(Color.window)
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
    AttemptsLabel(text: .constant("3 attempts left"))
}
