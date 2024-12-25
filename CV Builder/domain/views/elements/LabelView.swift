//
//  LabelView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.12.2024.
//

import SwiftUI

struct LabelView: View {
    
    let text: String
    var backColor: Color = .accent
    var textColor: Color = .white
    var alignLeft: Bool = true
    
    var body: some View {
        HStack {
            Text(text).font(.subheadline).foregroundStyle(textColor).multilineTextAlignment(.leading).padding(6).padding(.horizontal, 8).background() {
                RoundedRectangle(cornerRadius: 24.0).fill(backColor)
            }
            if alignLeft {
                Spacer()
            }
        }
    }
}

#Preview {
    LabelView(text: "Text")
}
