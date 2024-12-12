//
//  ConstructorView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import SwiftUI

struct ConstructorView: View {
    
    let profile: ProfileEntity?
    
    var generationHandler: (_ cv: CVEntity?) -> Void
    
    @StateObject var viewModel = ConstructorViewModel()
    
    var body: some View {
        NavigationStack {
            ConstructorStyleView(sheetClosed: $viewModel.sheetClosed).onChange(of: viewModel.sheetClosed) {
                if viewModel.sheetClosed {
                    generationHandler(viewModel.cv)
                }
            }.onAppear() {
                viewModel.setProfile(profile: profile)
            }
        }.environmentObject(viewModel).tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    ConstructorView(profile: nil, generationHandler: { cv in })
}
