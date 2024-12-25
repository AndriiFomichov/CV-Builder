//
//  ActionButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct ActionButtonView: View {
    
    var icon: String
    var text: String
    var clickHandler: () -> Void
    var addArrow = false
    var isIconSystem: Bool = true
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    if isIconSystem {
                        Image(systemName: icon).font(.headline).foregroundStyle(.accent)
                    } else {
                        Image(icon).resizable().scaledToFit().frame(width: 24, height: 24)
                    }
                    
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                }.padding(8)
                
                Text(text).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2).padding(.trailing, 4).padding(.vertical, 4).lineLimit(2)
                
                if addArrow {
                    Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                }
                
            }.frame(maxWidth: .infinity).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
            }
        }
    }
}

#Preview {
    ActionButtonView(icon: "gear", text: "Delete", clickHandler: {})
}
