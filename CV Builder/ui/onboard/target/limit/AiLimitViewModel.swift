//
//  AiLimitViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.12.2024.
//

import Foundation

class AiLimitViewModel: ObservableObject {
    
    @Published var description = ""
    @Published var tipHeader = ""
    @Published var tipDescription = ""
    
    func updateData (type: Int) {
        if type == 0 {
            loadGenerationLimits()
        } else if type == 1 {
            loadAssistantLimits()
        } else if type == 2 {
            loadTextLimits()
        }
    }
    
    private func loadGenerationLimits () {
        description = NSLocalizedString("ai_limit_description_generation", comment: "")
        tipHeader = NSLocalizedString("number_resumes_header", comment: "")
        tipDescription = NSLocalizedString("number_resumes_description", comment: "")
    }
    
    private func loadAssistantLimits () {
        description = NSLocalizedString("ai_limit_description_assistant", comment: "")
        tipHeader = NSLocalizedString("number_assistant_header", comment: "")
        tipDescription = NSLocalizedString("number_assistant_description", comment: "")
    }
    
    private func loadTextLimits () {
        description = NSLocalizedString("ai_limit_description_text", comment: "")
        tipHeader = NSLocalizedString("number_texts_header", comment: "")
        tipDescription = NSLocalizedString("number_texts_description", comment: "")
    }
}
