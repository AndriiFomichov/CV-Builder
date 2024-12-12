//
//  ArrowExpandView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct ArrowExpandView: View {
    
    @Binding var optionsShown: Bool
    
    var body: some View {
        ZStack {
            
            Image(systemName: "chevron.down").font(.subheadline).foregroundStyle(.textAdditional).rotationEffect(optionsShown ? Angle(degrees: 180) : Angle(degrees: 0))
            
        }.frame(width: 32, height: 32).background() {
            Circle().fill(.windowTwo)
        }
    }
}

#Preview {
    ArrowExpandView(optionsShown: .constant(false))
}
