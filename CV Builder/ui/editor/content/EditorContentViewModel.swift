//
//  EditorContentViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import Foundation
import SwiftyUserDefaults

class EditorContentViewModel: ObservableObject {
    
    let contentManager = CVContentManager()
    
    var cv: CVEntity?
    
    @Published var mainList: [ContentBlock] = []
    @Published var additionalList: [ContentBlock] = []
    @Published var hasAdditionalBlock = false
    
    @Published var attemptsText = ""
    
    @Published var contentSheetShown = false
    @Published var paywallSheetShown = false
    @Published var limitSheetShown = false
    
    var parentViewModel: EditorViewModel?
    
    func updateData (parentViewModel: EditorViewModel) {
        self.parentViewModel = parentViewModel
        self.cv = parentViewModel.cv
        updateLists()
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
    
    private func updateLists () {
        if let cv {
            mainList = contentManager.getContentList(cv: cv, isMainBlock: true, appendInnerItems: true)
            additionalList = contentManager.getContentList(cv: cv, isMainBlock: false, appendInnerItems: true)
            hasAdditionalBlock = cv.hasAdditionalBlock
        }
    }
    
    func handleMainItemClick (index: Int) {
        contentManager.handleItemClick(index: index, list: &mainList, cv: cv)
        updatePreview()
    }
    
    func handleAdditionalItemClick (index: Int) {
        contentManager.handleItemClick(index: index, list: &additionalList, cv: cv)
        updatePreview()
    }
    
    func handleItemTextChanged (item: ContentBlock) {
        if let cv, let profileDescBlock = cv.profileDescBlock, item.blockId == 1 {
            profileDescBlock.profileDescription = item.text
            updatePreview()
        }
    }
    
    @MainActor
    func handleMainItemAiActionClick (index: Int, action: Int) {
        if checkIsAiActionsAvailable() && index >= 0 && index < mainList.count {
            let content = mainList[index]
            
            if let cv, let profileDescBlock = cv.profileDescBlock, let generalBlock = cv.generalBlock, content.blockId == 1, !content.isLoading {
                content.isLoading = true
                mainList[index] = content
                
                generateTextForItem(cv: cv, content: content, blockGeneral: generalBlock, block: profileDescBlock, action: action)
            }
        }
    }
    
    @MainActor
    func handleAdditionalItemAiActionClick (index: Int, action: Int) {
        if checkIsAiActionsAvailable() && index >= 0 && index < additionalList.count {
            let content = additionalList[index]
            
            if let cv, let profileDescBlock = cv.profileDescBlock, let generalBlock = cv.generalBlock, content.blockId == 1, !content.isLoading {
                content.isLoading = true
                additionalList[index] = content
                
                generateTextForItem(cv: cv, content: content, blockGeneral: generalBlock, block: profileDescBlock, action: action)
            }
        }
    }
    
    @MainActor
    private func generateTextForItem (cv: CVEntity, content: ContentBlock, blockGeneral: GeneralInfoBlockEntity, block: ProfileDescriptionBlockEntity, action: Int) {
        Task {
            if let newText = await contentManager.updateTextWithAi(currentJob: blockGeneral.jobTitle, workItem: nil, educationItem: nil, targetJob: cv.tagretJob, targetCompany: cv.tagretCompany, action: action, text: content.text, isBulletedList: false) {
                content.text = newText
                block.profileDescription = content.text
                
//                        AiManager.useAiTextAttempt()
                updateAttempts()
                
                updatePreview()
            }
            
            content.isLoading = false
        }
    }
    
    @MainActor
    func handleMainItemItemAiActionClick (itemIndex: Int, index: Int, action: Int) {
        if checkIsAiActionsAvailable() && itemIndex >= 0 && itemIndex < mainList.count {
            if let cv {
                let item = mainList[itemIndex]
                
                let content = item.items[index]
                
                if !content.isLoading {
                    content.isLoading = true
                    item.items[index] = content
                    mainList[itemIndex] = item
                    
                    updateAdditionalItem(index: index, item: item, content: content, contentIndex: index, targetJob: cv.tagretJob, targetCompany: cv.tagretCompany, action: action, text: content.text)
                }
            }
        }
    }
    
    @MainActor
    func handleAdditionalItemItemAiActionClick (itemIndex: Int, index: Int, action: Int) {
        if checkIsAiActionsAvailable() && itemIndex >= 0 && itemIndex < additionalList.count {
            if let cv {
                let item = additionalList[itemIndex]
                
                let content = item.items[index]
                
                if !content.isLoading {
                    content.isLoading = true
                    item.items[index] = content
                    additionalList[itemIndex] = item
                    
                    updateAdditionalItem(index: index, item: item, content: content, contentIndex: index, targetJob: cv.tagretJob, targetCompany: cv.tagretCompany, action: action, text: content.text)
                }
            }
        }
    }
    
    @MainActor
    private func updateAdditionalItem (index: Int, item: ContentBlock, content: ContentItem, contentIndex: Int, targetJob: String, targetCompany: String, action: Int, text: String) {
        if let cv {
            if item.blockId == 2 {
                
                var entity: EducationBlockItemEntity?
                var bulleted = false
                if let block = cv.educationBlock, let list = block.list {
                    for i in list {
                        if content.enitityId == i.id {
                            entity = i
                        }
                    }
                    bulleted = block.styleDescritpionAsBulleted
                }
                
                generateTextForItemItem(item: item, content: content, contentIndex: index, workItem: nil, educationItem: entity, targetJob: cv.tagretJob, targetCompany: cv.tagretCompany, action: action, text: content.text, isBulletedList: bulleted)
                
            } else if item.blockId == 3 {
                
                var entity: WorkBlockItemEntity?
                var bulleted = false
                if let block = cv.workBlock, let list = block.list {
                    for i in list {
                        if content.enitityId == i.id {
                            entity = i
                        }
                    }
                    bulleted = block.styleDescritpionAsBulleted
                }
                
                generateTextForItemItem(item: item, content: content, contentIndex: index, workItem: entity, educationItem: nil, targetJob: cv.tagretJob, targetCompany: cv.tagretCompany, action: action, text: content.text, isBulletedList: bulleted)
            }
        }
    }
    
    @MainActor
    private func generateTextForItemItem (item: ContentBlock, content: ContentItem, contentIndex: Int, workItem: WorkBlockItemEntity?, educationItem: EducationBlockItemEntity?, targetJob: String, targetCompany: String, action: Int, text: String, isBulletedList: Bool) {
        Task {
            if let newText = await contentManager.updateTextWithAi(currentJob: nil, workItem: workItem, educationItem: educationItem, targetJob: targetJob, targetCompany: targetCompany, action: action, text: text, isBulletedList: isBulletedList) {
                content.text = newText
                
//                        AiManager.useAiTextAttempt()
                updateAttempts()
                                           
                updatePreview()
            }
            
            content.isLoading = false
            item.items[contentIndex] = content
        }
    }
    
    private func checkIsAiActionsAvailable () -> Bool {
        if AiManager.getAiTextAttempts() > 0 {
            return true
        } else {
            let isUserPremium = Defaults.KEY_ACCOUNT_TYPE != 0
            if isUserPremium {
                showLimitsSheet()
                AnalyticsManager.saveEvent(event: Events.AI_TEXT_LIMIT)
            } else {
                showPaywallSheet()
            }
            return false
        }
    }
    
    func handleItemsMoved () {
        contentManager.handleItemsMoved(mainList: &mainList, additionalList: &additionalList, cv: cv)
        updatePreview()
    }
    
    func updateAdditionalItems (item: ContentBlock) {
        contentManager.updateBlockItems(cv: cv, item: item)
        updatePreview()
    }
    
    func openContentSelection () {
        contentSheetShown = true
    }
    
    func handleContentSelection (isChanged: Bool) {
        if isChanged {
            updateLists()
            updatePreview()
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
    
    private func updatePreview () {
        DatabaseBox.saveContext()
        if let parentViewModel {
            parentViewModel.updatePreview()
        }
    }
    
    func back() {
        if let parentViewModel {
            parentViewModel.updateState(state: 0)
        }
    }
}
