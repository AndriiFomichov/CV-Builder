//
//  OnBoardView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct OnBoardView: View {
    
    var generationHandler: (_ cv: CVEntity?) -> Void
    
    @StateObject var viewModel = OnBoardViewModel()
    
    var body: some View {
        NavigationStack {
            OnBoardFrontView(sheetClosed: $viewModel.sheetClosed).onChange(of: viewModel.sheetClosed) {
                if viewModel.sheetClosed {
                    generationHandler(viewModel.cv)
                }
            }
        }.environmentObject(viewModel).tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    OnBoardView(generationHandler: { cv in })
}
