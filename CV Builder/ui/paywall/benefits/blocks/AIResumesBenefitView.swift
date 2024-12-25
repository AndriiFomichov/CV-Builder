//
//  AIResumesBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct AIResumesBenefitView: View {
    
    @State var animated = false
    
    var body: some View {
        HStack {
            
            Text(NSLocalizedString("benefit_ai_resume", comment: "")).font(.title2).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3).padding([.leading, .top, .bottom]).padding(.trailing, 8)
            
            ZStack {
                
                Image("resume_preview").resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(4).background() {
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.02), radius: 40).scaleEffect(animated ? 1.2 : 1.0).rotationEffect(animated ? Angle(degrees: -3) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.15), radius: 40).scaleEffect(animated ? 1.12 : 1.0).rotationEffect(animated ? Angle(degrees: 2) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.white).shadow(color: .accent.opacity(0.2), radius: 40)
                    
                }.overlay {
                    VStack {
                        
                        HStack {
                            Image("profile_photo_two_illustration").centerCropped().frame(width: 46, height: 46).clipShape(Circle()).padding(2).background() { Circle().fill(Color.white) }.scaleEffect(animated ? 1.15 : 1.0).offset(x: animated ? -8 : -4, y: 0).shadow(color: .black.opacity(0.2), radius: 40)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 36, height: 36).rotationEffect(animated ? Angle(degrees: 7) : Angle(degrees: 0)).offset(x: animated ? 12 : 0, y: animated ? -36 : 0)
                        }
                    }
                    
                }.scaleEffect(animated ? 1.1 : 0.99)
                
            }.offset(y: 22).frame(maxHeight: 135).padding(.horizontal).padding(.trailing)
            
        }.background() {
            
            ColorBackgroundView()
            
        }.clipShape(RoundedRectangle(cornerRadius: 24.0)).onAppear() {
            withAnimation(.easeInOut(duration: 1)) {
                animated = true
            }
        }
    }
}

#Preview {
    AIResumesBenefitView()
}
