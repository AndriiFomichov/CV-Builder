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
    
    var body: some View {
        VStack {
            
            ProgressAnimationView(isLoading: $isLoading, initialIcon: icon).frame(width: 96, height: 96).padding(.bottom)
            
            Text(header).font(.title).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
            
            Text(description).foregroundStyle(Color.text).multilineTextAlignment(.center)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
    }
}

#Preview {
    AiLoadingView(isLoading: .constant(true), header: .constant("Header"), description: .constant("Description"), icon: .constant("square.and.arrow.up.fill"))
}
