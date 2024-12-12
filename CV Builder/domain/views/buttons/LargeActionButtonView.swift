//
//  LargeActionButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct LargeActionButtonView: View {
    
    var icon: String
    var text: String
    var clickHandler: () -> Void
    
    var isIconSystem = true
    var illustration = "manual_import_illustration"
    var addArrow = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack (alignment: .leading) {
                    
                    Image(illustration).renderingMode(.template).cropped(horizontalOffset: 100, verticalOffset: 50).foregroundStyle(Color.windowTwo).opacity(0.5).frame(width: 60)
                    
                    ZStack {
                        
                        if isIconSystem {
                            Image(systemName: icon).font(.headline).foregroundStyle(.accent)
                        } else {
                            Image(icon).resizable().scaledToFit().frame(width: 26, height: 26)
                        }
                        
                    }.frame(width: 54, height: 54).background() {
                        RoundedRectangle(cornerRadius: 12.0).fill(.window).shadow(color: Color.black.opacity(0.05), radius: 6)
                    }.padding([.leading, .top, .bottom])
                    
                }.padding(.trailing, 8)
                
                Text(text).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4).lineLimit(2)
                
                if addArrow {
                    SwiftUI.Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                }
                
            }.clipShape(RoundedRectangle(cornerRadius: 16.0)).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            }
        }
    }
}

#Preview {
    LargeActionButtonView(icon: "gear", text: "Delete", clickHandler: {})
}
