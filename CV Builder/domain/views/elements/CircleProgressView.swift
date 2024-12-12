//
//  CircleProgressView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct CircleProgressView: View {
    
    let progress: CGFloat
    var lineWidth: CGFloat = 8
    var backColor = Color.white
    var progressColor = Color.accent
    var textColor = Color.text
    var duration = 0.35
    var font: SwiftUI.Font = .title2
    
    @State var progressValue: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(1.0)
                .foregroundColor(backColor)

            Circle()
                .trim(from: 0.0, to: min(progressValue, 1.0))
                .stroke(style: StrokeStyle(lineWidth: lineWidth + 0.2, lineCap: .round, lineJoin: .round))
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: 270.0))
            
            Text(String(Int(progressValue * 100)) + "%").font(font).bold().foregroundColor(textColor)
            
        }.onAppear() {
            withAnimation (.easeInOut(duration: duration)) {
                self.progressValue = progress
            }
        }.onChange(of: progress) {
            withAnimation (.easeInOut(duration: duration)) {
                self.progressValue = progress
            }
        }
    }
}

#Preview {
    CircleProgressView(progress: 0.25)
}

