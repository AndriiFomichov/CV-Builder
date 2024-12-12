//
//  SelectedIndicatorView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct SelectedIndicatorView: View {
    
    @Binding var isSelected: Bool
    var type = 0
    
    @State var selectedState = false
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 12.0).stroke(selectedState ? .accent : .windowTwo, style: StrokeStyle(lineWidth: 2))
            
            if type == 0 {
                Circle().fill(selectedState ? .accent : .windowTwo).frame(width: 24, height: 24)
                
                if selectedState {
                    Image(systemName: "checkmark").font(.subheadline).bold().foregroundStyle(.white)
                }
            } else {
                Circle().fill(selectedState ? .accent : .windowTwo).frame(width: 18, height: 18)
            }
            
        }.frame(width: 36, height: 36).onAppear() {
            withAnimation {
                selectedState = isSelected
            }
        }.onChange(of: isSelected) {
            withAnimation {
                selectedState = isSelected
            }
        }
    }
}

#Preview {
    SelectedIndicatorView(isSelected: .constant(false))
}
