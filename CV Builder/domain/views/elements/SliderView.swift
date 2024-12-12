//
//  SliderView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct SliderView: View {
    
    @Binding var value: Int
    let dragEndHandler: () -> Void
        
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Int> = 0...100
    var thumbColor: Color = .window
    var thumbStrokeColor: Color = .accent
    var minTrackColor: Color = .accentLight
    var maxTrackColor: Color = .windowTwo
    
    var body: some View {
        GeometryReader { gr in
            let thumbHeight = gr.size.height * 1.4
            let thumbWidth = gr.size.height * 1.4
            let radius = gr.size.height * 0.5
            let minValue = gr.size.width * 0.0
            let maxValue = (gr.size.width * 1.0) - thumbWidth
            
            let scaleFactor = (maxValue - minValue) / Double(sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = Double(self.value - lower) * scaleFactor + minValue
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(maxTrackColor)
                    .frame(width: gr.size.width, height: gr.size.height * 0.95)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                
                HStack {
                    Rectangle()
                        .foregroundColor(minTrackColor)
                    .frame(width: sliderVal + thumbWidth / 2, height: gr.size.height * 0.95)
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                
                HStack {
                    Circle().fill(thumbColor)
                        .stroke(thumbStrokeColor, lineWidth: 3)
                        .frame(width: thumbWidth, height: thumbHeight)
                        .offset(x: sliderVal)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if v.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = Int(((nextCoordinateValue - minValue) / scaleFactor)) + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = Int(((nextCoordinateValue - minValue) / scaleFactor)) + lower
                                    }
                                }.onEnded { e in
                                    dragEndHandler()
                                }
                        )
                    Spacer()
                }
                
            }.position(x: gr.size.width / 2, y: gr.size.height / 2)
        }
    }
}

#Preview {
    SliderView(value: .constant(50), dragEndHandler: {})
}
