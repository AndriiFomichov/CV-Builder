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
    
    @Published var text = ""
    @Published var list: [Language] = []
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateLanguagesList()
    }
    
    private func updateLanguagesList () {
        list = PreloadedDatabase.getLanguages()
    }
    
    func selectLanguage (index: Int) {
        let lang = list[index]
        lang.isSelected.toggle()
        list[index] = lang
    }
    
    func save () {
        if let profile {
            if !text.isEmpty {
                let langs = text.components(separatedBy: ", ")
                if langs.count > 0 {
                    for lang in langs {
                        profileManager.saveLanguage(profile: profile, langId: -1, name: lang, level: -1)
                    }
                }
            }
            for lang in list {
                if lang.isSelected {
                    profileManager.saveLanguage(profile: profile, langId: lang.langId, name: lang.name, level: -1)
                }
            }
        }
        dismissed = true
    }
}
