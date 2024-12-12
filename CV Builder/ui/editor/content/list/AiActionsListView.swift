//
//  AiActionsListView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import SwiftUI

struct AiActionsListView: View {
    
    let actions: [String]
    let actionHandler: (_ position: Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                
                ForEach(actions.indices, id: \.self) { index in
                    AiActionView(name: actions[index], clickHandler: {
                        actionHandler(index)
                    })
                }
                
            }.padding(.horizontal, 8)
        }
    }
}

#Preview {
    AiActionsListView(actions: [ "Action 1",  "Action 2", "Action 3", ], actionHandler: { a in })
}
