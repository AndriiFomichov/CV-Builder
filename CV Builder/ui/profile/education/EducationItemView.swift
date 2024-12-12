//
//  EducationItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct EducationItemView: View {
    
    @Binding var education: EducationItem
    var clickHandler: () -> Void
    var actionsHandler: () -> Void
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: "graduationcap.fill").font(.headline).foregroundStyle(.accent)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo).stroke(.accent, style: StrokeStyle(lineWidth: 2))
                }.padding(8)
                
                VStack {
                    Text(education.institution.isEmpty ? education.level : education.institution).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    Text(education.fieldOfStudy.isEmpty ? education.degree :education.fieldOfStudy).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                }.padding(.vertical, 8)
                
                Button(action: actionsHandler) {
                    ZStack {
                        
                        Image(systemName: "ellipsis").font(.title3).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                        
                    }.frame(width: 42, height: 42)
                }
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                
            }
            
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16.0, style: .continuous))
    }
}

#Preview {
    EducationItemView(education: .constant(EducationItem.getDefault()), clickHandler: {}, actionsHandler: {})
}