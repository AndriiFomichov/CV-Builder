//
//  BorderLoadingAnimation.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct BorderLoadingAnimation: ViewModifier, Animatable {
    
    @Binding var isAnimating: Bool
    var cornersRadius: CGFloat = 16.0
    
    private let lineWidth: CGFloat = 2
    @State private var hasTopSafeAreaInset: Bool = false
    @State var opacity: CGFloat = 0.0
    @State var isPlaying = false
    
    var animatableData: Bool {
        get { isAnimating }
        set { isAnimating = newValue }
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    
//                    let height = geometry.size.height
//                    let width = geometry.size.width
//                    
//                    let insettedDiameter = cornersRadius * 2 - lineWidth
//                    let desiredDash: CGFloat = height / 2
//                    // note that we need to take the inset of strokeBorder into account
//                    // or just use stroke instead of strokeBorder to make this simpler
//                    let perimeter = (width - lineWidth / 2 - insettedDiameter) * 2 + // horizontal straight edges
//                                    (height - lineWidth / 2 - insettedDiameter) * 2 + // vertical straight edges
//                                    (insettedDiameter * .pi) // the circular parts
//
//                    // this finds the smallest adjustedDash such that
//                    // - perimeter is an integer multiple of adjustedDash
//                    // - adjustedDash > desiredDash
//                    let floored = floor(perimeter / desiredDash)
//                    let adjustedDash = (perimeter - desiredDash * floored) / floored + desiredDash
                    
                    RoundedRectangle(cornerRadius: hasTopSafeAreaInset ? 0 : cornersRadius)
                        .stroke(
                            AngularGradient(
                                stops: [
                                    .init(color: Color.window, location: 0),
                                    .init(color: Color.accent, location: 0.1),
                                    .init(color: Color.accent, location: 0.4),
                                    .init(color: Color.window, location: 0.5)
                                ],
                                center: .center,
                                angle: .degrees(isPlaying ? 360 : 0)
                            ),
                            lineWidth: lineWidth
                        )
//                        .stroke(Color.accent, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: [ adjustedDash ], dashPhase: isPlaying ? 0 : (adjustedDash) * 2))
                        .opacity(opacity)
                        .frame(width: geometry.size.width - lineWidth, height: geometry.size.height - lineWidth)
                        .padding(.top, lineWidth / 2)
                        .padding(.leading, lineWidth / 2)
                        .onAppear {
                            let topSafeAreaInset = geometry.safeAreaInsets.top
                            hasTopSafeAreaInset = topSafeAreaInset > 20
                            
                            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                isPlaying = true
                            }
                            
                            opacity = isAnimating ? 1.0 : 0.0
                            
                        }.onChange(of: isAnimating) {
                            withAnimation {
                                opacity = isAnimating ? 1.0 : 0.0
                            }
                        }
                }
            )
    }
}
