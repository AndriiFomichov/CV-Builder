//
//  AiActionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import SwiftUI

struct AiActionView: View {
    
    let name: String
    let clickHandler: () -> Void
    
    var body: some View {
        Button (action: clickHandler) {
            HStack {
                
                Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 24, height: 24)
                
                Text(name).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.leading).fixedSize().lineLimit(1)
                
            }.padding(8).padding(.horizontal, 4).background() {
                RoundedRectangle(cornerRadius: 12.0).fill(Color.windowTwo)
            }
        }
    }
}

#Preview {
    AiActionView(name: "Rephrase", clickHandler: {})
}
