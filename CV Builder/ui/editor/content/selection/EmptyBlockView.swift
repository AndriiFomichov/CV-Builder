//
//  EmptyBlockView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import SwiftUI

struct EmptyBlockView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            
            Text(text).foregroundStyle(.textAdditional).frame(maxWidth: .infinity)
            
        }.padding().padding(.vertical).background() {
            RoundedRectangle(cornerRadius: 16.0).fill(Color.backgroundDark)
        }
    }
}

#Preview {
    EmptyBlockView(text: "")
}
