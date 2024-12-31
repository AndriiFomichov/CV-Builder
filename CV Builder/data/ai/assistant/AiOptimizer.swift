//
//  AiOptimizer.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiOptimizer {
    
    func optimizeCv (cv: CVEntity, profile: ProfileEntity, targetJob: String, targetCompany: String, targetJobDescription: String) async {
        
        let finalDescription = await AIAssistant.optimizeTargetJobDescription(targetJobDescription: targetJobDescription)
        let style = PreloadedDatabase.getStyleId(id: cv.style)
        let language = PreloadedDatabase.getLanguageById(id: cv.language)
        
        cv.targetJob = targetJob
        cv.targetCompany = targetCompany
        cv.targetJobDescription = finalDescription
        
        await optimizeProfileDescription(cv: cv, profile: profile, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: finalDescription, language: language)
        await optimizeEducation(cv: cv, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: finalDescription, language: language, style: style)
        await optimizeWork(cv: cv, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: finalDescription, language: language, style: style)
        await optimizeCoverLetter(cv: cv, profile: profile, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: finalDescription, language: language)
        
        DatabaseBox.saveContext()
    }
    
    private func optimizeProfileDescription (cv: CVEntity, profile: ProfileEntity, targetJob: String, targetCompany: String, targetJobDescription: String, language: Language) async {
        if let profileDescBlock = cv.profileDescBlock {
            if let newDesc = await AIAssistant.generateProfileDescription(currentJob: profile.jobTitle, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name) {
                profileDescBlock.profileDescription = newDesc
            }
//            profileDescBlock.profileDescription = await optimizeText(text: profileDescBlock.profileDescription, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: targetJobDescription)
        }
    }
    
    private func optimizeEducation (cv: CVEntity, targetJob: String, targetCompany: String, targetJobDescription: String, language: Language, style: Style) async {
        if let educationBlock = cv.educationBlock, let list = educationBlock.list {
            for item in list {
                if let newDesc = await AIAssistant.generateEducationDescription(item: item, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name, isBulletedList: style.educationDescritpionAsBulleted) {
                    item.desc = newDesc
                }
//                item.desc = await optimizeText(text: item.desc, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: targetJobDescription)
            }
        }
    }
    
    private func optimizeWork (cv: CVEntity, targetJob: String, targetCompany: String, targetJobDescription: String, language: Language, style: Style) async {
        if let workBlock = cv.workBlock, let list = workBlock.list {
            for item in list {
                if let newDesc = await AIAssistant.generateWorkDescription(item: item, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name, isBulletedList: style.workDescritpionAsBulleted) {
                    item.desc = newDesc
                }
//                item.desc = await optimizeText(text: item.desc, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: targetJobDescription)
            }
        }
    }
    
    private func optimizeCoverLetter (cv: CVEntity, profile: ProfileEntity, targetJob: String, targetCompany: String, targetJobDescription: String, language: Language) async {
        let _ = await AIAssistant.applyAiActionCoverLetter(profile: profile, cv: cv, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: targetJobDescription, language: language, action: 0, customAction: nil)
    }
    
//    private func optimizeText (text: String, targetJob: String, targetCompany: String, targetJobDescription: String) async -> String {
//        var finalText = text
//        if !text.isEmpty && (!targetJob.isEmpty || !targetCompany.isEmpty || !targetJobDescription.isEmpty) {
//            let prompt = Prompts.createOptimizePrompt(text: text, targetJob: targetJob, targetCompany: targetCompany, targetJobDescription: targetJobDescription)
//            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
//            if let responce, !responce.isEmpty {
//                finalText = responce
//            }
//        }
//        return finalText
//    }
}
