//
//  EditorActionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorActionView: View {
    
    let action: EditorAction
    
    var body: some View {
        Button (action: action.clickHandler) {
            VStack {
                ZStack {
                    
                    if action.isIconSystem {
                        Image(systemName: action.icon).font(.headline).foregroundStyle(.text)
                    } else {
                        Image(action.icon).resizable().scaledToFit().frame(width: 24, height: 24)
                    }
                    
                }.clipShape(RoundedRectangle(cornerRadius: 12.0)).frame(width: 52, height: 52).background() {
                    RoundedRectangle(cornerRadius: 12.0).fill(.window)
                }
                
                Text(action.name).font(.subheadline).foregroundStyle(.textAdditional).lineLimit(1)
            }
        }.padding(.horizontal, 4)
    }
}

#Preview {
    EditorActionView(action: EditorAction.getDefault())
}
