//
//  InterestItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct InterestItemView: View {
    
    @Binding var item: InterestItem
    var actionsHandler: () -> Void
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: "heart.circle").font(.headline).foregroundStyle(.accent)
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
            }.padding(8)
            
            VStack {
                
                Text(item.name).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)

            }.padding(.vertical, 8)
            
            Button(action: actionsHandler) {
                ZStack {
                    
                    Image(systemName: "ellipsis").font(.title3).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                    
                }.frame(width: 42, height: 42)
            }
            
        }.frame(maxWidth: .infinity).background() {
            
            RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
            
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 20.0, style: .continuous))
    }
}

#Preview {
    InterestItemView(item: .constant(InterestItem.getDefault()), actionsHandler: {})
}
