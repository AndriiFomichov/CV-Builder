//
//  EditorBottomView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorBottomView: View {
    
    @EnvironmentObject var viewModel: EditorViewModel
    
    var body: some View {
        HStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.bottomActionsList.indices, id: \.self) { index in
                        EditorActionView(action: viewModel.bottomActionsList[index])
                    }
                }.padding()
            }
            
            SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("share", comment: ""), icon: "square.and.arrow.up.fill", clickHandler: {
                viewModel.share()
            }).padding(8)
            
        }.background() {
            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 20.0, topTrailing: 20.0)).fill(Color.background)
        }
    }
}

#Preview {
    EditorBottomView().environmentObject(EditorViewModel())
}
