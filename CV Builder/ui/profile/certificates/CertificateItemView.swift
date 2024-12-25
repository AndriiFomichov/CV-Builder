//
//  CertificateItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import SwiftUI

struct CertificateItemView: View {
    
    @Binding var item: CertificateItem
    let actionsHandler: () -> Void
    
    @State var isFilled = false
    @State var text = ""
    
    var body: some View {
        HStack {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: "text.document.fill").font(.headline).foregroundStyle(isFilled ? .accent : .textAdditional)
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                }.padding(8)
                
                VStack {
                    
                    TextField("", text: $text, prompt: Text(NSLocalizedString("enter_certificate_name", comment: "")).foregroundStyle(.textAdditional)).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).onChange(of: text) {
                        item.name = text
                    }
                    
                }.padding(.vertical, 8)
               
                Button(action: actionsHandler) {
                    ZStack {
                        
                        Image(systemName: "ellipsis").font(.title3).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                        
                    }.frame(width: 42, height: 42)
                }
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
                
            }
            
        }.onAppear() {
            text = item.name
        }.onChange(of: item.name) {
            text = item.name
        }.onChange(of: text) {
            withAnimation {
                isFilled = text.count > 0
            }
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16.0, style: .continuous))
    }
}

#Preview {
    CertificateItemView(item: .constant(CertificateItem.getDefault()), actionsHandler: {})
}
