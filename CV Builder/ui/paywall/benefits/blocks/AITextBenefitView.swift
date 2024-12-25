//
//  AITextBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct AITextBenefitView: View {
    
    @State var animated = false
    
    var body: some View {
        VStack {
            
            Text(NSLocalizedString("benefit_ai_text_generation", comment: "")).font(.title3).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(3).padding([.leading, .trailing], 4).padding(.vertical, 8)
            
            HStack (spacing: 2) {
                
                HStack (spacing: 2) {
                    
                    Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 20, height: 20)
                    
                    Text(NSLocalizedString("generate", comment: "")).font(.subheadline).foregroundStyle(.accent)
                    
                }.padding(6).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(Color.windowColored).stroke(.window, style: StrokeStyle(lineWidth: 1))
                }.shadow(color: .accent.opacity(0.2), radius: 10).offset(x: animated ? 12 : 0)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                ZStack (alignment: .top) {
                    
                    RoundedRectangle(cornerRadius: 8.0).fill(.windowColored).aspectRatio(0.7070707, contentMode: .fit).shadow(color: .accent.opacity(0.2), radius: 40).offset(x: 6, y: 28).scaleEffect(animated ? 2.2 : 2.1).rotationEffect(Angle(degrees: animated ? 8 : 6))
                    
                    ZStack (alignment: .top) {
                        RoundedRectangle(cornerRadius: 8.0).fill(.windowColored)
                        
                        VStack (spacing: 5) {
                            RoundedRectangle(cornerRadius: 32.0).fill(.accentLightest).frame(height: 5)
                            
                            RoundedRectangle(cornerRadius: 32.0).fill(.accentLightest).frame(height: 5).padding(.trailing, 8)
                            
                            RoundedRectangle(cornerRadius: 32.0).fill(.accentLightest).frame(height: 5).padding(.trailing, 4)
                        }.padding(8)
                        
                    }.aspectRatio(0.7070707, contentMode: .fit).shadow(color: .accent.opacity(0.2), radius: 40).offset(x: -6, y: 22).scaleEffect(animated ? 2.1 : 2.0).rotationEffect(Angle(degrees: 1))
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
            
            ColorBackgroundView()
            
        }.clipShape(RoundedRectangle(cornerRadius: 24.0)).onAppear() {
            withAnimation(.easeInOut(duration: 1)) {
                animated = true
            }
        }
    }
}

#Preview {
    AITextBenefitView()
}
