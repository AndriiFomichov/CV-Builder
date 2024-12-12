//
//  AiAssistantButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct AiAssistantButtonView: View {
    
    @Binding var isSelected: Bool
    var text: String
    var clickHandler: () -> Void
    
    @State var selected = true
    
    var body: some View {
        
        Button (action: {
            clickHandler()
        }) {
            HStack {
                Text(text).font(.headline).bold().foregroundStyle(.white)
                
                SwiftUI.Image("sparkle_colored_icon").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.white).frame(width: 24, height: 24).padding(.leading, 2)
                
            }.frame(maxWidth: .infinity).padding().background() {
                RoundedRectangle(cornerRadius: 16.0).fill(selected ? LinearGradient(colors: [ .accentDarker, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
            }.padding(.horizontal)
            
        }.onChange(of: isSelected) {
            if selected != isSelected {
                withAnimation {
                    selected = isSelected
                }
            }
        }
    }
}

#Preview {
    AiAssistantButtonView(isSelected: .constant(true), text: "AI Assistant", clickHandler: {})
}
