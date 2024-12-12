//
//  HorizontalProgressView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct HorizontalProgressView: View {
    
    @Binding var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16.0).frame(width: geometry.size.width, height: 6).foregroundColor(.windowTwo)
                RoundedRectangle(cornerRadius: 16.0).frame(width: min(progress * geometry.size.width, geometry.size.width), height: 6).foregroundColor(.accent)
            }
        }
    }
}

#Preview {
    HorizontalProgressView(progress: .constant(0.2))
}
