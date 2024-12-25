//
//  StyleView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct StyleView: View {
    
    @Binding var style: Style
    var clickHandler: () -> Void
    
    var body: some View {
        VStack (spacing: 0) {
            
            ZStack {
                
                Image("style_preview_" + String(style.id)).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 16.0))
                
            }.padding(8)
            
            HStack {
                
                VStack {
                    Text(NSLocalizedString(style.name, comment: "")).font(.headline).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).lineLimit(1)
                    
                    Text(NSLocalizedString(style.description, comment: "")).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).lineLimit(1)
                }
                
            }.padding([.leading, .bottom, .trailing], 8)
            
        }.background() {
            RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
        }.onTapGesture {
            clickHandler()
        }
    }
}

#Preview {
    @Previewable @State var style = PreloadedDatabase.getStyleId(id: 1)
    StyleView(style: $style, clickHandler: {})
}
