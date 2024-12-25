//
//  AIBackRemoverBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct AIBackRemoverBenefitView: View {
    
    @State var animated = false
    
    let rowOneColors = [ Color.windowColored, Color.window, Color.windowColored, Color.window, Color.windowColored, Color.window, Color.windowColored, Color.window, Color.windowColored ]
    
    let rowTwoColors = [ Color.window, Color.windowColored, Color.window, Color.windowColored, Color.window, Color.windowColored, Color.window, Color.windowColored, Color.window ]
    
    var body: some View {
        HStack {
            
            Text(NSLocalizedString("benefit_ai_back_remover", comment: "")).font(.title2).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3).padding([.leading, .top, .bottom])
            
            ZStack {
                
                ZStack {
                    
                    VStack (spacing: 0) {
                        ForEach(0...8, id: \.self) { row in
                            HStack (spacing: 0) {
                                ForEach(0...8, id: \.self) { column in
                                    Rectangle().fill(row % 2 == 0 ? rowOneColors[column] : rowTwoColors[column])
                                }
                            }
                        }
                    }
                    
                    LinearGradient(colors: [ Color.windowColored, Color.windowColored.opacity(0.6), Color.windowColored.opacity(0.0) ], startPoint: .leading, endPoint: .trailing)
                    
                    Image("profile_photo_seven_illustration").resizable().scaledToFit()
                    
                }.clipShape(RoundedRectangle(cornerRadius: 20.0)).padding()
                
            }.overlay {
                
                VStack {
                    
                    Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 22, height: 22).rotationEffect(animated ? Angle(degrees: 8) : Angle(degrees: 3)).offset(x: animated ? 32 : 20, y: animated ? 12 : 0)
                    
                    Spacer()
                    
                    Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 22, height: 22).rotationEffect(animated ? Angle(degrees: -6) : Angle(degrees: -3)).offset(x: animated ? -32 : -20, y: animated ? -20 : 0)
                }
                
            }.frame(width: 126, height: 126)
            
        }.background() {
            
            ColorBackgroundView(alignment: .topLeading)
            
        }.clipShape(RoundedRectangle(cornerRadius: 24.0)).onAppear() {
            withAnimation(.easeInOut(duration: 1)) {
                animated = true
            }
        }
    }
}

#Preview {
    AIBackRemoverBenefitView()
}
