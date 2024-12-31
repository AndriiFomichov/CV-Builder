//
//  AiTranslatingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiTranslatingViewModel: ObservableObject {
    
    let manager = AiTranslator()
    
    var cv: CVEntity?
    
    var selectedLanguage = -1
    @Published var languages: [Language] = []
    @Published var btnMainSelected = false
    @Published var icon = "globe"
    @Published var header = NSLocalizedString("ai_translating", comment: "")
    @Published var isLoading = false
    @Published var loadingShown = false
    
    @Published var errorAlertShown = false
    
    var parentViewModel: EditorAiAssistantViewModel?
    
    func updateData (parentViewModel: EditorAiAssistantViewModel) {
        self.parentViewModel = parentViewModel
        self.cv = parentViewModel.cv
        updateLanguages()
    }
    
    private func updateLanguages () {
        let list = PreloadedDatabase.getLanguages()
        if selectedLanguage != -1, selectedLanguage < list.count {
            list[selectedLanguage].isSelected = true
            btnMainSelected = true
        }
        languages = list
    }
    
    func selectLanguage (index: Int) {
        if index != selectedLanguage {
            for i in 0...languages.count-1 {
                let lang = languages[i]
                if i == index {
                    lang.isSelected = true
                } else {
                    lang.isSelected = false
                }
                languages[i] = lang
            }
        }
        selectedLanguage = index
        btnMainSelected = true
    }
    
    func translate () {
        if selectedLanguage != -1 {
            Task {
                await performTranslating()
            }
        } else {
            errorAlertShown = true
        }
    }
    
    @MainActor
    private func performTranslating () async {
        if let cv {
            loadingShown = true
            
            isLoading = true
            updateParentIsLoading()
            
            let language = PreloadedDatabase.getLanguageById(id: selectedLanguage)
            await manager.translateCv(cv: cv, langId: selectedLanguage, language: language.name)
            
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
