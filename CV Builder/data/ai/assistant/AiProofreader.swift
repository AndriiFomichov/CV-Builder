//
//  AiProofreader.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiProofreader {
    
    func proofreadCv (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        let result0 = await checkGeneralBlock(cv: cv)
        mistakes.append(contentsOf: result0.mistakes)
        texts += result0.texts
        correct += result0.correct
        
        let result1 = await checkProfileDescBlock(cv: cv)
        mistakes.append(contentsOf: result1.mistakes)
        texts += result1.texts
        correct += result1.correct
        
        let result2 = await checkEducationBlock(cv: cv)
        mistakes.append(contentsOf: result2.mistakes)
        texts += result2.texts
        correct += result2.correct
        
        let result3 = await checkWorkBlock(cv: cv)
        mistakes.append(contentsOf: result3.mistakes)
        texts += result3.texts
        correct += result3.correct
        
        let result4 = await checkLanguageBlock(cv: cv)
        mistakes.append(contentsOf: result4.mistakes)
        texts += result4.texts
        correct += result4.correct
        
        let result5 = await checkSkillsBlock(cv: cv)
        mistakes.append(contentsOf: result5.mistakes)
        texts += result5.texts
        correct += result5.correct
        
        let result6 = await checkInterestsBlock(cv: cv)
        mistakes.append(contentsOf: result6.mistakes)
        texts += result6.texts
        correct += result6.correct
        
        let result7 = await checkCertificatesBlock(cv: cv)
        mistakes.append(contentsOf: result7.mistakes)
        texts += result7.texts
        correct += result7.correct
        
        let result8 = await checkReferencesBlock(cv: cv)
        mistakes.append(contentsOf: result8.mistakes)
        texts += result8.texts
        correct += result8.correct
        
        let result9 = await checkCoverLetter(cv: cv)
        mistakes.append(contentsOf: result9.mistakes)
        texts += result9.texts
        correct += result9.correct
        
        DatabaseBox.saveContext()
        
        return (mistakes, texts, correct)
    }
    
    private func checkGeneralBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let generalBlock = cv.generalBlock {
            generalBlock.jobTitle = await proofreadField(text: generalBlock.jobTitle, blockId: 0, blockName: NSLocalizedString("content_category_0", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkProfileDescBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        print("Profile desc start")
        
        if let profileDescBlock = cv.profileDescBlock {
            profileDescBlock.profileDescription = await proofreadField(text: profileDescBlock.profileDescription, blockId: 1, blockName: NSLocalizedString("content_category_1", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
//            profileDescBlock.textAboutMe = await proofreadField(text: profileDescBlock.textAboutMe, blockId: 1, blockName: NSLocalizedString("content_category_1", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkEducationBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let educationBlock = cv.educationBlock, let list = educationBlock.list {
            if list.count > 0 {
                for item in list {
                    item.desc = await proofreadField(text: item.desc, blockId: 2, blockName: NSLocalizedString("content_category_2", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.level = await proofreadField(text: item.level, blockId: 2, blockName: NSLocalizedString("content_category_2", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.institution = await proofreadField(text: item.institution, blockId: 2, blockName: NSLocalizedString("content_category_2", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.fieldOfStudy = await proofreadField(text: item.fieldOfStudy, blockId: 2, blockName: NSLocalizedString("content_category_2", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.degree = await proofreadField(text: item.degree, blockId: 2, blockName: NSLocalizedString("content_category_2", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.coursework = await proofreadField(text: item.coursework, blockId: 2, blockName: NSLocalizedString("content_category_2", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                }
            }
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkWorkBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let workBlock = cv.workBlock, let list = workBlock.list {
            if list.count > 0 {
                for item in list {
                    item.desc = await proofreadField(text: item.desc, blockId: 3, blockName: NSLocalizedString("content_category_3", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.jobTitle = await proofreadField(text: item.jobTitle, blockId: 3, blockName: NSLocalizedString("content_category_3", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.company = await proofreadField(text: item.company, blockId: 3, blockName: NSLocalizedString("content_category_3", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                    item.location = await proofreadField(text: item.location, blockId: 3, blockName: NSLocalizedString("content_category_3", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
//                    item.responsibilities = await proofreadField(text: item.responsibilities, blockId: 3, blockName: NSLocalizedString("content_category_3", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                }
            }
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkLanguageBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let languagesBlock = cv.languagesBlock, let list = languagesBlock.list {
            if list.count > 0 {
                for item in list {
                    item.name = await proofreadField(text: item.name, blockId: 4, blockName: NSLocalizedString("content_category_4", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                }
            }
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkSkillsBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let skillsBlock = cv.skillsBlock, let list = skillsBlock.list {
            if list.count > 0 {
                for item in list {
                    item.name = await proofreadField(text: item.name, blockId: 5, blockName: NSLocalizedString("content_category_5", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                }
            }
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkInterestsBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let interestsBlock = cv.interestsBlock, let list = interestsBlock.list {
            if list.count > 0 {
                for item in list {
                    item.name = await proofreadField(text: item.name, blockId: 6, blockName: NSLocalizedString("content_category_6", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                }
            }
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkCertificatesBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let certificatesBlock = cv.certificatesBlock, let list = certificatesBlock.list {
            if list.count > 0 {
                for item in list {
                    item.name = await proofreadField(text: item.name, blockId: 9, blockName: NSLocalizedString("content_category_9", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                }
            }
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkReferencesBlock (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let referencesBlock = cv.referencesBlock, let list = referencesBlock.list {
            if list.count > 0 {
                for item in list {
                    item.company = await proofreadField(text: item.company, blockId: 10, blockName: NSLocalizedString("content_category_10", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
                }
            }
        }
        
        return (mistakes, texts, correct)
    }
    
    private func checkCoverLetter (cv: CVEntity) async -> (mistakes: [Mistake], texts: Int, correct: Int) {
        var mistakes: [Mistake] = []
        var texts = 0
        var correct = 0
        
        if let coverLetter = cv.coverLetter {
            coverLetter.text = await proofreadField(text: coverLetter.text, blockId: -1, blockName: NSLocalizedString("cover_letter", comment: ""), texts: &texts, correct: &correct, mistakes: &mistakes)
        }
        
        return (mistakes, texts, correct)
    }
    
    private func proofreadField (text: String, blockId: Int, blockName: String, texts: inout Int, correct: inout Int, mistakes: inout [Mistake]) async -> String {
        var correntText = text
        if !text.isEmpty {
            let result = await proofreadText(text: text)
            texts+=1
            if result.isCorrect {
                correct+=1
            } else {
                mistakes.append(Mistake(blockId: blockId, blockName: blockName, textPrevious: text, textNew: result.correctText, textNewUpdateIndexs: result.indexes))
                correntText = result.correctText
            }
        }
        return correntText
    }
    
    private func proofreadText (text: String) async -> (isCorrect: Bool, indexes: [Int], correctText: String) {
        var indexes: [Int] = []
        var isCorrect = true
        var correntText = text
        
        let prompt = Prompts.createProofreadPrompt(text: text)
        let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
        if let responce, !responce.isEmpty, responce.count / text.count < 2 {
            if !AiProofreader.ifStringsEqual(prev: text, new: responce) {
                isCorrect = false
                indexes = AiProofreader.getDifferenceIndexes(incorrectString: text, correctString: responce)
                print("Indexes count = " + String(indexes.count))
                correntText = responce
            }
        }
        
        return (isCorrect, indexes, correntText)
    }
    
    private static func ifStringsEqual (prev: String, new: String) -> Bool {
        print("Strings:\n1) " + prev + "\n2) " + new + "\nisEqual = " + prev == new)
        return prev == new
    }
    
    private static func getDifferenceIndexes (incorrectString: String, correctString: String) -> [Int] {
        var indexes: [Int] = []
        
        let correctArray = Array(correctString)
        let incorrectArray = Array(incorrectString)
//        var correctMutableString = NSMutableAttributedString(string: correctString)

        let diff = correctArray.difference(from: incorrectArray)
        for update in diff {
            switch update {
                case .insert(let offset, let letter, let move):
                    if let move {
                        indexes.append(move)
                        print("Indexes appended = " + String(move))
                    } else {
                        indexes.append(offset)
                        print("Indexes appended = " + String(offset))
                    }
                default:
                    break
            }
        }
        
//        var currentPosition = 0
//        for char in incorrectArray {
//            guard let position = correctArray.index(of: char, greaterThan: currentPosition) else {
//                continue
//            }
//            while currentPosition < position {
////                correctMutableString.setCharacterColor(at: currentPosition)
//                indexes.append(currentPosition)
//                print("Indexes appended = " + String(currentPosition))
//                currentPosition = currentPosition + 1
//            }
//            currentPosition = position + 1
//        }
        
        return indexes
    }
}
