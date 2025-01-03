//
//  AiOptimizingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiOptimizingViewModel: ObservableObject {
    
    let manager = AiOptimizer()
    
    var profile: ProfileEntity?
    var cv: CVEntity?
    
    @Published var targetJob = ""
    @Published var targetCompany = ""
    @Published var targetDescription = ""
    @Published var btnMainSelected = false
    @Published var icon = "briefcase.fill"
    @Published var header = NSLocalizedString("ai_optimizing", comment: "")
    @Published var isLoading = false
    @Published var loadingShown = false
    
    @Published var errorAlertShown = false
    
    var parentViewModel: EditorAiAssistantViewModel?
    
    func updateData (parentViewModel: EditorAiAssistantViewModel) {
        self.parentViewModel = parentViewModel
        cv = parentViewModel.cv
        profile = parentViewModel.profile
        updateBtnMain()
    }
    
    func updateBtnMain () {
        btnMainSelected = !targetJob.isEmpty || !targetCompany.isEmpty || !targetDescription.isEmpty
    }
    
    func optimize () {
        if !targetJob.isEmpty || !targetCompany.isEmpty {
            Task {
                await performOptimizing()
            }
        } else {
            errorAlertShown = true
        }
    }
    
    @MainActor
    private func performOptimizing () async {
        if let cv, let profile {
            loadingShown = true
            
            isLoading = true
            updateParentIsLoading()
            
            await manager.optimizeCv(cv: cv, profile: profile, targetJob: targetJob, targetCompany: targetJob, targetJobDescription: targetDescription)
            
            header = NSLocalizedString("complete", comment: "")
            
            isLoading = false
            updateParentIsLoading()
            updatePreview()
        }
    }
    
    private func updateParentIsLoading () {
        if let parentViewModel {
            parentViewModel.updateIsLoading(isLoading: isLoading)
        }
    }
    
    private func updatePreview () {
        if let parentViewModel {
            parentViewModel.updatePreview()
        }
    }
}
