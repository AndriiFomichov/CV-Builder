//
//  SkillsItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import SwiftUI
import PhotosUI
import _PhotosUI_SwiftUI

struct SkillsItemView: View {
    
    @Binding var item: SkillsItem
    let actionsHandler: () -> Void
    let selectionHandler: (_ selectedPhotos: [PhotosPickerItem]) -> Void
    
    @State var isFilled = false
    @State var text = ""
    @State var level = -1
    @State var preview: UIImage?
    
    var body: some View {
        HStack {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: "lightbulb.max.fill").font(.headline).foregroundStyle(isFilled ? .accent : .textAdditional)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo).stroke(isFilled ? .accent : .clear, style: StrokeStyle(lineWidth: 2))
                }.padding(8)
                
                VStack {
                    
                    TextField("", text: $text, prompt: Text(NSLocalizedString("enter_skill_name", comment: "")).foregroundStyle(.textAdditional)).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).onChange(of: text) {
                        item.name = text
                    }
                    
                    ProfileItemLevelView(level: $level, changeHandler: { level in
                        item.level = level
                    })
                    
                }.padding(.vertical, 8)
               
                Button(action: actionsHandler) {
                    ZStack {
                        
                        Image(systemName: "ellipsis").font(.title3).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                        
                    }.frame(width: 42, height: 42)
                }
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                
            }
            
            if item.category == 1 {
                IconInputView(preview: $preview, icon: "photo", selectionHandler: selectionHandler)
            }
            
        }.onAppear() {
            text = item.name
            level = item.level
            preview = item.iconPreview
        }.onChange(of: item.name) {
            text = item.name
        }.onChange(of: item.level) {
            level = item.level
        }.onChange(of: item.iconPreview) {
            withAnimation {
                preview = item.iconPreview
            }
        }.onChange(of: text) {
            withAnimation {
                isFilled = text.count > 0
            }
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16.0, style: .continuous))
    }
}

#Preview {
    SkillsItemView(item: .constant(SkillsItem.getDefault()), actionsHandler: {}, selectionHandler: { photos in })
}
