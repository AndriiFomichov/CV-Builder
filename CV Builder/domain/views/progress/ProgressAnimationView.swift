//
//  ProgressAnimationView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

struct ProgressAnimationView: View {
    
    @Binding var isLoading: Bool
    
    let initialIcon: String
    var successIcon = "checkmark.seal.fill"
    var lineWidth: CGFloat = 6
    
    @State var animate = false
    @State var icon = ""
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [ .accentLight, .accent ]),
                        startPoint: UnitPoint(x: animate ? 0.5 : -1, y: animate ? 0.5 : -0.5),
                        endPoint: UnitPoint(x: animate ? 2 : 0.5, y: animate ? 1.5 : 0.5)
                    ),
                    lineWidth: lineWidth
                )
            
            Image(systemName: icon).font(.title).foregroundStyle(LinearGradient(colors: [ .accent, .accentLight ], startPoint: .bottomTrailing, endPoint: .topLeading)).contentTransition(.symbolEffect(.replace))
            
        }.onAppear() {
            icon = initialIcon
            withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: true)) {
                animate = isLoading
            }
        }.onChange(of: isLoading) {
            withAnimation {
                animate = isLoading
                icon = isLoading ? initialIcon : successIcon
            }
        }
    }
}

#Preview {
    @Previewable @State var isLoading: Bool = true
    return ProgressAnimationView(isLoading: $isLoading, initialIcon: "square.and.arrow.up.fill")
}
