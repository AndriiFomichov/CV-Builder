//
//  AIAssistantBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct AIAssistantBenefitView: View {
    
    @State var animated = false
    
    var body: some View {
        VStack {
            
            HStack (spacing: 2) {
                
                Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 16, height: 16).opacity(0.6).offset(y: animated ? 4 : 0).rotationEffect(Angle(degrees: 12))
                
                ZStack {
                    
                    Image(systemName: "globe").font(.caption).foregroundStyle(.accent)
                    
                }.frame(width: 26, height: 26).background() {
                    Circle().fill(Color.windowColored)
                }.padding(2).background() {
                    Circle().fill(Color.window)
                }.shadow(color: .accent.opacity(0.2), radius: 40).offset(x: 5, y: -12).scaleEffect(animated ? 1.0 : 0.9)
                
                ZStack {
                    
                    Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 22, height: 22)
                    
                }.frame(width: 32, height: 32).background() {
                    Circle().fill(Color.windowColored)
                }.padding(2).background() {
                    Circle().fill(Color.window)
                }.shadow(color: .accent.opacity(0.2), radius: 40).offset(y: 16).scaleEffect(animated ? 1.0 : 0.9)
                
                ZStack {
                    
                    Image(systemName: "text.viewfinder").font(.caption).foregroundStyle(.accent)
                    
                }.frame(width: 26, height: 26).background() {
                    Circle().fill(Color.windowColored)
                }.padding(2).background() {
                    Circle().fill(Color.window)
                }.shadow(color: .accent.opacity(0.2), radius: 40).offset(y: 0).scaleEffect(animated ? 1.0 : 0.9)
                
                Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 16, height: 16).opacity(0.6).offset(y: animated ? 16 : 12).rotationEffect(Angle(degrees: -8))
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                ZStack (alignment: .top) {
                    
                    RoundedRectangle(cornerRadius: 8.0).fill(.windowColored).aspectRatio(0.7070707, contentMode: .fit).shadow(color: .accent.opacity(0.2), radius: 40).offset(x: 4, y: animated ? -16 : -20).scaleEffect(1.8).rotationEffect(Angle(degrees: animated ? -6 : -3))
                    
                    RoundedRectangle(cornerRadius: 8.0).fill(.windowColored).aspectRatio(0.7070707, contentMode: .fit).shadow(color: .accent.opacity(0.2), radius: 40).offset(x: -6, y: animated ? -22 : -26).scaleEffect(1.9).rotationEffect(Angle(degrees: animated ? 8 : 5))
                    
                }
            }
            
            Text(NSLocalizedString("benefit_ai_assistant", comment: "")).font(.title3).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(3).padding([.leading, .trailing], 4).padding(.vertical, 8)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
            
            ColorBackgroundView(alignment: .topLeading)
            
        }.clipShape(RoundedRectangle(cornerRadius: 24.0)).onAppear() {
            withAnimation(.easeInOut(duration: 1)) {
                animated = true
            }
        }
    }
}

#Preview {
    AIAssistantBenefitView()
}
