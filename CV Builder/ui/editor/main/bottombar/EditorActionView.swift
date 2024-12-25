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
                    
                    ZStack {
                        if action.isIconSystem {
                            Image(systemName: action.icon).font(.title2).foregroundStyle(.accent)
                        } else {
                            Image(action.icon).resizable().scaledToFit().frame(width: 28, height: 28)
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        Circle().fill(LinearGradient(colors: [ .windowColoredLight, .windowColored ], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }.padding(4)
                    
                }.clipShape(RoundedRectangle(cornerRadius: 16.0)).frame(width: 48, height: 48).background() {
                    RoundedRectangle(cornerRadius: 16.0).fill(.window)
                }
                
                Text(action.name).font(.caption).foregroundStyle(.text).lineLimit(1)
            }
        }.padding(.horizontal, 6)
    }
}

#Preview {
    EditorActionView(action: EditorAction.getDefault())
}
