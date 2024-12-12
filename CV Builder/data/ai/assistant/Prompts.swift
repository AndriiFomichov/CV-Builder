//
//  Prompts.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class Prompts {
    
    static func createSkillsGenerationPrompt(currentJob: String, targetJob: String, targetCompany: String, language: String) -> String {
        var prompt = "5 common skills of "
        if !currentJob.isEmpty {
            prompt = prompt + currentJob
        } else {
            prompt = prompt + "UI/UX designer"
        }
        if !targetJob.isEmpty || !targetCompany.isEmpty {
            prompt = prompt + ". Highlight skills, required to apply for "
            
            if !targetJob.isEmpty {
                prompt = prompt + targetJob
            }
            if !targetCompany.isEmpty {
                prompt = prompt + " in " + targetCompany
            }
        }
        prompt = prompt + ". In commas. "
        prompt = prompt + " In " + language + " language. Without quotes"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createProfileDescriptionPrompt(currentJob: String, targetJob: String, targetCompany: String, language: String) -> String {
        var prompt = "CV profile description for "
        if !currentJob.isEmpty {
            prompt = prompt + currentJob
        } else {
            prompt = prompt + "UI/UX designer"
        }
        if !targetJob.isEmpty || !targetCompany.isEmpty {
            prompt = prompt + ". Highlight skills, required to apply for "
            
            if !targetJob.isEmpty {
                prompt = prompt + targetJob
            }
            if !targetCompany.isEmpty {
                prompt = prompt + " in " + targetCompany
            }
        }
        prompt = prompt + ". In two sentences. "
        prompt = prompt + " In " + language + " language"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createEducationDescriptionPrompt(degree: String, level: String, institution: String, targetJob: String, targetCompany: String, language: String, isBulletedList: Bool) -> String {
        var prompt = "CV education description in "
        if !degree.isEmpty {
            prompt = prompt + degree
        } else if !level.isEmpty {
            prompt = prompt + level
        }
        
        if !institution.isEmpty {
            prompt = prompt + institution
        } else {
            prompt = prompt + "university"
        }
        
        if !targetJob.isEmpty || !targetCompany.isEmpty {
            prompt = prompt + ". Highlight skills, required to apply for "
            
            if !targetJob.isEmpty {
                prompt = prompt + targetJob
            }
            if !targetCompany.isEmpty {
                prompt = prompt + " in " + targetCompany
            }
        }
        if isBulletedList {
            prompt = prompt + ". In three short bullet points. "
        } else {
            prompt = prompt + ". In two sentences. "
        }
        prompt = prompt + " In " + language + " language"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createWorkDescriptionPrompt(jobTitle: String, company: String, targetJob: String, targetCompany: String, language: String, isBulletedList: Bool) -> String {
        var prompt = "CV work description for "
        if !jobTitle.isEmpty {
            prompt = prompt + jobTitle
        } else if company.isEmpty {
            prompt = prompt + "UI/UX designed"
        }
        
        if !company.isEmpty {
            prompt = prompt + " in " + company
        }
        
        if !targetJob.isEmpty || !targetCompany.isEmpty {
            prompt = prompt + ". Highlight skills, required to apply for "
            
            if !targetJob.isEmpty {
                prompt = prompt + targetJob
            }
            if !targetCompany.isEmpty {
                prompt = prompt + " in " + targetCompany
            }
        }
        if isBulletedList {
            prompt = prompt + ". In three short bullet points. "
        } else {
            prompt = prompt + ". In two sentences. "
        }
        prompt = prompt + " In " + language + " language"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createAiTextPrompt(action: Int, text: String) -> String {
        var prompt = ""
        switch action {
        case 0:
            prompt = "Rephrase text:\n"
        case 1:
            prompt = "Expand text:\n"
        case 2:
            prompt = "Shorten text:\n"
        case 3:
            prompt = "Convert text to bulleted list:\n"
        default:
            prompt = "Rephrase text:\n"
        }
        prompt = prompt + text
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createCoverLetterGenerationPrompt(profile: ProfileEntity, targetJob: String, targetCompany: String, language: String) -> String {
        var prompt = "Generate short cover letter "
        if !profile.jobTitle.isEmpty {
            prompt = prompt + " for " + profile.jobTitle
        }
        if !targetJob.isEmpty && !targetCompany.isEmpty {
            prompt = " applying for "
            if !targetJob.isEmpty {
                prompt = prompt + targetJob + " position "
            }
            if !targetCompany.isEmpty {
                prompt = prompt + targetCompany
            }
        }
        prompt = prompt + ". "
        
        var educationIndex = 0
        if let educationsList = profile.educationsList, educationsList.count > 0 {
            prompt = prompt + "Educated in: "
            for education in educationsList {
                if !education.institution.isEmpty {
                    prompt = prompt + education.institution + ", "
                }
                if !education.fieldOfStudy.isEmpty {
                    prompt = prompt + education.fieldOfStudy + ", "
                }
                if !education.degree.isEmpty {
                    prompt = prompt + education.degree + ", "
                } else if !education.level.isEmpty {
                    prompt = prompt + education.level + ", "
                }
                prompt = prompt + getYearsFromDate(dateStart: education.startDate, dateEnd: education.endDate, isStill: education.isStillLearning)
                
                if educationIndex < educationsList.count - 1 {
                    prompt = prompt + "; "
                }
                educationIndex += 1
            }
            prompt = prompt + ". "
        }
        
        var workIndex = 0
        if let worksList = profile.worksList, worksList.count > 0 {
            prompt = prompt + "Worked in: "
            for work in worksList {
                if !work.jobTitle.isEmpty {
                    prompt = prompt + work.jobTitle + ", "
                }
                if !work.company.isEmpty {
                    prompt = prompt + work.company + ", "
                }
                prompt = prompt + getYearsFromDate(dateStart: work.startDate, dateEnd: work.endDate, isStill: work.isStillWorking)
                
                if workIndex < worksList.count - 1 {
                    prompt = prompt + "; "
                }
                workIndex += 1
            }
            prompt = prompt + ". "
        }
        
        prompt = prompt + ". Write just a letter body."
        prompt = prompt + " In " + language + " language"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    private static func getYearsFromDate (dateStart: Date?, dateEnd: Date?, isStill: Bool) -> String {
        var datesText = ""
        if let dateStart {
            datesText = String(Calendar.current.component(.year, from: dateStart)) + " - "
        }
        if isStill {
            datesText = datesText + "now"
        } else {
            if let dateEnd {
                datesText = datesText + String(Calendar.current.component(.year, from: dateEnd))
            }
        }
        return datesText
    }
    
    static func createProofreadPrompt(text: String) -> String {
        var prompt = "Proofread text, corrent if needed:\n" + text
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createTranslatePrompt(text: String, language: String) -> String {
        var prompt = "Translate text to " + language + " language:\n" + text
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createOptimizePrompt(text: String, targetJob: String, targetCompany: String) -> String {
        var prompt = "Optimize description for "
        if !targetJob.isEmpty {
            prompt = prompt + targetJob + " "
            if !targetCompany.isEmpty {
                prompt = prompt + "in "
            }
        }
        if !targetCompany.isEmpty {
            prompt = prompt + targetCompany
        }
        prompt = prompt + "\n" + text
        print("Prompt structure: " + prompt)
        return prompt
    }
}
