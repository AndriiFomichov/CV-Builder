//
//  LabelProView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct LabelProView: View {
    
    let clickHandler: () -> Void
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                VStack (spacing: 8) {
                    
                    Text(NSLocalizedString("unlock_pro_header", comment: "")).font(.title2).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                    Text(NSLocalizedString("unlock_pro_description", comment: "")).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3)
                    
                    HStack {
                        SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("upgrade_plan", comment: ""), clickHandler: clickHandler, isGradient: true)
                        Spacer()
                    }.padding(.top, 8)
                    
                }.padding(.vertical).padding(.leading)
                
                HomeIllustrationView().frame(maxHeight: 175).padding(.horizontal)
                
            }.background() {
                
//                ColoredBackgroundLargeView(animating: false)
                ColorBackgroundView(alignment: .bottomLeading)
                
            }.clipShape(RoundedRectangle(cornerRadius: 20.0))
        }
    }
}

struct HomeIllustrationView: View {
    
    @State var animated = false
    
    var body: some View {
        ZStack {
//                Color.clear
            
            Image("resume_preview").resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(4).background() {
                
                RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.02), radius: 40).scaleEffect(animated ? 1.15 : 1.0).rotationEffect(animated ? Angle(degrees: -3) : Angle(degrees: 0))
                
                RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.15), radius: 40).scaleEffect(animated ? 1.08 : 1.0).rotationEffect(animated ? Angle(degrees: 2) : Angle(degrees: 0))
                
                RoundedRectangle(cornerRadius: 16.0).fill(.white).shadow(color: .accent.opacity(0.2), radius: 40)
                
            }.overlay {
                VStack {
                    
                    HStack {
                        Image("profile_photo_two_illustration").centerCropped().frame(width: 48, height: 48).clipShape(Circle()).padding(4).background() { Circle().fill(Color.white) }.scaleEffect(animated ? 1.15 : 1.0).offset(x: animated ? -2 : 0, y: 12).shadow(color: .black.opacity(0.2), radius: 40)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 36, height: 36).rotationEffect(animated ? Angle(degrees: 7) : Angle(degrees: 0)).offset(x: animated ? 12 : 0, y: animated ? -36 : 0)
                    }
                }
                
            }.scaleEffect(animated ? 1.1 : 0.99)
            
        }.offset(y: 22).onAppear() {
            withAnimation(.easeInOut(duration: 1)) {
                animated = true
            }
        }
    }
}

#Preview {
    LabelProView(clickHandler: {})
}
