//
//  CVChangeViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 24.12.2024.
//

import Foundation
import SwiftyUserDefaults

class CVChangeViewModel: ObservableObject {
    
    @Published var changesList: [CVChange] = []
    @Published var attemptsText = ""
    
    @Published var paywallSheetShown = false
    @Published var limitSheetShown = false
    @Published var connectionSheetShown = false
    @Published var applyAlertShown = false
    @Published var dismissed = false
    
    func updateData (changes: [CVChange]) {
        changesList = changes
        updateAttempts()
    }
    
    private func updateAttempts () {
        let attempsLeft = AiManager.getAiTextAttempts()
        let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
        
        if isUserPremium {
            attemptsText = NSLocalizedString("attempts_text_left_today", comment: "").replacingOccurrences(of: "3", with: String(attempsLeft))
        } else {
            attemptsText = NSLocalizedString("free_attempts_text_left", comment: "").replacingOccurrences(of: "3", with: String(attempsLeft))
        }
    }
    
    func selectChange (index: Int) {
        if index >= 0 && index < changesList.count {
            let change = changesList[index]
            change.isChangeEnabled.toggle()
            changesList[index] = change
        }
    }
    
    func selectChangeDescription (index: Int) {
        if index >= 0 && index < changesList.count {
            let change = changesList[index]
            
            if change.descriptionGenerationEnabled {
                change.descriptionGenerationEnabled.toggle()
                changesList[index] = change
            } else {
                
                if ifDescriptionAddingAvailable(change: change) {
                    change.descriptionGenerationEnabled.toggle()
                    changesList[index] = change
                } else {
                    let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
                    if isUserPremium {
                        showLimitSheet()
                    } else {
                        showPaywallSheet()
                    }
                }
                
            }
        }
    }
    
    private func ifDescriptionAddingAvailable (change: CVChange) -> Bool {
        let textAttempts = AiManager.getAiTextAttempts()
        
        var aiAttemptsUsed = 0
        for change in changesList {
            if change.descriptionGenerationEnabled {
                aiAttemptsUsed += change.descriptionGenerationsCount
            }
        }
        
        return aiAttemptsUsed + change.descriptionGenerationsCount <= textAttempts
    }
    
    func nextStep () {
        if getChangesCount() > 0 {
            if Reachability.isConnectedToNetwork() {
                showApplySheet()
            } else {
                connectionSheetShown = true
            }
        } else {
            dismissed = true
        }
    }
    
    private func getChangesCount () -> Int {
        var changes = 0
        for change in changesList {
            if change.isChangeEnabled {
                changes += 1
            }
        }
        return changes
    }
    
    func showApplySheet () {
        applyAlertShown = true
    }
    
    func showPaywallSheet () {
        paywallSheetShown = true
    }
    
    func handlePaywallSheetShown () {
        updateAttempts()
    }
    
    func showLimitSheet () {
        limitSheetShown = true
    }
}
