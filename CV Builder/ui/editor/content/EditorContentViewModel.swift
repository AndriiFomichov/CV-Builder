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
    
    var customAction = CustomActionInfo()
    
    var cv: CVEntity?
    
    @Published var mainList: [ContentBlock] = []
    @Published var additionalList: [ContentBlock] = []
    @Published var hasAdditionalBlock = false
    
    @Published var attemptsText = ""
    
    @Published var additionalTextsSheetShown = false
    @Published var aiCommandSheetShown = false
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
    func handleBlockItemAiActionClick (index: Int, action: Int, isMain: Bool) {
        if checkIsAiActionsAvailable() {
            
            var list: [ContentBlock]
            if isMain {
                list = mainList
            } else {
                list = additionalList
            }
            
            if index >= 0 && index < list.count {
                let block = list[index]
                
                if action == 4 {
                    customAction = CustomActionInfo(text: block.text, block: block, action: action, index: index, isMain: isMain)
                    openAiActionSheet()
                } else {
                    applyBlockAiActionClick(block: block, index: index, action: action, customAction: nil, isMain: isMain)
                }
            }
        }
    }
    
    @MainActor
    private func applyBlockAiActionClick (block: ContentBlock, index: Int, action: Int, customAction: String?, isMain: Bool) {
        if let cv, let profileDescBlock = cv.profileDescBlock, let generalBlock = cv.generalBlock, block.blockId == 1, !block.isLoading {
            block.isLoading = true
            if isMain {
                mainList[index] = block
            } else {
                additionalList[index] = block
            }
            generateTextForItem(cv: cv, contentBlock: block, blockGeneral: generalBlock, block: profileDescBlock, action: action, customAction: customAction)
        }
    }
    
    @MainActor
    private func generateTextForItem (cv: CVEntity, contentBlock: ContentBlock, blockGeneral: GeneralInfoBlockEntity, block: ProfileDescriptionBlockEntity, action: Int, customAction: String?) {
        Task {
            if let newText = await AIAssistant.applyTextAiAction(currentJob: blockGeneral.jobTitle, workItem: nil, educationItem: nil, targetJob: cv.targetJob, targetCompany: cv.targetCompany, targetJobDescription: cv.targetJobDescription, action: action, customAction: customAction, text: contentBlock.text, isBulletedList: false, langId: cv.language) {
                contentBlock.text = newText
                block.profileDescription = contentBlock.text
                updateAttempts()
                updatePreview()
            }
            
            contentBlock.isLoading = false
        }
    }
    
    @MainActor
    func handleBlockInnerItemAiActionClick (itemIndex: Int, index: Int, action: Int, isMain: Bool) {
        if checkIsAiActionsAvailable() {
            
            var list: [ContentBlock]
            if isMain {
                list = mainList
            } else {
                list = additionalList
            }
            
            if itemIndex >= 0 && itemIndex < list.count {
                let block = list[itemIndex]
                let item = block.items[index]
                
                if action == 4 {
                    customAction = CustomActionInfo(text: item.text, block: block, item: item, action: action, index: index, itemIndex: itemIndex, isMain: isMain)
                    openAiActionSheet()
                } else {
                    applyInnerItemAiActionClick(block: block, item: item, itemIndex: itemIndex, index: index, action: action, customAction: nil, isMain: isMain)
                }
            }
        }
    }
    
    @MainActor
    private func applyInnerItemAiActionClick (block: ContentBlock, item: ContentItem, itemIndex: Int, index: Int, action: Int, customAction: String?, isMain: Bool) {
        if !item.isLoading {
            item.isLoading = true
            block.items[index] = item
            
            if isMain {
                mainList[itemIndex] = block
            } else {
                additionalList[itemIndex] = block
            }
            
            updateAdditionalItem(index: index, block: block, item: item, contentIndex: index, action: action, customAction: customAction)
        }
    }
    
    @MainActor
    private func updateAdditionalItem (index: Int, block: ContentBlock, item: ContentItem, contentIndex: Int, action: Int, customAction: String?) {
        if let cv {
            if block.blockId == 2 {
                
                var entity: EducationBlockItemEntity?
                var bulleted = false
                if let block = cv.educationBlock, let list = block.list {
                    for i in list {
                        if item.enitityId == i.id {
                            entity = i
                        }
                    }
                    bulleted = block.styleDescritpionAsBulleted
                }
                
                generateTextForItemItem(block: block, item: item, contentIndex: index, workItem: nil, educationItem: entity, targetJob: cv.targetJob, targetCompany: cv.targetCompany, targetJobDescription: cv.targetJobDescription, action: action, customAction: customAction, text: item.text, isBulletedList: bulleted, langId: cv.language)
                
            } else if block.blockId == 3 {
                
                var entity: WorkBlockItemEntity?
                var bulleted = false
                if let block = cv.workBlock, let list = block.list {
                    for i in list {
                        if item.enitityId == i.id {
                            entity = i
                        }
                    }
                    bulleted = block.styleDescritpionAsBulleted
                }
                
                generateTextForItemItem(block: block, item: item, contentIndex: index, workItem: entity, educationItem: nil, targetJob: cv.targetJob, targetCompany: cv.targetCompany, targetJobDescription: cv.targetJobDescription, action: action, customAction: customAction, text: item.text, isBulletedList: bulleted, langId: cv.language)
            }
        }
    }
    
    @MainActor
    private func generateTextForItemItem (block: ContentBlock, item: ContentItem, contentIndex: Int, workItem: WorkBlockItemEntity?, educationItem: EducationBlockItemEntity?, targetJob: String, targetCompany: String, targetJobDescription: String, action: Int, customAction: String?, text: String, isBulletedList: Bool, langId: Int) {
        Task {
            if let newText = await AIAssistant.applyTextAiAction(currentJob: nil, workItem: workItem, educationItem: educationItem, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: targetJobDescription, action: action, customAction: customAction, text: text, isBulletedList: isBulletedList, langId: langId) {
                item.text = newText
                updateAttempts()
                updatePreview()
            }
            
            item.isLoading = false
            block.items[contentIndex] = item
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
    
    func openAiActionSheet () {
        aiCommandSheetShown = true
    }
    
    @MainActor
    func handleAiCommandApplied (command: String) {
        if !command.isEmpty, let block = customAction.block {
            if let item = customAction.item {
                applyInnerItemAiActionClick(block: block, item: item, itemIndex: customAction.itemIndex, index: customAction.index, action: customAction.action, customAction: command, isMain: customAction.isMain)
            } else {
                applyBlockAiActionClick(block: block, index: customAction.index, action: customAction.action, customAction: command, isMain: customAction.isMain)
            }
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
    
    func openAdditionalTextsSelection () {
        additionalTextsSheetShown = true
    }
    
    func handleAdditionalTexts (isChanged: Bool) {
        if isChanged {
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
