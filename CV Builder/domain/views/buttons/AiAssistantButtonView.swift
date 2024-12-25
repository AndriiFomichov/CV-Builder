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
                Text(text).font(.headline).bold().foregroundStyle(.white).lineLimit(1)
                
                Image("sparkle_colored_icon").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.white).frame(width: 24, height: 24)
                
            }.padding(.horizontal, 8).padding().background() {
                RoundedRectangle(cornerRadius: 32.0).fill(LinearGradient(colors: selected ? [ .accentLight, .accent ] : [.accentLightest], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            
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
    AiAssistantButtonView(isSelected: .constant(false), text: "AI Assistant", clickHandler: {})
}
