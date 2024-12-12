//
//  ShareView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct ShareView: View {
    
    let cv: CVEntity?
    @StateObject var viewModel = ShareViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ShareFormatView(sheetClosed: $viewModel.sheetClosed)
            }.onAppear() {
                viewModel.updateData(cv: cv)
            }
        }.environmentObject(viewModel).tint(Color.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    ShareView(cv: nil)
}
