//
//  LabelProView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct LabelProView: View {
    
    let clickHandler: () -> Void
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack (alignment: .leading) {
                    
                    Image("linkedin_import_illustration").renderingMode(.template).cropped(horizontalOffset: 100, verticalOffset: 50).foregroundStyle(Color.windowTwo).opacity(0.5).frame(width: 60)
                    
                    ZStack {
                        
                        Image(systemName: "crown.fill").font(.headline).foregroundStyle(.white)
                        
                    }.frame(width: 54, height: 54).background() {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(LinearGradient(colors: [ .accentDarker, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing)).shadow(color: Color.black.opacity(0.05), radius: 6)
                    }.padding([.leading, .top, .bottom])
                    
                }.padding(.trailing)
                
                VStack (spacing: 0) {
                    
                    Text(NSLocalizedString("unlock_pro_header", comment: "")).font(.title2).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                    Text(NSLocalizedString("unlock_pro_description", comment: "")).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.top, 8).lineLimit(3)
                    
                }.padding(.trailing, 4).padding(.vertical)
                
                Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                
            }.clipShape(RoundedRectangle(cornerRadius: 16.0)).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            }
        }
    }
}

#Preview {
    LabelProView(clickHandler: {})
}
