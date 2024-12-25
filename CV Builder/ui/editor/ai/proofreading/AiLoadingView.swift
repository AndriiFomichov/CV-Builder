//
//  AiLoadingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct AiLoadingView: View {
    
    @Binding var isLoading: Bool
    @Binding var header: String
    @Binding var description: String
    @Binding var icon: String
    
    var namespaceAnimation: Namespace.ID
    
    var body: some View {
        VStack {
            
            ProgressAnimationView(isLoading: $isLoading, initialIcon: icon).frame(width: 96, height: 96).padding(.bottom)
            
            Text(header).font(.title).bold().foregroundStyle(Color.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 4).matchedGeometryEffect(id: "Header", in: namespaceAnimation)
            
            Text(description).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).matchedGeometryEffect(id: "Description", in: namespaceAnimation)
            
        }.padding(8).frame(maxWidth: .infinity, maxHeight: .infinity).background() {
            
            ColoredBackgroundLargeView().matchedGeometryEffect(id: "Back", in: namespaceAnimation)
            
        }.clipShape(RoundedRectangle(cornerRadius: 20.0)).padding(.horizontal).padding(.bottom)
    }
}

#Preview {
    @Previewable @Namespace var namespace
    AiLoadingView(isLoading: .constant(true), header: .constant("Header"), description: .constant("Description"), icon: .constant("square.and.arrow.up.fill"), namespaceAnimation: namespace)
}
