//
//  SideMenuViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class SideMenuViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    
    @Published var userNameSide = ""
    @Published var userPhotoSide: UIImage?
    @Published var userFillSide: CGFloat = 0.0
    @Published var isPremiumSide = false
    @Published var version = ""
    
    @Published var profileSheetShown: Bool = false
    @Published var paywallSheetShown: Bool = false
    @Published var rightsSheetShown: Bool = false
    @Published var openSubscriptionPage: Bool = false
    
    func updateData () {
        updateVersion()
    }
    
    private func updateVersion () {
        var text = ""
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        if let appName = appName {
            text = text + appName
        }
        if let appVersion = appVersion {
            text = text + " - " + appVersion
        }
        version = text
    }
    
    func openSubscriptionsList () {
        if Defaults.KEY_ACCOUNT_TYPE == 0 {
            showPaywallSheet()
        } else {
            openSubscriptionPage.toggle()
        }
    }
    
    func openProfileSheet () {
        profileSheetShown = true
    }
    
    func handleProfileSheetShown () {
        updateAccount()
    }
    
    func showPaywallSheet () {
        paywallSheetShown = !paywallSheetShown
    }
    
    func handlePaywallSheetShown () {
        updatePlan()
    }
    
    func showRightsSheet () {
        rightsSheetShown = !rightsSheetShown
    }
    
    private func updatePlan () {
        isPremiumSide = Defaults.KEY_ACCOUNT_TYPE != 0
    }
    
    private func updateAccount () {
        updatePlan()
        
        if let profile = profileManager.getProfile() {
            
            userNameSide = profile.name
            userFillSide = profileManager.getProfileFillPercent(profile: profile)
            
            Task {
                await loadProfilePhoto(id: profile.photoId)
            }
        }
    }
    
    @MainActor
    private func loadProfilePhoto (id: Int) async {
        if let image = DatabaseBox.getImage(id: id), let data = image.image, let uiImage = UIImage(data: data) {
            userPhotoSide = await uiImage.resizeAsync(height: 120)
        }
    }
}
