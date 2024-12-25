//
//  AiLimitsView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct AiLimitsView: View {
    var body: some View {
        VStack {
            
            Text(NSLocalizedString("ai_limits", comment: "")).font(.title2).bold().foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 4)
         
            Text(NSLocalizedString("ai_limits_desc_one", comment: "")).font(.subheadline).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
            
            HStack {
                
                VStack (spacing: 0) {
                    
                    Text("30").font(.largeTitle).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(1).padding(.bottom, 4)
                    
                    Text(NSLocalizedString("ai_limits_resumes", comment: "")).font(.caption).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(2)
                    
                }.padding(8).background() {
                    RoundedRectangle(cornerRadius: 16).fill(.windowColored)
                }
                
                VStack (spacing: 0) {
                    
                    Text("20").font(.largeTitle).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).lineLimit(1).padding(.bottom, 4)
                    
                    Text(NSLocalizedString("ai_limits_assistant", comment: "")).font(.caption).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(2)
                    
                }.padding(8).background() {
                    RoundedRectangle(cornerRadius: 16).fill(.windowColored)
                }
                
                VStack (spacing: 0) {
                    
                    Text("200").font(.largeTitle).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(1).padding(.bottom, 4)
                    
                    Text(NSLocalizedString("ai_limits_text", comment: "")).font(.caption).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(2)
                    
                }.padding(8).background() {
                    RoundedRectangle(cornerRadius: 16).fill(.windowColored)
                }
                
            }.padding(.bottom)
            
            Text(NSLocalizedString("ai_limits_desc_two", comment: "")).font(.subheadline).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center)
        }
    }
}

#Preview {
    AiLimitsView()
}
