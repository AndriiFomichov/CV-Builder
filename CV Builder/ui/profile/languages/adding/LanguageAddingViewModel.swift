//
//  LanguageAddingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class LanguageAddingViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    
    var profile: ProfileEntity?
    
    var selectedLangLevel = -1
    
    @Published var text = ""
    @Published var levelName = ""
    
    @Published var languageOptions: [MenuItem] = []
    @Published var levelOptions: [MenuItem] = []
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateLanguagesList()
        updateLevelsList()
    }
    
    private func updateLanguagesList () {
        var list: [MenuItem] = []
        let langs = PreloadedDatabase.getLanguages()
        for lang in langs {
            list.append(MenuItem(id: lang.langId, name: lang.name))
        }
        languageOptions = list
    }
    
    private func updateLevelsList () {
        levelOptions = PreloadedDatabase.getLanguageLevelsOptions()
    }
    
    func selectLevel (item: MenuItem) {
        selectedLangLevel = item.id
        levelName = item.name
    }
    
    func save () {
        if let profile {
            if !text.isEmpty {
                var langId = -1
                
                for lang in languageOptions {
                    if lang.name == text {
                        langId = lang.id
                    }
                    
                }
                
                profileManager.saveLanguage(profile: profile, langId: langId, name: text, level: selectedLangLevel)
            }
        }
        dismissed = true
    }
}
