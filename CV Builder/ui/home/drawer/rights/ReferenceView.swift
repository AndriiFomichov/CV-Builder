//
//  ReferenceView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct ReferenceView: View {
    
    let reference: Reference
    
    var body: some View {
        Button(action: {
            if let link = reference.link, let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: reference.icon).font(.headline).foregroundStyle(.text)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo)
                }.padding(8)
                
                Text(reference.text).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4).lineLimit(1)
                
                ZStack {
                    
                    if reference.link != nil {
                        Image(systemName: "chevron.right").foregroundStyle(Color.textAdditional).font(.subheadline)
                    }
                    
                }.frame(width: 24, height: 24).padding(8)
                
            }.frame(maxWidth: .infinity).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window).opacity(1.0)
            }
        }
    }
}

#Preview {
    ReferenceView(reference: Reference.getDefault())
}
