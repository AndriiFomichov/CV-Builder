//
//  ConstructorTargetViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation
import SwiftyUserDefaults

class ConstructorTargetViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var jobTitle = ""
    @Published var company = ""
    @Published var description = ""
    
    @Published var attemptsVisible = false
    @Published var attemptsText = ""
    
    @Published var nextStepPresented = false
    
    @Published var guideSheetShown = false
    @Published var connectionSheetShown = false
    @Published var profileFillAlertShown = false
    @Published var limitSheetShown = false
    @Published var paywallSheetShown = false
    
    var parentViewModel: ConstructorViewModel?
    
    func updateData (parentViewModel: ConstructorViewModel) {
        self.parentViewModel = parentViewModel
        getData()
        updateAttempts()
        AnalyticsManager.saveEvent(event: Events.CONSTRUCTOR_TARGET_OPENED)
    }
    
    private func getData () {
        if let parentViewModel {
            jobTitle = parentViewModel.jobTitle
            company = parentViewModel.company
            description = parentViewModel.description
            profile = parentViewModel.profile
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
    
    func showConnectionSheet () {
        connectionSheetShown = true
    }
    
    func showProfileAlertSheet () {
        profileFillAlertShown = true
    }
    
    func showLimitsSheet () {
        limitSheetShown = true
    }
    
    func showGuideSheet () {
        guideSheetShown = true
    }
    
    func nextStep () {
        if AiManager.getCurrentAttempts() > 0 {
            if let profile {
                if profileManager.getIfProfileMainFilled(profile: profile) {
                    checkReachibility()
                } else {
                    showProfileAlertSheet()
                }
            } else {
                checkReachibility()
            }
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
    
    func checkReachibility () {
        if Reachability.isConnectedToNetwork() {
            startNextStep()
        } else {
            showConnectionSheet()
        }
    }
    
    func startNextStep () {
        saveData()
        nextStepPresented = true
    }
    
    private func saveData () {
        if let parentViewModel {
            parentViewModel.saveTargetJob(jobTitle: jobTitle, company: company, description: description)
        }
    }
}
