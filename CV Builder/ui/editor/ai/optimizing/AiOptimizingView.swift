//
//  AiOptimizingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct AiOptimizingView: View {
    
    @EnvironmentObject var parentViewModel: EditorAiAssistantViewModel
    @StateObject var viewModel = AiOptimizingViewModel()

    @State var header = ""
    @State var showLoading = false
    
    var namespaceAnimation: Namespace.ID
    
    var body: some View {
        VStack (spacing: 0) {
            
            if showLoading {
                AiLoadingView(isLoading: $viewModel.isLoading, header: $header, description: .constant(NSLocalizedString("couple_minutes_save_hours", comment: "")), icon: $viewModel.icon, namespaceAnimation: namespaceAnimation)
            } else {
                AiOptimizingTargetView(targetJob: $viewModel.targetJob, targetCompany: $viewModel.targetCompany, targetDescription: $viewModel.targetDescription, btnMainSelected: $viewModel.btnMainSelected, errorAlertShown: $viewModel.errorAlertShown, mainClickHandler: {
                    viewModel.optimize()
                }, textChangeHandler: {
                    viewModel.updateBtnMain()
                }, namespaceAnimation: namespaceAnimation)
            }
            
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onChange(of: viewModel.loadingShown) {
            header = viewModel.header
            withAnimation {
                showLoading = viewModel.loadingShown
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
    AiOptimizingView(namespaceAnimation: namespace).environmentObject(EditorAiAssistantViewModel())
}
