//
//  LanguageItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct LanguageItemView: View {
    
    @Binding var item: LanguageItem
    var actionsHandler: () -> Void
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                if let lang = PreloadedDatabase.getLanguageById(id: item.langId) {
                    Image(lang.icon).resizable().scaledToFit().frame(width: 24, height: 24)
                } else {
                    Image(systemName: "globe").font(.headline).foregroundStyle(.accent)
                }
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
            }.padding(8)
            
            VStack (spacing: 4) {
                
                Text(item.name).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                
                ProfileItemLevelView(level: item.level, options: PreloadedDatabase.getLanguageLevelsOptions(), changeHandler: { level in
                    item.level = level
                }, levels: 6)
                
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
    LanguageItemView(item: .constant(LanguageItem.getDefault()), actionsHandler: {})
}
