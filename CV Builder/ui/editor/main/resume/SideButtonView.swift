//
//  SideButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.12.2024.
//

import SwiftUI

struct SideButtonView: View {
    
    var text: String
    var icon: String
    var angle: Int
    var clickHandler: () -> Void
    
    var body: some View {
        Button (action: clickHandler) {
            VerticalLayout {
                HStack {
                    
                    Image(systemName: "chevron.down").foregroundStyle(.textAdditional).font(.subheadline).padding(.horizontal)
                    
                    ZStack {
                        
                        Image(systemName: icon).font(.caption).foregroundStyle(.accent).rotationEffect(Angle(degrees: Double(-angle)))
                        
                    }.frame(width: 28, height: 28).background() {
                        RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                    }.padding(.trailing, 4)
                    
                    Text(text).font(.subheadline).foregroundStyle(.text).lineLimit(1)
                    
                    Image(systemName: "chevron.down").foregroundStyle(.textAdditional).font(.subheadline).padding(.horizontal)
                    
                }.padding(2).background() {
                    UnevenRoundedRectangle(topLeadingRadius: 24, topTrailingRadius: 24).fill(.window)
                }
                
            }.rotationEffect(Angle(degrees: Double(angle)))
        }
    }
}

#Preview {
    SideButtonView(text: "Text", icon: "document.fill", angle: -90, clickHandler: {})
}
