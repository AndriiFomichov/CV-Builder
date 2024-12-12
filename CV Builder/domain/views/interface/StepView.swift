//
//  StepView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct StepView: View {
    
    @Binding var currentStep: Int
    var totalSteps = 4
    
    @State var selectedStep = 0
    @State var selectedLineWidth: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                ZStack (alignment: .leading) {
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.accent).frame(width: selectedLineWidth)
                }.frame(height: 8)
                
                HStack {
                    ForEach(0..<totalSteps, id:\.self) { step in
                        Circle().fill(step == selectedStep ? Color.window : (step < selectedStep ? Color.accent : Color.windowTwo)).stroke(step > selectedStep ? .window : .accent, style: StrokeStyle(lineWidth: 2))
                        
                        if step != totalSteps - 1 {
                            Spacer()
                        }
                    }
                }
                
            }.onAppear() {
                withAnimation {
                    selectedStep = currentStep
                    if CGFloat((Float(currentStep) / Float(totalSteps - 1))) <= 1.0 {
                        selectedLineWidth = geo.size.width * CGFloat((Float(currentStep) / Float(totalSteps - 1)))
                    } else {
                        selectedLineWidth = geo.size.width
                    }
                }
            }.onChange(of: currentStep) {
                withAnimation {
                    selectedStep = currentStep
                    if CGFloat((Float(currentStep) / Float(totalSteps - 1))) <= 1.0 {
                        selectedLineWidth = geo.size.width * CGFloat((Float(currentStep) / Float(totalSteps - 1)))
                    } else {
                        selectedLineWidth = geo.size.width
                    }
                }
            }
        }.frame(height: 18).frame(maxWidth: 200)
    }
}

#Preview {
    StepView(currentStep: .constant(3))
}
