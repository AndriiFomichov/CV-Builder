//
//  KeyboardActionsAiView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.12.2024.
//

import SwiftUI

struct KeyboardActionsAiView: View {
    
    @Binding var actionAvailable: Bool
    
    let aiHanlder: (_ index: Int) -> Void
    let doneHanlder: () -> Void
    
    var body: some View {
        HStack {

            if actionAvailable {
                AiActionsListView (actions: [ NSLocalizedString("ai_rephrase", comment: ""), NSLocalizedString("ai_expand", comment: ""), NSLocalizedString("ai_shorten", comment: ""), NSLocalizedString("ai_to_bulleted", comment: ""), NSLocalizedString("ai_custom", comment: "") ], actionHandler: aiHanlder)
            } else {
                AiActionsListView (actions: [ NSLocalizedString("ai_generate_text", comment: "") ], actionHandler: aiHanlder)
            }
            
            SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("done", comment: ""), clickHandler: doneHanlder)
            
        }.padding(8).background() {
            UnevenRoundedRectangle(topLeadingRadius: 20.0, topTrailingRadius: 20.0).fill(Color.window)
        }
    }
}

#Preview {
    KeyboardActionsAiView(actionAvailable: .constant(true), aiHanlder: { i in }, doneHanlder: {})
}
