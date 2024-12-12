//
//  OnBoardTargetViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation
import SwiftyUserDefaults

class OnBoardTargetViewModel: ObservableObject {
    
    @Published var jobTitle = ""
    @Published var company = ""
    
    @Published var attemptsVisible = false
    @Published var attemptsText = ""
    
    @Published var nextStepPresented = false
    
    @Published var guideSheetShown = false
    @Published var limitSheetShown = false
    @Published var paywallSheetShown = false
    
    var parentViewModel: OnBoardViewModel?
    
    func updateData (parentViewModel: OnBoardViewModel) {
        self.parentViewModel = parentViewModel
        getData()
        updateAttempts()
        AnalyticsManager.saveEvent(event: Events.ONBOARD_TARGET_OPENED)
    }
    
    private func getData () {
        if let parentViewModel {
            jobTitle = parentViewModel.jobTitle
            company = parentViewModel.company
        }
    }
    
    private func updateAttempts () {
        let attempsLeft = AiManager.getCurrentAttempts()
        let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
        
        if isUserPremium {
            attemptsText = NSLocalizedString("attempts_left_today", comment: "").replacingOccurrences(of: "3", with: String(attempsLeft))
            attemptsVisible = true
        } else {
            attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: String(attempsLeft))
            attemptsVisible = attempsLeft < 3
        }
    }
    
    func showPaywallSheet () {
        paywallSheetShown = true
    }
    
    func handlePaywallSheetShown () {
        if Defaults.KEY_ACCOUNT_TYPE == 1 {
            updateAttempts()
        }
    }
    
    func showLimitsSheet () {
        limitSheetShown = true
    }
    
    func showGuideSheet () {
        guideSheetShown = true
    }
    
    func nextStep () {
        if AiManager.getCurrentAttempts() > 0 {
            saveData()
            nextStepPresented = true
        } else {
            let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
            if isUserPremium {
                showLimitsSheet()
                AnalyticsManager.saveEvent(event: Events.AI_CV_LIMIT)
            } else {
                showPaywallSheet()
            }
        }
    }
    
    private func saveData () {
        if let parentViewModel {
            parentViewModel.jobTitle = jobTitle
            parentViewModel.company = company
        }
    }
}
