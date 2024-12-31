//
//  AiTranslator.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

class AiTranslator {
    
    func translateCv (cv: CVEntity, langId: Int, language: String, translateCv: Bool = true, translateCover: Bool = true) async {
        
        if translateCv {
            await translateGeneral(cv: cv, language: language)
            await translateDescription(cv: cv, language: language)
            await translateContact(cv: cv, language: language)
            await translateEducation(cv: cv, language: language)
            await translateWork(cv: cv, language: language)
            await translateLanguages(cv: cv, language: language)
            await translateSkills(cv: cv, language: language)
            await translateInterests(cv: cv, language: language)
            await translateCertificates(cv: cv, language: language)
            await translateReferences(cv: cv, language: language)
        }
        if translateCover {
            await translateCoverLetter(cv: cv, language: language)
        }
        cv.language = langId
        
        DatabaseBox.saveContext()
    }
    
    private func translateGeneral (cv: CVEntity, language: String) async {
        if let generalBlock = cv.generalBlock {
            generalBlock.name = await translateText(text: generalBlock.name, language: language)
            generalBlock.location = await translateText(text: generalBlock.location, language: language)
            generalBlock.jobTitle = await translateText(text: generalBlock.jobTitle, language: language)
        }
    }
    
    private func translateDescription (cv: CVEntity, language: String) async {
        if let profileDescBlock = cv.profileDescBlock {
            profileDescBlock.profileDescription = await translateText(text: profileDescBlock.profileDescription, language: language)
            profileDescBlock.textAboutMe = await translateText(text: profileDescBlock.textAboutMe, language: language)
        }
    }
    
    private func translateContact (cv: CVEntity, language: String) async {
        if let contactBlock = cv.contactBlock {
            contactBlock.textContact = await translateText(text: contactBlock.textContact, language: language)
            contactBlock.textEmail = await translateText(text: contactBlock.textEmail, language: language)
            contactBlock.textPhone = await translateText(text: contactBlock.textPhone, language: language)
            contactBlock.textWebsite = await translateText(text: contactBlock.textWebsite, language: language)
        }
    }
    
    private func translateEducation (cv: CVEntity, language: String) async {
        if let educationBlock = cv.educationBlock {
            educationBlock.textEducation = await translateText(text: educationBlock.textEducation, language: language)
            if let list = educationBlock.list {
                for item in list {
                    item.desc = await translateText(text: item.desc, language: language)
                    item.degree = await translateText(text: item.degree, language: language)
                    item.fieldOfStudy = await translateText(text: item.fieldOfStudy, language: language)
                    item.level = await translateText(text: item.level, language: language)
                    item.institution = await translateText(text: item.institution, language: language)
                    item.coursework = await translateText(text: item.coursework, language: language)
                }
            }
        }
    }
    
    private func translateWork (cv: CVEntity, language: String) async {
        if let workBlock = cv.workBlock {
            workBlock.textWorkExperience = await translateText(text: workBlock.textWorkExperience, language: language)
            if let list = workBlock.list {
                for item in list {
                    item.desc = await translateText(text: item.desc, language: language)
                    item.jobTitle = await translateText(text: item.jobTitle, language: language)
//                    item.company = await translateText(text: item.company, language: language)
                    item.location = await translateText(text: item.location, language: language)
                    item.responsibilities = await translateText(text: item.responsibilities, language: language)
                }
            }
        }
    }
    
    private func translateLanguages (cv: CVEntity, language: String) async {
        if let languagesBlock = cv.languagesBlock {
            languagesBlock.textLanguages = await translateText(text: languagesBlock.textLanguages, language: language)
            if let list = languagesBlock.list {
                for item in list {
                    item.name = await translateText(text: item.name, language: language)
                }
            }
        }
    }
    
    private func translateSkills (cv: CVEntity, language: String) async {
        if let skillsBlock = cv.skillsBlock {
            skillsBlock.textSkills = await translateText(text: skillsBlock.textSkills, language: language)
            if let list = skillsBlock.list {
                for item in list {
                    item.name = await translateText(text: item.name, language: language)
                }
            }
        }
    }
    
    private func translateInterests (cv: CVEntity, language: String) async {
        if let interestsBlock = cv.interestsBlock {
            interestsBlock.textInterests = await translateText(text: interestsBlock.textInterests, language: language)
            if let list = interestsBlock.list {
                for item in list {
                    item.name = await translateText(text: item.name, language: language)
                }
            }
        }
    }
    
    private func translateCertificates (cv: CVEntity, language: String) async {
        if let certificatesBlock = cv.certificatesBlock {
            certificatesBlock.textCertificates = await translateText(text: certificatesBlock.textCertificates, language: language)
            if let list = certificatesBlock.list {
                for item in list {
                    item.name = await translateText(text: item.name, language: language)
                }
            }
        }
    }
    
    private func translateReferences (cv: CVEntity, language: String) async {
        if let referencesBlock = cv.referencesBlock {
            referencesBlock.textReferences = await translateText(text: referencesBlock.textReferences, language: language)
            if let list = referencesBlock.list {
                for item in list {
                    item.referralName = await translateText(text: item.referralName, language: language)
                }
            }
        }
    }
    
    private func translateCoverLetter (cv: CVEntity, language: String) async {
        if let coverLetter = cv.coverLetter {
            coverLetter.text = await translateText(text: coverLetter.text, language: language)
        }
    }
    
    private func translateText (text: String, language: String) async -> String {
        var finalText = text
        if !text.isEmpty {
            let prompt = Prompts.createTranslatePrompt(text: text, language: language)
            let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
            if let responce, !responce.isEmpty {
                finalText = responce
            }
        }
        return finalText
    }
}
