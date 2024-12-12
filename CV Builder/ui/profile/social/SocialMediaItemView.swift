//
//  SocialMediaItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct SocialMediaItemView: View {
    
    @Binding var item: SocialMediaItem
    var actionsHandler: () -> Void
    var qrHandler: () -> Void
    
    @State var qrCode: UIImage?
    
    var body: some View {
        HStack {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    if let media = PreloadedDatabase.getSocialMediaById(id: item.media), media.id != -1 {
                        Image(media.icon).resizable().scaledToFit().frame(width: 24, height: 24)
                    } else {
                        Image(systemName: "briefcase.fill").font(.headline).foregroundStyle(.accent)
                    }
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo).stroke(.accent, style: StrokeStyle(lineWidth: 2))
                }.padding(8)
                
                VStack {
                    Text(item.link).font(.title2).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    if let media = PreloadedDatabase.getSocialMediaById(id: item.media) {
                        Text(media.name).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    }
                    
                }.padding(.vertical, 8)
                
                Button(action: actionsHandler) {
                    ZStack {
                        
                        Image(systemName: "ellipsis").font(.title3).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                        
                    }.frame(width: 42, height: 42)
                }
                
            }.frame(maxWidth: .infinity).background() {
                
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                
            }
            
            Button (action: qrHandler) {
                HStack (spacing: 0) {
                    
                    ZStack {
                        
                        if let qrCode {
                            Image(uiImage: qrCode).resizable().scaledToFit().frame(width: 24, height: 24)
                        } else {
                            Image(systemName: "qrcode").font(.headline).foregroundStyle(.accent)
                            
                            Image(systemName: "plus.circle.fill").font(.subheadline).foregroundStyle(.accent).offset(x: 12, y: 12)
                        }
                        
                    }.frame(width: 42, height: 42).background() {
                        RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo)
                    }.padding(8)
                    
                }.background() {
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                    
                }
            }.onAppear() {
                withAnimation {
                    qrCode = item.qrCodePreview
                }
            }.onChange(of: item.qrCodePreview) {
                withAnimation {
                    qrCode = item.qrCodePreview
                }
            }
            
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16.0, style: .continuous))
    }
}

#Preview {
    SocialMediaItemView(item: .constant(SocialMediaItem.getDefault()), actionsHandler: {}, qrHandler: {})
}
