//
//  ShareParamsViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation
import SwiftyUserDefaults

class ShareParamsViewModel: ObservableObject {
    
    var quality = 0
    
    @Published var name = ""
    @Published var qualityParams: [Quality] = []
    
    @Published var btnBadgeVisible = false
    @Published var lockedIconVisible = false
    @Published var attemptsText = ""
    @Published var btnMainSelected = false
    @Published var btnMainText = ""
    
    @Published var paywallSheetShown = false
    @Published var nextStepPresented = false
    @Published var errorDialogShown = false
    
    var parentViewModel: ShareViewModel?
    
    func updateData (parentViewModel: ShareViewModel) {
        self.parentViewModel = parentViewModel
        updateAccount()
        getData()
        updateQuality()
        updateMainButton()
        AnalyticsManager.saveEvent(event: Events.SHARE_PARAMS_OPENED)
    }
    
    private func updateAccount () {
        if Defaults.KEY_ACCOUNT_TYPE == 0 {
            if AiManager.getExportAttempts() > 0 {
                lockedIconVisible = false
                btnMainText = NSLocalizedString("create_files", comment: "")
                attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: String(AiManager.getExportAttempts()))
            } else {
                lockedIconVisible = true
                btnMainText = NSLocalizedString("upgrade_you_plan_to_export", comment: "")
                attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: "0")
            }
            btnBadgeVisible = true
        } else {
            btnBadgeVisible = false
            lockedIconVisible = false
            btnMainText = NSLocalizedString("create_files", comment: "")
            attemptsText = ""
        }
    }
    
    private func getData () {
        if let parentViewModel {
            name = parentViewModel.name
            quality = parentViewModel.quality
        }
    }
    
    private func updateQuality () {
        let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
        let list = PreloadedDatabase.getExportQualityList(isUserPremium: isUserPremium)
        for item in list {
            if item.id == quality {
                item.isSelected = true
            }
        }
        qualityParams = list
    }
    
    func updateQualityPremiumVisible () {
        if Defaults.KEY_ACCOUNT_TYPE != 0 {
            for i in 0..<qualityParams.count {
                let item = qualityParams[i]
                item.isPremiumVisible = false
                qualityParams[i] = item
            }
        }
    }
    
    func saveName () {
        if let parentViewModel {
            parentViewModel.name = name
            updateMainButton()
        }
    }
    
    func selectQuality (index: Int) {
        let qualityParam = qualityParams[index]
        
        if qualityParam.isPremium && qualityParam.isPremiumVisible {
            showPaywallSheet()
        } else {
            if index != quality {
                for i in 0...qualityParams.count-1 {
                    let item = qualityParams[i]
                    if i == index {
                        item.isSelected = true
                    } else {
                        item.isSelected = false
                    }
                    qualityParams[i] = item
                }
            }
            quality = index
            if let parentViewModel {
                parentViewModel.quality = quality
                updateMainButton()
            }
        }
    }
    
    private func updateMainButton () {
        btnMainSelected = !name.isEmpty && quality != -1
    }
    
    func showPaywallSheet () {
        paywallSheetShown = true
    }
    
    func handlePaywallSheetFinished () {
        if Defaults.KEY_ACCOUNT_TYPE == 1 {
            
            updateAccount()
            
            for i in 0...qualityParams.count-1 {
                let item = qualityParams[i]
                item.isPremiumVisible = false
                qualityParams[i] = item
            }
        }
    }
    
    func nextStep () {
        if btnMainSelected {
            if Defaults.KEY_ACCOUNT_TYPE == 0 && AiManager.getExportAttempts() <= 0 {
                showPaywallSheet()
            } else {
                if let parentViewModel {
                    parentViewModel.saveName()
                }
                nextStepPresented = true
            }
        } else {
            errorDialogShown = true
        }
    }
}
