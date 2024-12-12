//
//  KeyboardActionsView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct KeyboardActionsView: View {
    
    let clearHanlder: () -> Void
    let doneHanlder: () -> Void
    
    var body: some View {
        HStack {
//            SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("clear", comment: ""), clickHandler: clearHanlder, textColor: .textAdditional, backgroundColor: .windowTwo)
            
            Spacer()
            
            SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("done", comment: ""), clickHandler: doneHanlder)
            
        }.padding(8).background() {
            UnevenRoundedRectangle(topLeadingRadius: 20.0, topTrailingRadius: 20.0).fill(Color.window)
        }
    }
}

#Preview {
    KeyboardActionsView(clearHanlder: {}, doneHanlder: {})
}
