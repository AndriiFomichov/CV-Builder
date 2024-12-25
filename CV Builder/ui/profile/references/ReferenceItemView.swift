//
//  ReferenceItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct ReferenceItemView: View {
    
    @Binding var item: ReferenceItem
    var clickHandler: () -> Void
    var actionsHandler: () -> Void
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: "person.crop.circle").font(.headline).foregroundStyle(.accent)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                }.padding(8)
                
                VStack {
                    Text(item.referralName).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                    
                    Text(item.company.isEmpty ? item.email : item.company).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                    
                }.padding(.vertical, 8)
                
                Button(action: actionsHandler) {
                    ZStack {
                        
                        Image(systemName: "ellipsis").font(.title3).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                        
                    }.frame(width: 42, height: 42)
                }
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
                
            }
            
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 20.0, style: .continuous))
    }
}

#Preview {
    ReferenceItemView(item: .constant(ReferenceItem.getDefault()), clickHandler: {}, actionsHandler: {})
}
