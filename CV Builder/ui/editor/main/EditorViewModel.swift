//
//  EditorViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class EditorViewModel: ObservableObject {
    
    let cvBuilder = CVBuilder()
    let cvUpdater = CVUpdater()
    let profileManager = ProfileManager()
    let exportManager = ExportManager()
    
    var profile: ProfileEntity?
    var cv: CVEntity?
    
    var customAction = CustomActionInfo()
    
    @Published var wrapper: CVEntityWrapper?
    
    @Published var page = 0
    @Published var state = 0
    
    @Published var header = ""
    @Published var userName = ""
    @Published var userDescription = ""
    @Published var userPhoto: UIImage?
    @Published var btnProfileVisible = true
    @Published var btnAiAssistantVisible = true
    
    @Published var isLoading = false
    @Published var isCoverLetterGenerating = false
    @Published var isCoverLetterAiActionAvailable = false
    @Published var coverAlertShown = false
    
    var changesList: [CVChange] = []
    
    @Published var bottomActionsList: [EditorAction] = []
    
    @Published var aiCommandSheetShown = false
    @Published var changesSheetShown = false
    @Published var profileSheetShown = false
    @Published var paywallSheetShown = false
    @Published var shareSheetShown = false
    @Published var previewSheetShown = false
    @Published var limitSheetShown = false
    @Published var connectionSheetShown = false
    
    var previewPage = 0
    var previewIsCv = true
    
    @Published var defaultErrorDialogShown = false
    
    func updateData (cv: CVEntity?) {
        self.cv = cv
        self.profile = profileManager.getProfile()
        
        updateHeader()
        updateState(state: 0)
        
        updatePreview()
        
        updateUserProfile()
        checkIfProfileChanged()
        
        Task {
            await saveCvPreview()
        }
    }
    
    private func checkIfProfileChanged () {
        if let cv, let profile {
            let result = cvUpdater.getProfileUpdatedChanges(cv: cv, profile: profile)
            if result.isChanged {
                changesList = result.changes
                changesSheetShown = true
            }
        }
    }
    
    func handleProfileChangesSheet (apply: Bool) {
        if apply {
            updateState(state: 0)
            Task {
                await updateCvFromProfile()
            }
        }
    }
    
    @MainActor
    private func updateCvFromProfile () async {
        isLoading = true
        
        if let cv, let profile {
            await cvUpdater.updateCv(cv: cv, profile: profile, changes: changesList)
        }
        
        updatePreview()
        
        isLoading = false
    }
    
    private func updateUserProfile () {
        if let profile {
            let fill = profileManager.getProfileFillPercent(profile: profile)
            
            userName = profile.name
            if fill == 1.0 {
                userDescription = NSLocalizedString("your_profile", comment: "")
            } else {
                userDescription = NSLocalizedString("actions_required", comment: "")
            }
            
            Task {
                await loadImage()
            }
        }
    }
    
    @MainActor
    private func loadImage () async {
        if let profile, profile.photoId != -1, let image = DatabaseBox.getImage(id: profile.photoId), let data = image.image, let uiImage = UIImage(data: data) {
            userPhoto = await uiImage.resizeAsync(height: 150)
        }
    }
    
    func openProfile () {
        profileSheetShown = true
    }
    
    func handleProfileUpdated () {
        updateUserProfile()
        checkIfProfileChanged()
    }
    
    func updateHeader () {
        if let cv {
            if page == 1 {
                header = NSLocalizedString("cover_letter", comment: "")
            } else {
                if cv.name.isEmpty {
                    header = NSLocalizedString("resume", comment: "")
                } else {
                    header = cv.name
                }
            }
        }
    }
    
    func updatePreview () {
        if let cv {
            self.wrapper = CVEntityWrapper(entity: cv)
            if let coverLetter = cv.coverLetter {
                isCoverLetterAiActionAvailable = !coverLetter.text.isEmpty
            }
        }
    }
    
    func savePagesUpdated () {
        if let cv, let wrapper {
            self.cv = cvBuilder.saveWrapperPagesToEntity(wrapper: wrapper, cv: cv)
        }
        updateCvPreview()
    }
    
    private func updateCvPreview () {
        self.wrapper = self.wrapper
    }

    @MainActor
    func applyCoverLetterAiAction (action: Int) {
        if Reachability.isConnectedToNetwork() {
            if let cv, !isCoverLetterGenerating {
                if action == 4 {
                    if let coverLetter = cv.coverLetter, !coverLetter.text.isEmpty {
                        customAction = CustomActionInfo(text: coverLetter.text, action: action, index: -1, itemIndex: -1, isMain: false)
                        openAiActionSheet()
                    }
                } else {
                    applyAiAction(action: action, customAction: nil)
                }
            }
        } else {
            connectionSheetShown = true
        }
    }
    
    @MainActor
    private func applyAiAction (action: Int, customAction: String? = nil) {
        if let cv, let profile {
            Task {
                isLoading = true
                isCoverLetterGenerating = true
                
                let language = PreloadedDatabase.getLanguageById(id: cv.language)
                
                let noData = await AIAssistant.applyAiActionCoverLetter(profile: profile, cv: cv, targetJob: cv.targetJob, targetCompany: cv.targetCompany, targetJobDescription: cv.targetJobDescription, language: language, action: action, customAction: customAction)
                if noData {
                    coverAlertShown = true
                } else {
                    updatePreview()
                    updateState(state: 0)
                }
                
                isCoverLetterGenerating = false
                isLoading = false
            }
        }
    }
    
    private func checkIsAiActionsAvailable () -> Bool {
        if let cv {
            if AiManager.getAiTextAttempts() > 0 || cv.coverLetter == nil {
                return true
            } else {
                let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
                if isUserPremium {
                    showLimitsSheet()
                    AnalyticsManager.saveEvent(event: Events.AI_TEXT_LIMIT)
                } else {
                    showPaywallSheet()
                }
            }
        }
        return false
    }
    
    func openAiActionSheet () {
        aiCommandSheetShown = true
    }
    
    @MainActor
    func handleAiCommandApplied (command: String) {
        if !command.isEmpty {
            applyAiAction(action: 4, customAction: command)
        }
    }
    
    func handleCoverLetterTextChanged (text: String) {
        if let cv, let coverLetter = cv.coverLetter {
            coverLetter.text = text
            DatabaseBox.saveContext()
            isCoverLetterAiActionAvailable = !text.isEmpty
        }
    }
    
    func showZoomablePreview (page: Int, isCv: Bool) {
        previewPage = page
        previewIsCv = isCv
        previewSheetShown = true
    }
    
    func updateState (state: Int) {
        switch state {
        case 0:
            defaultState()
            break
        case 1:
            aiAssistantState()
            break
        case 2:
            contentState()
            break
        case 3:
            designState()
            break
        default:
            defaultState()
            break
        }
    }
    
    // ------------------------------------------------> Default state
    private func defaultState () {
        btnProfileVisible = true
        
        if let cv {
            btnAiAssistantVisible = page == 0 || cv.coverLetter != nil
        } else {
            btnAiAssistantVisible = false
        }
       
        setBottomActionsList()
        self.state = 0
    }
    
    private func setBottomActionsList () {
        var list: [EditorAction] = []
        
        if let cv {
            if page == 0 || page == 1 && cv.coverLetter != nil {
                list.append(EditorAction(id: 0, name: NSLocalizedString("ai_assistant", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: { self.updateState(state: 1) }))
            }
            if page == 0 {
                list.append(EditorAction(id: 1, name: NSLocalizedString("content", comment: ""), icon: "list.bullet", isIconSystem: true, clickHandler: { self.updateState(state: 2) }))
            }
            if page == 0 || page == 1 && cv.coverLetter != nil {
                list.append(EditorAction(id: 2, name: NSLocalizedString("design", comment: ""), icon: "paintpalette.fill", isIconSystem: true, clickHandler: { self.updateState(state: 3) }))
            }
            if page == 0 {
                list.append(EditorAction(id: 3, name: NSLocalizedString("letter", comment: ""), icon: "text.document.fill", isIconSystem: true, clickHandler: { self.showPage(page: 1) }))
            }
        }
        
        bottomActionsList = list
    }
    
    private func aiAssistantState () {
        btnProfileVisible = false
        btnAiAssistantVisible = false
        self.state = 1
    }
    
    private func contentState () {
        btnProfileVisible = false
        btnAiAssistantVisible = false
        self.state = 2
    }
    
    private func designState () {
        btnProfileVisible = false
        btnAiAssistantVisible = false
        self.state = 3
    }
    
    func handlePageChanged () {
        updateHeader()
        updateState(state: 0)
    }
    
    func showPage (page: Int) {
        self.page = page
    }
    
    func share () {
        shareSheetShown = true
    }
    
    func checkShareFinish () {}
    
    func showPaywallSheet () {
        paywallSheetShown = true
    }
    
    func checkPaywallFinish () {}
    
    func showLimitsSheet () {
        limitSheetShown = true
    }
    
    func updateLastModified () {
        if let cv {
            cv.lastModified = Date()
            DatabaseBox.saveContext()
        }
    }
    
    @MainActor
    private func saveCvPreview () async {
        if let cv, let wrapper {
            if let preview = await exportManager.convertPageToExportUIImage(cv: wrapper, page: 0, size: -1, addBadgeMadeWith: false) {
                cv.previewOne = preview.pngData()
                DatabaseBox.saveContext()
            }
        }
    }
}
