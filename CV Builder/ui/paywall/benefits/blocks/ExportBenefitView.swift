//
//  ExportBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct ExportBenefitView: View {
    
    @State var animated = false
    
    var body: some View {
        HStack {
            
            ZStack {
                
                Image("style_preview_0").resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(4).background() {
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.02), radius: 40).scaleEffect(animated ? 1.2 : 1.0).rotationEffect(animated ? Angle(degrees: -3) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.15), radius: 40).scaleEffect(animated ? 1.12 : 1.0).rotationEffect(animated ? Angle(degrees: 2) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.white).shadow(color: .accent.opacity(0.2), radius: 40)
                    
                }.overlay {
                    VStack {
                        
                        HStack {
                            Spacer()
                            ZStack {
                                
                                Image(systemName: "square.and.arrow.up.fill").font(.headline).foregroundStyle(.accent)
                                
                            }.frame(width: 32, height: 32).background() {
                                Circle().fill(Color.windowColored)
                            }.padding(2).background() {
                                Circle().fill(Color.window)
                            }.shadow(color: .accent.opacity(0.2), radius: 40).offset(x: animated ? 8 : -12, y: animated ? -6 : 0)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 22, height: 22).rotationEffect(animated ? Angle(degrees: -6) : Angle(degrees: -3)).offset(x: animated ? 0 : -4, y: animated ? -36 : -6)
                            Spacer()
                        }
                    }
                    
                }.scaleEffect(animated ? 1.05 : 0.99).offset(x: animated ? -24 : -36).rotationEffect(animated ? Angle(degrees: 6) : Angle(degrees: 3))
                
            }.offset(y: 22).frame(maxHeight: 125).padding(.leading).padding(.leading)
            
            Text(NSLocalizedString("benefit_unlimited_export", comment: "")).font(.title3).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3).padding(.vertical, 8).padding(.trailing, 4)
            
        }.background() {
            
            ColorBackgroundView(alignment: .bottomLeading)
            
        }.clipShape(RoundedRectangle(cornerRadius: 24.0)).onAppear() {
            withAnimation(.easeInOut(duration: 1)) {
                animated = true
            }
        }
    }
}

#Preview {
    ExportBenefitView()
}
