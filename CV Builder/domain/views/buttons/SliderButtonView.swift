//
//  SliderButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct SliderButtonView: View {
    
    var text: String
    @Binding var value: Int
    var sliderRange: ClosedRange<Int> = 0...100
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Text(String(value)).font(.headline).foregroundStyle(.accent).lineLimit(1)
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
            }.padding(8)
            
            Text(text).font(.subheadline).foregroundStyle(.text).frame(width: 80, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing).padding(.vertical, 4).lineLimit(2)
            
            SliderView(value: $value, dragEndHandler: {}, sliderRange: sliderRange).frame(height: 24).padding(.trailing, 4)
            
        }.frame(maxWidth: .infinity).background() {
            RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
        }
    }
}

#Preview {
    SliderButtonView(text: "Delete", value: .constant(5))
}
