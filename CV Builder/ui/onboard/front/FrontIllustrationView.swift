//
//  FrontIllustrationView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.12.2024.
//

import SwiftUI

struct FrontIllustrationView: View {
    
    @State var animated = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                
                Image("resume_preview").resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(8).background() {
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.02), radius: 40).scaleEffect(animated ? 1.15 : 1.0).rotationEffect(animated ? Angle(degrees: -3) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.15), radius: 40).scaleEffect(animated ? 1.08 : 1.0).rotationEffect(animated ? Angle(degrees: 2) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.white).shadow(color: .accent.opacity(0.2), radius: 40)
                    
                }.overlay {
                    VStack {
                        
                        HStack {
                            Image("profile_photo_two_illustration").centerCropped().frame(width: geo.size.height * 0.25, height: geo.size.height * 0.25).clipShape(Circle()).padding(8).background() { Circle().fill(Color.white) }.scaleEffect(animated ? 1.15 : 1.0).offset(x: animated ? -2 : 0, y: 16).shadow(color: .black.opacity(0.2), radius: 40)
                            Spacer()
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 48, height: 48).rotationEffect(animated ? Angle(degrees: 7) : Angle(degrees: 0)).offset(x: animated ? 12 : 0, y: animated ? -12 : 0)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            HStack (spacing: 4) {
                                
                                Image(systemName: "wand.and.sparkles").font(.subheadline).foregroundStyle(Color.white)
                                
                                Text(NSLocalizedString("optimize", comment: "")).font(.subheadline).bold().foregroundStyle(Color.white).multilineTextAlignment(.leading)
                                
                            }.padding(12).padding(.horizontal, 2).background() {
                                RoundedRectangle(cornerRadius: 32.0).fill(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            }.shadow(color: .accent.opacity(0.2), radius: 40).offset(x: animated ? 16 : 0, y: animated ? 16 : 0)
                        }
                    }
                    
                }.scaleEffect(animated ? 1.0 : 0.97)
                
            }.padding().onAppear() {
                withAnimation(.easeInOut(duration: 1)) {
                    animated = true
                }
            }
        }
    }
}

#Preview {
    FrontIllustrationView()
}
