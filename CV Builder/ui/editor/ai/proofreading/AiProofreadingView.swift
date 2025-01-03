//
//  AiProofreadingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct AiProofreadingView: View {
    
    @EnvironmentObject var parentViewModel: EditorAiAssistantViewModel
    @StateObject var viewModel = AiProofreadingViewModel()

    @State var header = ""
    @State var showResults = false
    
    var namespaceAnimation: Namespace.ID
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                if showResults {
                    if viewModel.completeTypos > 0 {
                        AIProofreadingMistakesView(percent: viewModel.completePercent, texts: viewModel.completeTexts, typos: viewModel.completeTypos, mistakes: viewModel.completeMistakes, namespaceAnimation: namespaceAnimation)
                    } else {
                        AiProofreadingSuccessView(percent: viewModel.completePercent, texts: viewModel.completeTexts, typos: viewModel.completeTypos, namespaceAnimation: namespaceAnimation)
                    }
                } else {
                    AiLoadingView(isLoading: $viewModel.isLoading, header: $header, description: .constant(NSLocalizedString("couple_minutes_save_hours", comment: "")), icon: $viewModel.icon, namespaceAnimation: namespaceAnimation)
                }
            }
            
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
            header = viewModel.header
        }.onChange(of: viewModel.resultShown) {
            withAnimation {
                showResults = viewModel.resultShown
            }
        }.onChange(of: viewModel.header) {
            withAnimation {
                header = viewModel.header
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    AiProofreadingView(namespaceAnimation: namespace).environmentObject(EditorAiAssistantViewModel())
}
