//
//  HomeViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftyUserDefaults
import UIKit

class HomeViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    let cvBuilder = CVBuilder()
    
    var profile: ProfileEntity?
    var selectedCV: CVEntity? = nil
    
    var defaultCvList: [CVItem?] = [ nil, nil, nil, nil, nil, nil, nil, nil, nil, nil ]
    
    @Published var userName = ""
    @Published var userPhoto: UIImage?
    @Published var userFill: CGFloat = 0.0
    @Published var isPremium = false
    @Published var cvList: [CVItem?] = []
    
    @Published var isLoading = false
    @Published var sideMenuShown = false
    @Published var paywallSheetShown = false
    @Published var onboardSheetShown = false
    @Published var shareSheetShown = false
    @Published var actionsSheetShown = false
    @Published var constructorSheetShown = false
    @Published var editorPresented = false
    @Published var notificationsRequestShown = false
    
    @Published var defaultErrorDialogShown = false
    
    var isVisible = false
    var showInitialPaywall = false
    var purchasesAvailable = false
    
    func updateData () {
        getProfile()
        updateUserInfo()
        Task {
            await updateList()
        }
        startOnBoardActions()
    }
    
    private func getProfile () {
        profile = profileManager.getProfile()
    }
    
    private func updateAccount () {
        isPremium = Defaults.KEY_ACCOUNT_TYPE != 0
    }
    
    private func updateUserInfo () {
        isPremium = Defaults.KEY_ACCOUNT_TYPE != 0
        
        if let profile {
            
            userName = profile.name
            userFill = profileManager.getProfileFillPercent(profile: profile)
            
            Task {
                await loadProfilePhoto(id: profile.photoId)
            }
        }
    }
    
    @MainActor
    private func loadProfilePhoto (id: Int) async {
        if let image = DatabaseBox.getImage(id: id), let data = image.image, let uiImage = UIImage(data: data) {
            userPhoto = await uiImage.resizeAsync(height: 120)
        }
    }
    
    @MainActor
    private func updateList () async {
        isLoading = true
        let ids = DatabaseBox.getCVsIdsOnly()
        var list: [CVItem] = []
        for i in 0..<ids.count {
            if let cv = await loadEntity(id: ids[i].id) {
                list.append(cv)
            }
        }
        cvList = list
        isLoading = false
    }
    
    private func loadEntity (id: String) async -> CVItem? {
        if let entity = DatabaseBox.getCV(id: id) {
            var previewOne: UIImage?
            var previewTwo: UIImage?
            if let data = entity.previewOne, let uiImage = UIImage(data: data) {
                previewOne = await uiImage.resizeAsync(height: 300)
            }
            if let data = entity.previewTwo, let uiImage = UIImage(data: data) {
                previewTwo = await uiImage.resizeAsync(height: 300)
            }
            return CVItem(entity: entity, previewOne: previewOne, previewTwo: previewTwo, targetJob: entity.tagretJob, targetCompany: entity.tagretCompany)
        }
        return nil
    }
    
    func openCv () {
        if let selectedCV {
            showEditor(cv: selectedCV)
        }
    }
    
    func duplicateCv () {
        if let selectedCV {
            Task {
                await performDuplicate(cv: selectedCV)
            }
        } else {
            showDefaultErrorDialog()
        }
    }
    
    @MainActor
    private func performDuplicate (cv: CVEntity) async {
        cvBuilder.duplicateCv(cv: cv)
        await updateList()
        selectedCV = nil
        AnalyticsManager.saveEvent(event: Events.CV_DUPLICTED)
    }
    
    func deleteCv () {
        if let selectedCV {
            Task {
                await performDelete(cv: selectedCV)
            }
        } else {
            showDefaultErrorDialog()
        }
    }
    
    @MainActor
    func performDelete (cv: CVEntity) async {
        cvBuilder.deleteCv(cv: cv)
        await updateList()
        selectedCV = nil
        AnalyticsManager.saveEvent(event: Events.CV_DELETED)
    }
    
    private func startOnBoardActions () {
        let visits = updateNumberOfVisits()
        AiManager.updateAttempts()
        if visits == 1 {
            showOnBoardSheet()
        } else {
            checkSheets()
        }
    }
    
    private func updateNumberOfVisits () -> Int {
        Defaults.KEY_VISITS += 1
        return Defaults.KEY_VISITS
    }
    
    private func checkSheets () {
        checkSocialPaywallWindows()
    }
    
    private func checkSocialPaywallWindows () {
        if Defaults.KEY_ACCOUNT_TYPE == 0 {
            showInitialPaywall = true
        }
    }
    
    func setPurchasesAvailable () {
        purchasesAvailable = true
    }
    
    @MainActor
    func showInitialPaywallIfAvailable () {
        print("Show")
        AppDelegate.ifNotificationsRequestNeeded(completionHandler: { ifNeeded in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                print("Show 1")
                if ifNeeded {
                    self.notificationsRequestShown = true
                } else {
                    if self.isVisible && !self.paywallSheetShown && !self.shareSheetShown && !self.actionsSheetShown && !self.constructorSheetShown && !self.editorPresented {
                        print("Show 2")
                        if self.showInitialPaywall && self.purchasesAvailable {
                            print("Show 3")
                            self.showPaywallSheet()
                        }
                    }
                }
            }
        })
    }
    
    func showConstructorSheet () {
        constructorSheetShown = true
    }
    
    func checkConstructorFinish (cv: CVEntity?) {
        updateAccount()
        if let cv {
            selectedCV = cv
            openCv()
        }
    }
    
    func showEditor (cv: CVEntity) {
        selectedCV = cv
        editorPresented = true
    }
    
    func checkEditorFinish () {
        selectedCV = nil
        getProfile()
        updateUserInfo()
    }
    
    func showShareSheet () {
        shareSheetShown = true
    }
    
    func checkShareFinish () {
        selectedCV = nil
    }
    
    func showPaywallSheet () {
        paywallSheetShown = true
    }
    
    func checkPaywallFinish () {
        updateAccount()
    }
    
    func showOnBoardSheet () {
        onboardSheetShown = true
    }
    
    func checkOnBoardFinish (cv: CVEntity?) {
        getProfile()
        updateUserInfo()
        if let cv {
            selectedCV = cv
            openCv()
        }
    }
    
    func showActionsSheet () {
        actionsSheetShown = true
        if actionsSheetShown {
            AnalyticsManager.saveEvent(event: Events.CV_ACTIONS)
        }
    }
    
    func showSideMenu () {
        sideMenuShown = !sideMenuShown
        if sideMenuShown {
            AnalyticsManager.saveEvent(event: Events.SIDE_MENU)
        }
    }
    
    private func showDefaultErrorDialog () {
        defaultErrorDialogShown = true
    }
}
