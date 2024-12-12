//
//  AiOptimizer.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiOptimizer {
    
    func optimizeCv (cv: CVEntity, targetJob: String, targetCompany: String) async {
        
        await optimizeProfileDescription(cv: cv, targetJob: targetJob, targetCompany: targetCompany)
        await optimizeEducation(cv: cv, targetJob: targetJob, targetCompany: targetCompany)
        await optimizeWork(cv: cv, targetJob: targetJob, targetCompany: targetCompany)
        await optimizeCoverLetter(cv: cv, targetJob: targetJob, targetCompany: targetCompany)
        
        DatabaseBox.saveContext()
    }
    
    private func optimizeProfileDescription (cv: CVEntity, targetJob: String, targetCompany: String) async {
        if let profileDescBlock = cv.profileDescBlock {
            profileDescBlock.profileDescription = await optimizeText(text: profileDescBlock.profileDescription, targetJob: targetJob, targetCompany: targetCompany)
        }
    }
    
    private func optimizeEducation (cv: CVEntity, targetJob: String, targetCompany: String) async {
        if let educationBlock = cv.educationBlock, let list = educationBlock.list {
            for item in list {
                item.desc = await optimizeText(text: item.desc, targetJob: targetJob, targetCompany: targetCompany)
            }
        }
    }
    
    private func optimizeWork (cv: CVEntity, targetJob: String, targetCompany: String) async {
        if let workBlock = cv.workBlock, let list = workBlock.list {
            for item in list {
                item.desc = await optimizeText(text: item.desc, targetJob: targetJob, targetCompany: targetCompany)
            }
        }
    }
    
    private func optimizeCoverLetter (cv: CVEntity, targetJob: String, targetCompany: String) async {
        if let coverLetter = cv.coverLetter {
            coverLetter.text = await optimizeText(text: coverLetter.text, targetJob: targetJob, targetCompany: targetCompany)
        }
    }
    
    private func optimizeText (text: String, targetJob: String, targetCompany: String) async -> String {
        var finalText = text
        if !text.isEmpty && (!targetJob.isEmpty || !targetCompany.isEmpty) {
            let prompt = Prompts.createOptimizePrompt(text: text, targetJob: targetJob, targetCompany: targetCompany)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                finalText = responce
            }
        }
        return finalText
    }
}
