//
//  BackButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct BackButtonView: View {
    
    let clickHandler: () -> Void
    var text = NSLocalizedString("back", comment: "")
    
    var body: some View {
        Button(action: clickHandler, label: {
            HStack (spacing: 0) {
                Image(systemName: "chevron.left").fontWeight(.semibold).padding(.trailing, 3)
                Text(text)
            }.offset(x: -8)
        })
    }
}

#Preview {
    BackButtonView(clickHandler: {})
}
