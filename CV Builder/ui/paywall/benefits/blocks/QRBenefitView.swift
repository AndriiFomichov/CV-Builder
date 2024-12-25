//
//  QRBenefitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct QRBenefitView: View {
    
    @State var animated = false
    
    var body: some View {
        HStack {
            
            Text(NSLocalizedString("benefit_qr_codes", comment: "")).font(.title2).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).lineLimit(3).padding().padding(.vertical)
            
        }.background() {
            
            ColorBackgroundView(alignment: .topTrailing)
            
        }.overlay {
            HStack {
                
                Image("qr_icon").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.accentLightest).padding(12).background() {
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.windowColored).shadow(color: .accent.opacity(0.2), radius: 40)
                }.offset(x: 12, y: 12).scaleEffect(animated ? 1.0 : 0.9).rotationEffect(Angle(degrees: animated ? 5 : 2))
                
                Spacer()
                
                Image("qr_icon").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.accentLightest).padding(12).background() {
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.windowColored).shadow(color: .accent.opacity(0.1), radius: 40)
                }.offset(x: -12, y: -12).scaleEffect(animated ? 0.95 : 0.85).rotationEffect(Angle(degrees: animated ? 12 : -2))
                
            }
        }.clipShape(RoundedRectangle(cornerRadius: 24.0)).onAppear() {
            withAnimation(.easeInOut(duration: 1)) {
                animated = true
            }
        }
    }
}

#Preview {
    QRBenefitView()
}
