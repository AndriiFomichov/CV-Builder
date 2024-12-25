//
//  AiProofreadingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiProofreadingViewModel: ObservableObject {
    
    let manager = AiProofreader()
    
    var cv: CVEntity?
    
    @Published var icon = "text.viewfinder"
    @Published var header = NSLocalizedString("ai_proofreading", comment: "")
    @Published var isLoading = true
    @Published var resultShown = false
    @Published var completePercent: Float = 0.0
    @Published var completeTexts = 0
    @Published var completeTypos = 0
    @Published var completeMistakes: [Mistake] = []
    
    var parentViewModel: EditorAiAssistantViewModel?
    
    func updateData (parentViewModel: EditorAiAssistantViewModel) {
        self.parentViewModel = parentViewModel
        self.cv = parentViewModel.cv
        
        Task {
            await startProofreading()
        }
    }
    
    @MainActor
    private func startProofreading () async {
        if let cv {
            isLoading = true
            updateParentIsLoading()
            
            let result = await manager.proofreadCv(cv: cv)
            
            header = NSLocalizedString("complete", comment: "")
            
            isLoading = false
            
            do {
                try await Task.sleep(for: .seconds(2))
            } catch let error {
                print(error.localizedDescription)
            }
            
            updateParentIsLoading()
            
            displayResults(mistakes: result.mistakes, texts: result.texts, correct: result.correct)
        }
    }
    
    @MainActor
    private func displayResults (mistakes: [Mistake], texts: Int, correct: Int) {
        completeMistakes = mistakes
        completeTexts = texts
        completeTypos = texts - correct
        if texts > 0 {
            completePercent = Float(correct) / Float(texts)
        }
        resultShown = true
        updatePreview()
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
