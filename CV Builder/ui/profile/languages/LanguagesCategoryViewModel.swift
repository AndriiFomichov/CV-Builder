//
//  LanguagesCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class LanguagesCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var languagesList: [LanguageItem] = []
    @Published var languageAddingSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateLanguagesList()
    }
    
    func updateLanguagesList () {
        var list: [LanguageItem] = []
        
        if let profile, let languagesList = profile.languagesList {
            for lang in languagesList {
                list.append(LanguageItem(entity: lang))
            }
        }
        
        languagesList = list.sorted(by: { $0.position < $1.position })
    }
    
    func deleteLanguage (index: Int) {
        if let profile, index != -1 {
            let lang = languagesList[index]
            profileManager.deleteLanguage(profile: profile, language: lang.entity)
            languagesList.remove(at: index)
        }
    }
    
    func handleItemsMoved () {
        if languagesList.count > 1 {
            for i in 0..<languagesList.count {
                let item = languagesList[i]
                item.position = i
                languagesList[i] = item
                
                item.entity.position = item.position
            }
            DatabaseBox.saveContext()
        }
    }
    
    func showLanguageAdding () {
        languageAddingSheetShown = true
    }
    
    func save () {
        for item in languagesList {
            profileManager.updateLanguage(language: item.entity, langId: item.langId, name: item.name, level: item.level, position: item.position)
        }
    }
}
