//
//  PageIndicatorView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.12.2024.
//

import SwiftUI

struct PageIndicatorView: View {
    
    @Binding var currentPage: Int
    var pages: Int
    
    var selectedColor: Color = .accent
    var inactiveColor: Color = .window
    var height: CGFloat = 10.0
    
    @State var pageState = -1
    
    var body: some View {
        HStack (spacing: 6) {
            ForEach(0..<pages, id: \.self) { index in
                Circle().fill(pageState == index ? selectedColor : inactiveColor).frame(height: height).scaleEffect(pageState == index ? 1.2 : 1.0)
            }
        }.onAppear() {
            withAnimation {
                pageState = currentPage
            }
        }.onChange(of: currentPage) {
            withAnimation {
                pageState = currentPage
            }
        }
    }
}

#Preview {
    @Previewable @State var page = 0
    PageIndicatorView(currentPage: $page, pages: 5)
}
