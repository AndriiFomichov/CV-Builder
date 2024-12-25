//
//  SmallButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct SmallButtonView: View {
    
    @Binding var isSelected: Bool
    let text: String
    var icon: String? = nil
    var isIconSystem: Bool = true
    let clickHandler: () -> Void
    
    var isGradient = false
    var textColor = Color.white
    var backgroundColor = Color.accent
    var backgroundColorAdditional = Color.accentLight
    
    var body: some View {
        Button(action: {
            clickHandler()
        }) {
            HStack (spacing: 2) {
                
                Text(text).font(.headline).bold().foregroundStyle(textColor).multilineTextAlignment(.leading).fixedSize().lineLimit(1)
                
                if let icon {
                    if isIconSystem {
                        Image(systemName: icon).font(.headline).bold().foregroundStyle(textColor)
                    } else {
                        Image(icon).renderingMode(.template).resizable().scaledToFit().foregroundStyle(Color.white).frame(width: 24, height: 24)
                    }
                }
                
            }.padding(12).padding(.horizontal, 8).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(LinearGradient(colors: isSelected ? ( isGradient ? [ .accentLight, .accent ] : [ backgroundColor ]) : [ backgroundColorAdditional ], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
    }
}

#Preview {
    SmallButtonView(isSelected: .constant(true), text: "Continue", clickHandler: {})
}
