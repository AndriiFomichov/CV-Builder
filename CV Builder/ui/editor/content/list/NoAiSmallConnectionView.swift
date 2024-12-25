//
//  NoAiSmallConnectionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 03.12.2024.
//

import SwiftUI

struct NoAiSmallConnectionView: View {
    
    @State var animating = false
    
    var body: some View {
        HStack {
            
            Image(systemName: "network.slash").font(.subheadline).foregroundStyle(.accentLight).symbolEffect(.bounce, value: animating).onAppear() {
                animating = true
            }
            
            Text(NSLocalizedString("check_connection", comment: "")).font(.subheadline).foregroundStyle(.accentLight).multilineTextAlignment(.center).lineLimit(1)
            
        }.frame(maxWidth: .infinity, alignment: .center).padding(8).padding(.horizontal, 4).background() {
            RoundedRectangle(cornerRadius: 24.0).fill(Color.windowColored)
        }.padding(.horizontal, 8)
    }
}

#Preview {
    NoAiSmallConnectionView()
}
