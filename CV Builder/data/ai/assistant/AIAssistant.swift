//
//  AIAssistant.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation

class AIAssistant {
    
    static func generateCoverLetter (profile: ProfileEntity, targetJob: String, targetInstitution: String, language: String) async -> String {
        if !profile.jobTitle.isEmpty || !targetJob.isEmpty || !targetInstitution.isEmpty {
            let prompt = Prompts.createCoverLetterGenerationPrompt(profile: profile, targetJob: targetJob, targetCompany: targetInstitution, language: language)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return responce
            }
        }
        return ""
    }
    
    // TEXT GENERATION
    
    static func generateUserSkills (jobTitle: String, targetJob: String, targetInstitution: String, language: String) async -> [String] {
        if !jobTitle.isEmpty || !targetJob.isEmpty || !targetInstitution.isEmpty {
            let prompt = Prompts.createSkillsGenerationPrompt(currentJob: jobTitle, targetJob: targetJob, targetCompany: targetInstitution, language: language)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 700, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return responce.components(separatedBy: ", ")
            }
        }
        return []
    }
    
    static func generateProfileDescription (currentJob: String, targetJob: String, targetInstitution: String, language: String) async -> String? {
        if !currentJob.isEmpty || !targetJob.isEmpty || !targetInstitution.isEmpty {
            let prompt = Prompts.createProfileDescriptionPrompt(currentJob: currentJob, targetJob: targetJob, targetCompany: targetInstitution, language: language)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return responce
            }
        }
        return nil
    }
    
    static func generateEducationDescription (item: EducationBlockItemEntity, targetJob: String, targetInstitution: String, language: String, isBulletedList: Bool) async -> String? {
        if !item.degree.isEmpty || !item.level.isEmpty || !item.institution.isEmpty || !targetJob.isEmpty || !targetInstitution.isEmpty {
            let prompt = Prompts.createEducationDescriptionPrompt(degree: item.degree, level: item.level, institution: item.institution, targetJob: targetJob, targetCompany: targetInstitution, language: language, isBulletedList: isBulletedList)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return responce
            }
        }
        return nil
    }
    
    static func generateWorkDescription (item: WorkBlockItemEntity, targetJob: String, targetInstitution: String, language: String, isBulletedList: Bool) async -> String? {
        if !item.jobTitle.isEmpty || !item.company.isEmpty || !targetJob.isEmpty || !targetInstitution.isEmpty {
            let prompt = Prompts.createWorkDescriptionPrompt(jobTitle: item.jobTitle, company: item.company, targetJob: targetJob, targetCompany: targetInstitution, language: language, isBulletedList: isBulletedList)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return responce
            }
        }
        return nil
    }
}
