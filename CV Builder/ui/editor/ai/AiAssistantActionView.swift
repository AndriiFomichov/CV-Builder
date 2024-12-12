//
//  AiAssistantActionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct AiAssistantActionView: View {
    
    let action: AiAssistantAction
    
    var body: some View {
        Button (action: action.clickHandler) {
            HStack (spacing: 0) {
                
                ZStack (alignment: .leading) {
                    
                    Image("linkedin_import_illustration").renderingMode(.template).cropped(horizontalOffset: 100, verticalOffset: 50).foregroundStyle(Color.windowTwo).opacity(0.5).frame(width: 60)
                    
                    ZStack {
                        
                        Image(systemName: action.icon).font(.title3).foregroundStyle(.accent)
                        
                    }.frame(width: 54, height: 54).background() {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.window).shadow(color: Color.black.opacity(0.05), radius: 6)
                    }.padding([.leading, .top, .bottom])
                    
                }.padding(.trailing)
                
                VStack (spacing: 0) {
                    
                    Text(action.header).font(.title2).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                    Text(action.description).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.top, 8).lineLimit(3)
                    
                }.padding(.trailing, 4).padding(.vertical)
                
                Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                
            }.clipShape(RoundedRectangle(cornerRadius: 16.0)).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            }
        }
    }
}

#Preview {
    AiAssistantActionView(action: AiAssistantAction.getDefault())
}
