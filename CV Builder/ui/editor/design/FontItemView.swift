//
//  FontItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 02.12.2024.
//

import SwiftUI

struct FontItemView: View {
    
    @Binding var font: String?
    let fontType: String
    let clickHandler: () -> Void
    
    var body: some View {
        if let font {
            Button (action: clickHandler) {
                HStack (spacing: 0) {
                    
                    ZStack {
                        
                        Text(font[0].uppercased()).font(SwiftUI.Font.custom(font, size: 32)).foregroundStyle(.accent)
                        
                    }.frame(width: 48, height: 48).background() {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.windowTwo)
                    }.padding(8)
                    
                    VStack (spacing: 0) {
                        
                        Text(fontType).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.bottom, 4).lineLimit(1)
                        
                        Text(font).font(.title3).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                        
                    }.padding(.trailing, 4).padding(.vertical, 8)
                }.background() {
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                }
            }
        }
    }
}

#Preview {
    FontItemView(font: .constant("Roboto"), fontType: "Headers", clickHandler: {})
}
