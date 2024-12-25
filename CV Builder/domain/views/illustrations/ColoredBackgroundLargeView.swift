//
//  ColoredBackgroundLargeView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.12.2024.
//

import SwiftUI

struct ColoredBackgroundLargeView: View {
    
    var animating: Bool = true
    
    @State var moving = false
    
    let opacityVariants: [CGFloat] = [ 1.0, 0.8, 0.6, 0.3 ]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [ .windowColored, .windowColoredLight ], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack {
                HStack {
                    Spacer()
                    Circle().fill(Color.circleColored.opacity(moving ? opacityVariants.randomElement()! : 1.0)).blur(radius: 60.0).frame(width: 150, height: 150).offset(x: 20, y: moving ? 30 : 0).scaleEffect(moving ? 1.1 : 1.0)
                }
                
                Spacer()
                
                HStack {
                    Circle().fill(Color.circleColored.opacity(moving ? opacityVariants.randomElement()! : 1.0)).blur(radius: 60.0).frame(width: 250, height: 250).offset(x: -50, y: moving ? -50 : 0).scaleEffect(moving ? 1.1 : 1.0)
                    Spacer()
                }
            }
        }.onAppear() {
            if animating {
                withAnimation (.easeInOut(duration: 2.7).repeatForever(autoreverses: true)) {
                    moving.toggle()
                }
            }
        }.clipped()
    }
}

#Preview {
    ColoredBackgroundLargeView()
}
