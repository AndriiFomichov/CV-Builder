//
//  AIAssistant.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation

class AIAssistant {
    
    // COVER LETTER
    
    static func applyAiActionCoverLetter (profile: ProfileEntity, cv: CVEntity, targetJob: String, targetCompany: String, targetJobDescription: String, language: Language, action: Int, customAction: String?) async -> Bool {
        let cvBuilder = CVBuilder()
        
        var noData = false
        
        if let coverLetter = cv.coverLetter {
            if coverLetter.text.count == 0 {
                if profile.jobTitle.isEmpty && targetJob.isEmpty && targetCompany.isEmpty && targetJobDescription.isEmpty {
                    noData = true
                } else {
                    let letter = await generateCoverLetter(profile: profile, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name)
                    cvBuilder.updateCoverLetter(cover: coverLetter, text: letter)
                    //                        AiManager.useAiTextAttempt()
                }
            } else {
                let letter = await updateText(text: coverLetter.text, action: action, customAction: customAction)
                cvBuilder.updateCoverLetter(cover: coverLetter, text: letter)
                //                        AiManager.useAiTextAttempt()
            }
        } else {
            if profile.jobTitle.isEmpty && targetJob.isEmpty && targetCompany.isEmpty && targetJobDescription.isEmpty {
                noData = true
            } else {
                let letter = await generateCoverLetter(profile: profile, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name)
                cvBuilder.saveCoverLetter(cv: cv, text: letter)
            }
        }
        return noData
    }
    
    private static func generateCoverLetter (profile: ProfileEntity, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String) async -> String {
        if !profile.jobTitle.isEmpty || !targetJob.isEmpty || !targetInstitution.isEmpty || !targetJobDescription.isEmpty {
            let prompt = Prompts.createCoverLetterGenerationPrompt(profile: profile, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: targetJobDescription, language: language)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return responce
            }
        }
        return ""
    }
    
    // TEXT AI ACTION
    
    static func applyTextAiAction (currentJob: String?, workItem: WorkBlockItemEntity?, educationItem: EducationBlockItemEntity?, targetJob: String, targetCompany: String, targetJobDescription: String, action: Int, customAction: String?, text: String, isBulletedList: Bool, langId: Int) async -> String? {
        
        let language = PreloadedDatabase.getLanguageById(id: langId)
        
        print("Text: " + text)
        
        if text.isEmpty {
            if let educationItem {
                return await generateEducationDescription(item: educationItem, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name, isBulletedList: isBulletedList)
            } else if let workItem {
                return await generateWorkDescription(item: workItem, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name, isBulletedList: isBulletedList)
            } else if let currentJob {
                return await generateProfileDescription(currentJob: currentJob, targetJob: targetJob, targetInstitution: targetCompany, targetJobDescription: targetJobDescription, language: language.name)
            }
            //                        AiManager.useAiTextAttempt()
        } else {
            return await updateText(text: text, action: action, customAction: customAction)
            //                        AiManager.useAiTextAttempt()
        }
        
        return nil
    }
    
    private static func updateText (text: String, action: Int, customAction: String? = nil) async -> String {
        if !text.isEmpty {
            let prompt = Prompts.createAiTextPrompt(action: action, customAction: customAction, text: text)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return responce
            }
        }
        return ""
    }
    
    
    // TARGET JOB
    
    static func optimizeTargetJobDescription (targetJobDescription: String) async -> String {
        var finalText = targetJobDescription
        if targetJobDescription.count > 1200 {
            let prompt = Prompts.createTargetJobDescriptionCompressingPrompt(targetJobDescription: targetJobDescription)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                finalText = responce
            }
        }
        return finalText
    }
    
    
    // RESUME GENERATION
    
    static func generateUserSkills (currentJob: String, targetJob: String, targetJobDescription: String, language: String) async -> [String] {
        if !currentJob.isEmpty || !targetJob.isEmpty {
            let prompt = Prompts.createSkillsGenerationPrompt(currentJob: currentJob, targetJob: targetJob, targetJobDescription: targetJobDescription, language: language)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 500, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                var skills: [String] = []
                
                let rawComponenets = responce.components(separatedBy: "; ")
                for component in rawComponenets {
                    if component.count < 65 {
                        var skill = component.capitalizingFirstLetter()
                        if skill[skill.count-1] == "." {
                            skill = String(skill[0..<skill.count-1])
                        }
                        skills.append(skill)
                    }
                }
                
                return skills
            }
        }
        return []
    }
    
    static func generateProfileDescription (currentJob: String, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String) async -> String? {
        if !currentJob.isEmpty || !targetJob.isEmpty {
            let prompt = Prompts.createProfileDescriptionPrompt(currentJob: currentJob, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: targetJobDescription, language: language)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return await optimizeProfileDescription(currentJob: currentJob, description: responce, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: targetJobDescription, language: language)
            }
        }
        return nil
    }
    
    static func optimizeProfileDescription (currentJob: String, description: String, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String) async -> String? {
        var responce = description
        if !targetJob.isEmpty || !targetInstitution.isEmpty || !targetJobDescription.isEmpty {
            let promptOpt = Prompts.createProfileDescriptionOptPrompt(currentJob: currentJob, description: responce, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: targetJobDescription, language: language)
            if let responceOpt = await TextGenerator.completeText(prompt: promptOpt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM), !responceOpt.isEmpty {
                responce = responceOpt
            }
        }
        return responce
    }
    
    static func generateEducationDescription (item: EducationBlockItemEntity, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String, isBulletedList: Bool) async -> String? {
        if !item.degree.isEmpty || !item.fieldOfStudy.isEmpty {
            let prompt = Prompts.createEducationDescriptionPrompt(degree: item.degree, level: item.level, institution: item.institution, fieldOfStudy: item.fieldOfStudy, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: targetJobDescription, language: language, isBulltedList: isBulletedList)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return await optimizeEducationDescription(description: responce, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: targetJobDescription, language: language, isBulletedList: isBulletedList)
            }
        }
        return nil
    }
    
    static func optimizeEducationDescription (description: String, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String, isBulletedList: Bool) async -> String? {
        var responce = description
        if !targetJob.isEmpty || !targetInstitution.isEmpty || !targetJobDescription.isEmpty {
            let promptOpt = Prompts.createEducationDescriptionOptPrompt(description: responce, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: targetJobDescription, language: language)
            if let responceOpt = await TextGenerator.completeText(prompt: promptOpt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM), !responceOpt.isEmpty {
                responce = responceOpt
            }
        }
        
        if isBulletedList {
            return responce
        } else {
            return combineBulletedListToparagraph(responce: responce)
        }
    }
    
    static func generateWorkDescription (item: WorkBlockItemEntity, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String, isBulletedList: Bool) async -> String? {
        if !item.jobTitle.isEmpty || !targetJob.isEmpty {
            let prompt = Prompts.createWorkDescriptionPrompt(jobTitle: item.jobTitle, company: item.company, responsibilities: item.responsibilities, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: targetJobDescription, language: language, isBulltedList: isBulletedList)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                return await optimizeWorkDescription(description: responce, targetJob: targetJob, targetInstitution: targetInstitution, targetJobDescription: targetJobDescription, language: language, isBulletedList: isBulletedList)
            }
        }
        return nil
    }
    
    static func optimizeWorkDescription (description: String, targetJob: String, targetInstitution: String, targetJobDescription: String, language: String, isBulletedList: Bool) async -> String? {
        var responce = description
        if !targetJob.isEmpty || !targetInstitution.isEmpty || !targetJobDescription.isEmpty {
            let promptOpt = Prompts.createWorkDescriptionOptPrompt(description: responce, targetJob: targetJob, targetCompany: targetInstitution, targetJobDescription: targetJobDescription, language: language)
            if let responceOpt = await TextGenerator.completeText(prompt: promptOpt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM), !responceOpt.isEmpty {
                responce = responceOpt
            }
        }
        
        if isBulletedList {
            return responce
        } else {
            return combineBulletedListToparagraph(responce: responce)
        }
    }
    
    static func combineBulletedListToparagraph (responce: String) -> String {
        var paragraph = ""
        let components = responce.components(separatedBy: "•")
        for component in components {
            if component.count > 2 {
                print("S0")
                var finalComponent = component
                if finalComponent[0] == " " {
                    print("S1")
                    finalComponent = String(finalComponent[1..<finalComponent.count])
                }
                if finalComponent[finalComponent.count-1] == "\n" {
                    print("S2")
                    finalComponent = String(finalComponent[0..<finalComponent.count-1])
                }
                paragraph += finalComponent + ". "
            }
        }
        return paragraph
    }
}
