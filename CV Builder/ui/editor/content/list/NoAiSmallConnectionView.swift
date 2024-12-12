//
//  NoAiSmallConnectionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 03.12.2024.
//

import SwiftUI

struct NoAiSmallConnectionView: View {
    var body: some View {
        HStack {
            
            Image(systemName: "network.slash").font(.subheadline).foregroundStyle(Color.error)
            
            Text(NSLocalizedString("check_connection", comment: "")).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).lineLimit(1)
            
        }.frame(maxWidth: .infinity, alignment: .center).padding(8).padding(.horizontal, 4).background() {
            RoundedRectangle(cornerRadius: 12.0).fill(Color.windowTwo)
        }.padding(.horizontal, 8)
    }
}

#Preview {
    NoAiSmallConnectionView()
}
