//
//  FontSelectionViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 03.12.2024.
//

import Foundation

class FontSelectionViewModel: ObservableObject {
    
    @Published var fontsList: [[Font]] = []
    @Published var isLoading = false
    
    var selectedFont = -1
    
    func updateData (initialFont: Int) {
        selectedFont = initialFont
        Task {
            await updateFontsList()
        }
    }
    
    @MainActor
    private func updateFontsList () async {
        isLoading = true
        
        var list: [[Font]] = []
        for i in 0..<5 {
            let category = PreloadedDatabase.getFontsByCategory(category: i)
            let pos = getFontPosition(id: selectedFont, list: category)
            if pos != -1 {
                category[pos].isSelected = true
            }
            list.append(category)
        }
        
        fontsList = list
        isLoading = false
    }
    
    func handleFontClick (category: Int, index: Int) {
        let font = fontsList[category][index]
        if !font.isSelected {
            selectItem(font: font)
        }
    }
    
    func selectItem (font: Font) {
        for i in 0..<fontsList.count {
            updateListItem(font: font, list: &fontsList[i])
        }
    }
    
    private func updateListItem (font: Font, list: inout [Font]) {
        let selectedFont = getSelectedFont(list: list)
        let newFontPosition = getFontPosition(id: Int(font.id), list: list)
        
        if newFontPosition != -1 {
 
            if let selectedFont = selectedFont {
                if selectedFont.id != font.id {
                    let selectedFontPosition = getFontPosition(id: Int(selectedFont.id), list: list)
                    updateItem(font: selectedFont, isSelected: false, save: false, list: &list, index: selectedFontPosition)
                    updateItem(font: font, isSelected: true, save: true, list: &list, index: newFontPosition)
                }
            } else {
                updateItem(font: font, isSelected: true, save: true, list: &list, index: newFontPosition)
            }
            
        } else {
            
            if let selectedFont = selectedFont {
                let selectedFontPosition = getFontPosition(id: Int(selectedFont.id), list: list)
                updateItem(font: selectedFont, isSelected: false, save: false, list: &list, index: selectedFontPosition)
            }
        }
    }
    
    private func updateItem (font: Font, isSelected: Bool, save: Bool, list: inout [Font], index: Int) {
        font.isSelected = isSelected
        if isSelected && save {
            selectedFont = font.id
        }
    }
    
    private func getSelectedFont (list: [Font]) -> Font? {
        for i in 0..<list.count {
            let item = list[i]
            if item.isSelected {
                return item
            }
        }
        return nil
    }
    
    private func getFontPosition (id: Int, list: [Font]) -> Int {
        for i in 0..<list.count {
            let item = list[i]
            if item.id == id {
                return i
            }
        }
        return -1
    }
}
