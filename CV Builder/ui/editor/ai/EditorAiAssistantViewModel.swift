//
//  EditorAiAssistantViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import Foundation
import SwiftyUserDefaults

class EditorAiAssistantViewModel: ObservableObject {
    
    var cv: CVEntity?
    
    @Published var isLoading = false
    
    @Published var actions: [AiAssistantAction] = []
    @Published var attemptsText = ""
    
    @Published var screen = 0
    
    @Published var paywallSheetShown = false
    @Published var limitSheetShown = false
    
    @Published var waitErrorShown = false
    
    var parentViewModel: EditorViewModel?
    
    func updateData (parentViewModel: EditorViewModel) {
        self.parentViewModel = parentViewModel
        self.cv = parentViewModel.cv
        updateAttempts()
        updateList()
    }
    
    private func updateAttempts () {
        let attempsLeft = AiManager.getAiAssistantAttempts()
        let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
        
        if isUserPremium {
            attemptsText = NSLocalizedString("attempts_left_today", comment: "").replacingOccurrences(of: "3", with: String(attempsLeft))
        } else {
            attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: String(attempsLeft))
        }
    }
    
    private func updateList () {
        var list: [AiAssistantAction] = []
        
        list.append(AiAssistantAction(id: 0, header: NSLocalizedString("ai_proofread_header", comment: ""), description: NSLocalizedString("ai_proofread_description", comment: ""), icon: "sparkle.magnifyingglass", clickHandler: proofreadText))
        list.append(AiAssistantAction(id: 1, header: NSLocalizedString("ai_optimize_header", comment: ""), description: NSLocalizedString("ai_optimize_description", comment: ""), icon: "briefcase.fill", clickHandler: optimizeText))
        list.append(AiAssistantAction(id: 2, header: NSLocalizedString("ai_translate_header", comment: ""), description: NSLocalizedString("ai_translate_description", comment: ""), icon: "globe", clickHandler: translateText))
        
        actions = list
    }
    
    func proofreadText () {
        if checkIsAiActionsAvailable() {
            if Reachability.isConnectedToNetwork() {
                screen = 1
            }
        }
    }
    
    func optimizeText () {
        if checkIsAiActionsAvailable() {
            if Reachability.isConnectedToNetwork() {
                screen = 2
            }
        }
    }
    
    func translateText () {
        if checkIsAiActionsAvailable() {
            if Reachability.isConnectedToNetwork() {
                screen = 3
            }
        }
    }
    
    private func checkIsAiActionsAvailable () -> Bool {
        if AiManager.getAiAssistantAttempts() > 0 {
            return true
        } else {
            let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
            if isUserPremium {
                showLimitsSheet()
                AnalyticsManager.saveEvent(event: Events.AI_ASSISTANT_LIMIT)
            } else {
                showPaywallSheet()
            }
            return false
        }
    }
    
    func showPaywallSheet () {
        paywallSheetShown = true
    }
    
    func handlePaywallSheetShown () {
        updateAttempts()
    }
    
    func showLimitsSheet () {
        limitSheetShown = true
    }
    
    func updatePreview () {
        DatabaseBox.saveContext()
        if let parentViewModel {
            parentViewModel.updatePreview()
        }
    }
    
    func updateIsLoading (isLoading: Bool) {
        self.isLoading = isLoading
        if let parentViewModel {
            parentViewModel.isLoading = isLoading
        }
    }
    
    func back() {
        if screen == 0 {
            if let parentViewModel {
                parentViewModel.updateState(state: 0)
            }
        } else {
            if !isLoading {
                screen = 0
            } else {
                waitErrorShown = true
            }
        }
    }
}
