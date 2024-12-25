//
//  WatermarkBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct WatermarkBenefitView: View {
    
    var body: some View {
        VStack {
            
            ZStack {
                
                Text(NSLocalizedString("benefit_no_watermarks", comment: "")).font(.title3).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(3).padding([.leading, .trailing], 4).padding(.vertical, 8)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                RoundedRectangle(cornerRadius: 20.0).fill(Color.windowColored)
            }.padding(4)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
            
            ColorBackgroundView()
            
        }.clipShape(RoundedRectangle(cornerRadius: 24.0))
    }
}

#Preview {
    WatermarkBenefitView()
}
