//
//  EditorContentSelectionViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import Foundation

class EditorContentSelectionViewModel: ObservableObject {
    
    let contentManager = CVContentManager()
    
    var cv: CVEntity?
    
    @Published var generalItem: ContentBlock?
    @Published var mainList: [ContentBlock] = []
    @Published var additionalList: [ContentBlock] = []
    @Published var hasAdditionalBlock = false
    
    @Published var dismissed = false
    
    var isChanged = false
    
    func updateData (cv: CVEntity?) {
        self.cv = cv
        updateLists()
    }
    
    private func updateLists () {
        if let cv {
            generalItem = contentManager.getGeneralDataContent(cv: cv)
            mainList = contentManager.getContentList(cv: cv, isMainBlock: true, appendInnerItems: true)
            additionalList = contentManager.getContentList(cv: cv, isMainBlock: false, appendInnerItems: true)
            hasAdditionalBlock = cv.hasAdditionalBlock
        }
    }
    
    func handleMainItemClick (index: Int) {
        contentManager.handleItemClick(index: index, list: &mainList, cv: cv)
        isChanged = true
    }
    
    func handleAdditionalItemClick (index: Int) {
        contentManager.handleItemClick(index: index, list: &additionalList, cv: cv)
        isChanged = true
    }
    
    func handleItemsMoved () {
        contentManager.handleItemsMoved(mainList: &mainList, additionalList: &additionalList, cv: cv)
        isChanged = true
    }
    
    func save () {
        if let generalItem {
            contentManager.updateBlock(cv: cv, blockId: generalItem.blockId, position: generalItem.position, isMainBlock: generalItem.isMainBlock, isAdded: generalItem.isAdded)
        }
        for item in mainList {
            contentManager.updateBlock(cv: cv, blockId: item.blockId, position: item.position, isMainBlock: item.isMainBlock, isAdded: item.isAdded)
        }
        for item in additionalList {
            contentManager.updateBlock(cv: cv, blockId: item.blockId, position: item.position, isMainBlock: item.isMainBlock, isAdded: item.isAdded)
        }
        DatabaseBox.saveContext()
        dismissed = true
    }
}
