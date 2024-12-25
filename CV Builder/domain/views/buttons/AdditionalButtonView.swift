//
//  AdditionalButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct AdditionalButtonView: View {
    
    var text: String
    var clickHandler: () -> Void
    
    var backColor = Color.window
    var textColor = Color.textAdditional
    
    var body: some View {
        Button (action: {
            clickHandler()
        }) {
            HStack {
                Text(text).font(.headline).bold().foregroundStyle(textColor)
                
            }.frame(maxWidth: .infinity).padding().background() {
                RoundedRectangle(cornerRadius: 32.0).fill(backColor)
            }.padding(.horizontal)
        }
    }
}

#Preview {
    AdditionalButtonView(text: "Continue", clickHandler: {})
}
