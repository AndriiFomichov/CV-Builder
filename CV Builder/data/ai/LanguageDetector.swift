//
//  LanguageDetector.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation
import NaturalLanguage

class TextLangDetector {
    
    @MainActor
    static func detectLang (text: String) async -> Int {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        
        print("Lang processing started: " + text)
        
        if let language = recognizer.dominantLanguage {
            return await getLanguageKey(language: language)
        } else {
            return -1
        }
    }
    
    @MainActor
    private static func getLanguageKey (language: NLLanguage) async -> Int {
        switch language {
        case .indonesian:
            return 0
        case .catalan:
            return 1
        case .danish:
            return 2
        case .german:
            return 3
        case .english:
            return 4
        case .spanish:
            return 5
        case .french:
            return 6
        case .italian:
            return 7
        case .hungarian:
            return 8
        case .dutch:
            return 9
        case .norwegian:
            return 10
        case .polish:
            return 11
        case .portuguese:
            return 12
        case .romanian:
            return 13
//        case .serbian: ////
//            return 14 // -1
        case .finnish:
            return 15
//        case .slovenian: ////
//            return 16 // -1
        case .vietnamese:
            return 17
        case .turkish:
            return 18
        case .czech:
            return 19
        case .greek:
            return 20
        case .ukrainian:
            return 21
        case .hebrew:
            return 22
        case .hindi:
            return 23
        case .simplifiedChinese:
            return 24
        case .traditionalChinese:
            return 24
        case .japanese:
            return 25
        case .korean:
            return 26
        default:
            return -1
        }
    }
    
    static func getLanguageKeyFromSystem (language: Locale.LanguageCode) -> Int {
        switch language {
        case .indonesian:
            return 0
        case .catalan:
            return 1
        case .danish:
            return 2
        case .german:
            return 3
        case .english:
            return 4
        case .spanish:
            return 5
        case .french:
            return 6
        case .italian:
            return 7
        case .hungarian:
            return 8
        case .dutch:
            return 9
        case .norwegian:
            return 10
        case .polish:
            return 11
        case .portuguese:
            return 12
        case .romanian:
            return 13
//        case .serbian:
//            return 14
        case .finnish:
            return 15
//        case .slovenian:
//            return 16
        case .vietnamese:
            return 17
        case .turkish:
            return 18
        case .czech:
            return 19
        case .greek:
            return 20
        case .ukrainian:
            return 21
        case .hebrew:
            return 22
        case .hindi:
            return 23
        case .chinese:
            return 24
        case .japanese:
            return 25
        case .korean:
            return 26
        default:
            return -1
        }
    }
    
    static func getDefaultLanguage () -> Language {
        let list = PreloadedDatabase.getLanguages()
        let defaultLangCode = Locale.current.language.languageCode
        var languageId: Int
        
        if let defaultLangCode {
            languageId = TextLangDetector.getLanguageKeyFromSystem(language: defaultLangCode)
            if languageId == -1 {
                languageId = 4
            }
        } else {
            languageId = 4
        }
        
        return list[languageId]
    }
}
