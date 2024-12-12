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
    let clickHandler: () -> Void
    
    var textColor = Color.white
    var backgroundColor = Color.accentColor
    var backgroundColorAdditional = Color.accentLight
    
    var body: some View {
        Button(action: {
            clickHandler()
        }) {
            HStack {
                
                Text(text).font(.headline).bold().foregroundStyle(textColor).multilineTextAlignment(.leading).fixedSize().lineLimit(1)
                
                if let icon {
                    SwiftUI.Image(systemName: icon).font(.headline).bold().foregroundStyle(textColor)
                }
                
            }.padding(12).padding(.horizontal, 8).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(isSelected ? backgroundColor : backgroundColorAdditional)
            }
        }
    }
}

#Preview {
    SmallButtonView(isSelected: .constant(true), text: "Continue", clickHandler: {})
}
