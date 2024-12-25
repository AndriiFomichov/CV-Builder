//
//  AICoverLetterBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct AICoverLetterBenefitView: View {
    
    @State var animated = false
    
    var body: some View {
        HStack {
            
            ZStack {
                
                Image("cover_letter_preview").resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(4).background() {
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.02), radius: 40).scaleEffect(animated ? 1.2 : 1.0).rotationEffect(animated ? Angle(degrees: -3) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.windowColored).shadow(color: .accent.opacity(0.15), radius: 40).scaleEffect(animated ? 1.12 : 1.0).rotationEffect(animated ? Angle(degrees: 2) : Angle(degrees: 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(.white).shadow(color: .accent.opacity(0.2), radius: 40)
                    
                }.overlay {
                    VStack {
                        
                        HStack {
                            Spacer()
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 22, height: 22).rotationEffect(animated ? Angle(degrees: 15) : Angle(degrees: 3)).offset(x: animated ? 8 : -12, y: animated ? 0 : -12)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 36, height: 36).rotationEffect(animated ? Angle(degrees: -6) : Angle(degrees: -3)).offset(x: animated ? -22 : -10, y: animated ? -36 : -6)
                            Spacer()
                        }
                    }
                    
                }.scaleEffect(animated ? 1.1 : 0.99)
                
            }.offset(y: 22).frame(maxHeight: 135).padding(.horizontal).padding(.leading)
            
            Text(NSLocalizedString("benefit_ai_cover", comment: "")).font(.title2).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3).padding([.trailing, .top, .bottom]).padding(.leading, 8)
            
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
    AICoverLetterBenefitView()
}
