//
//  Prompts.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation

class Prompts {
    
    static func createTargetJobDescriptionCompressingPrompt(targetJobDescription: String) -> String {
        var prompt = "Compress less than 80 words. Format as:\nRole: [content]\n\nResponsibilities: [content]\nRequirements:[content]\n"
        prompt = prompt + "Text: \"" + targetJobDescription + "\""
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createSkillsGenerationPrompt(currentJob: String, targetJob: String, targetJobDescription: String, language: String) -> String {
        var prompt = "Write 5 skills of "
        
        var selectedPosition = ""
        if !currentJob.isEmpty {
            selectedPosition = currentJob
        } else if !targetJob.isEmpty {
            selectedPosition = targetJob
        } else {
            selectedPosition = "UI/UX designer"
        }
        
        prompt = prompt + selectedPosition + "\n"
        
//        if !targetJobDescription.isEmpty {
//            prompt = prompt + "Add skills required for the next job position only if it's relevant to " + selectedPosition + ":\n"
//            
//            var finalDescrioption = targetJobDescription
//            if targetJobDescription.count > 1200 {
//                finalDescrioption = targetJobDescription.substring(to: 1198)
//            }
//            prompt = prompt + finalDescrioption + "\n"
//            
//        } else if !targetJob.isEmpty && !currentJob.isEmpty {
//            prompt = prompt + "Add skills required for "
//            prompt = prompt + targetJob
//            prompt = prompt + " only if it's relevant to " + selectedPosition + "\n"
//        }
        
        prompt = prompt + "In " + language + " language.\n"
//        prompt = prompt + "Return a sentence with only 5 skills in semicolon. "
        prompt = prompt + "Format as: [Skill 1]; [Skill 2]; [Skill 3]; [Skill 4]; [Skill 5]"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createProfileDescriptionPrompt(currentJob: String, targetJob: String, targetCompany: String, targetJobDescription: String, language: String) -> String {
        var prompt = "Write profile description for my resume. My job is "
        
        var selectedPosition = ""
        if !currentJob.isEmpty {
            selectedPosition = currentJob
        } else if !targetJob.isEmpty {
            selectedPosition = targetJob
        } else {
            selectedPosition = "UI/UX designer"
        }
        
        prompt = prompt + selectedPosition + "\n\n"
        
//        if !targetJobDescription.isEmpty {
//            prompt = prompt + "Emphasize skills that 100% relevant to this job if any:\n"
//            
//            var finalDescrioption = targetJobDescription
//            if targetJobDescription.count > 1200 {
//                finalDescrioption = targetJobDescription.substring(to: 1198)
//            }
//            prompt = prompt + finalDescrioption + "\n"
//            
//        } else {
//            
//            if !targetJob.isEmpty && !currentJob.isEmpty {
//                prompt = prompt + "Emphasize skills that 100% relevant to this job: "
//                prompt = prompt + targetJob + " if any\n"
////                prompt = prompt + " only if relevant to " + selectedPosition + "\n"
//            }
//            
//            if !targetCompany.isEmpty {
//                prompt = prompt + "Say how it can be applied for "
//                prompt = prompt + targetCompany + " company\n"
//            }
//        }
        
        prompt = prompt + "In first-person perspective. Less than 65 words. "
        prompt = prompt + "In " + language + " language"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createProfileDescriptionOptPrompt(currentJob: String, description: String, targetJob: String, targetCompany: String, targetJobDescription: String, language: String) -> String {
        var selectedPosition = ""
        if !currentJob.isEmpty {
            selectedPosition = currentJob
        } else if !targetJob.isEmpty {
            selectedPosition = targetJob
        } else {
            selectedPosition = "UI/UX designer"
        }
        
        var prompt = "Here's my resume description as " + selectedPosition + ":\n"
        prompt += "\"" + description + "\"\n"
        
        prompt += "In existing description highlight skills that are relevant to "
        
        if !targetJobDescription.isEmpty {
            prompt = prompt + "new role:\n"
            
            var finalDescrioption = targetJobDescription
            if targetJobDescription.count > 1200 {
                finalDescrioption = targetJobDescription.substring(to: 1198)
            }
            prompt = prompt + "\"" + finalDescrioption + "\"\n"
            
        } else {
            
            if !targetJob.isEmpty {
                prompt = prompt + targetJob + " role"
            }
            
            if !targetCompany.isEmpty {
                prompt = prompt + " at company: " + targetCompany
            }
            
            prompt = prompt + "\n"
        }
        
        prompt = prompt + "[In first-person perspective. Without quotes. Stay as close as possible to original. Less than 50 words. "
        prompt = prompt + "In " + language + " language]"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createEducationDescriptionPrompt(degree: String, level: String, institution: String, fieldOfStudy: String, targetJob: String, targetCompany: String, targetJobDescription: String, language: String, isBulltedList: Bool) -> String {
        var prompt = "Write list of received knowledges from education in: "
        
        var selectedEducation = ""
        
        if !degree.isEmpty {
            selectedEducation = degree + ", "
        } else if !level.isEmpty {
            selectedEducation = level + ", "
        }
        
        if !fieldOfStudy.isEmpty {
            selectedEducation = selectedEducation + fieldOfStudy
        }
        
        prompt = prompt + selectedEducation + ", "
        
        if !institution.isEmpty {
            prompt = prompt + institution
        }
        
        prompt = prompt + "\n"
        
//        if !targetJobDescription.isEmpty {
////            prompt = prompt + "Add knowledges required for the next job position only if commonly relevant to studying " + selectedEducation + ":\n"
//            prompt = prompt + "Emphasize knowledges that 100% relevent to job with description if any:\n"
//            
//            var finalDescrioption = targetJobDescription
//            if targetJobDescription.count > 1200 {
//                finalDescrioption = targetJobDescription.substring(to: 1198)
//            }
//            prompt = prompt + finalDescrioption + "\n"
//            
//        } else if !targetJob.isEmpty {
////            prompt = prompt + "Add knowledges required for "
//            prompt = prompt + "Emphasize knowledges that 100% relevent to "
//            prompt = prompt + targetJob + " if any\n"
////            prompt = prompt + " only if relevant to studying " + selectedEducation + "\n"
//        }
        
//        prompt = prompt + "Less than 55 words. "
        prompt = prompt + "In " + language + " language. "
        
        var items = "4"
        if isBulltedList {
            items = "3"
        }
        
        prompt = prompt + "In first-person perspective. Less than 50 words. Format as bulleted list of " + items + " elements: • [Knowledge 1]\n• [Knowledge 2]\n• [Knowledge 3]"
        
//        if isBulletedList {
////            prompt = prompt + "In three bulleted points. "
//            prompt = prompt + "Less than 45 words. Format as bulleted list of 3 elements: • [Knowledge 1]\n• [Knowledge 2]\n• [Knowledge 3]"
//        } else {
//            prompt = prompt + "Write short abstracts. Less than 35 words in total. Format as 1 paragraph: ∼ These. These. These. These ∼"
//        }
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createEducationDescriptionOptPrompt(description: String, targetJob: String, targetCompany: String, targetJobDescription: String, language: String) -> String {
        var prompt = "Here's my current knowledges description:\n"
        prompt += "\"" + description + "\"\n"
        
        prompt += "In existing description highlight skills that are relevant to "
        
        if !targetJobDescription.isEmpty {
            prompt = prompt + "new role:\n"
            
            var finalDescrioption = targetJobDescription
            if targetJobDescription.count > 1200 {
                finalDescrioption = targetJobDescription.substring(to: 1198)
            }
            prompt = prompt + "\"" + finalDescrioption + "\"\n"
            
        } else {
            
            if !targetJob.isEmpty {
                prompt = prompt + targetJob + " role"
            }
            
//            if !targetCompany.isEmpty {
//                prompt = prompt + " at company: " + targetCompany
//            }
            
            prompt = prompt + "\n"
        }
        
        prompt = prompt + "[In past time. In first-person perspective. Without quotes. Keep dot bullet points. Stay as close as possible to original. Less than 50 words. "
        prompt = prompt + "In " + language + " language]"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createWorkDescriptionPrompt(jobTitle: String, company: String, responsibilities: String, targetJob: String, targetCompany: String, targetJobDescription: String, language: String, isBulltedList: Bool) -> String {
        var prompt = "Write list of performed responsibilities on job: "
        
        var selectedPosition = ""
        if !jobTitle.isEmpty {
            selectedPosition = jobTitle
        } else if !targetJob.isEmpty {
            selectedPosition = targetJob
        } else {
            selectedPosition = "UI/UX designer"
        }
        prompt = prompt + selectedPosition
        
        if !company.isEmpty {
            prompt = prompt + " in " + company
        }
        
        prompt = prompt + "\n"
        
        if !responsibilities.isEmpty {
            prompt = prompt + "Focus on:\n"
            
            var finalResp = responsibilities
            if finalResp.count > 500 {
                finalResp = finalResp.substring(to: 498)
            }
            
            prompt = prompt + finalResp + "\n"
        }
//        
//        if !targetJobDescription.isEmpty {
//            prompt = prompt + "Include responsibilities that are also 100% relevant to job with description if any:\n"
////            prompt = prompt + "Add skills required for the next job position only if relevant to " + selectedPosition + ":\n"
//            
//            var finalDescrioption = targetJobDescription
//            if targetJobDescription.count > 1200 {
//                finalDescrioption = targetJobDescription.substring(to: 1198)
//            }
//            prompt = prompt + finalDescrioption + "\n"
//            
//        } else {
//            
//            if !targetJob.isEmpty && !jobTitle.isEmpty {
////                prompt = prompt + "Add skills required for "
//                prompt = prompt + "Include responsibilities that are also 100% relevant to  "
//                prompt = prompt + targetJob + " if any. "
////                prompt = prompt + " only if relevant to " + selectedPosition + "\n"
//            }
//            
////            if !targetCompany.isEmpty {
//////                prompt = prompt + "Say how it applying for "
////                prompt = prompt + "Say how it applying for "
////                prompt = prompt + targetCompany + " company\n"
////            }
//        }
        
//        prompt = prompt + "Less than 55 words. "
        prompt = prompt + "In " + language + " language. "
        
        var items = "4"
        if isBulltedList {
            items = "3"
        }
        
        prompt = prompt + "In first-person perspective. Less than 50 words. Format as bulleted list of " + items + " items: • [Responsibility 1]\n• [Responsibility 2]\n• [Responsibility 3]"
        
//        if isBulletedList {
////            prompt = prompt + "In three bulleted points. "
//            prompt = prompt + "Less than 50 words. Format as bulleted list of 3 items: • [Responsibility 1]\n• [Responsibility 2]\n• [Responsibility 3]"
//        } else {
//            prompt = prompt + "Write short abstracts. Less than 35 words in total. Format as 1 paragraph: ∼ These. These. These. These ∼"
//        }
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createWorkDescriptionOptPrompt(description: String, targetJob: String, targetCompany: String, targetJobDescription: String, language: String) -> String {
        var prompt = "Here's my current experience description:\n"
        prompt += "\"" + description + "\"\n"
        
        prompt += "In existing description highlight skills that are relevant to "
        
        if !targetJobDescription.isEmpty {
            prompt = prompt + "job:\n"
            
            var finalDescrioption = targetJobDescription
            if targetJobDescription.count > 1200 {
                finalDescrioption = targetJobDescription.substring(to: 1198)
            }
            prompt = prompt + "\"" + finalDescrioption + "\"\n"
            
        } else {
            
            if !targetJob.isEmpty {
                prompt = prompt + targetJob + " role"
            }
            
//            if !targetCompany.isEmpty {
//                prompt = prompt + " at company: " + targetCompany
//            }
            
            prompt = prompt + "\n"
        }
        
        prompt = prompt + "[In past time. In first-person perspective. Without quotes. Keep dot bullet points. Stay as close as possible to original. Less than 50 words. "
        prompt = prompt + "In " + language + " language]"
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createAiTextPrompt(action: Int, customAction: String?, text: String) -> String {
        var prompt = ""
        if let customAction {
            prompt = customAction + ":\n"
        } else {
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
        }
        prompt = prompt + text
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createCoverLetterGenerationPrompt(profile: ProfileEntity, targetJob: String, targetCompany: String, targetJobDescription: String, language: String) -> String {
        var prompt = "Write cover letter less than 180 words "
        
        if !profile.jobTitle.isEmpty {
            prompt = prompt + " for " + profile.jobTitle
        }
        
        if !targetJobDescription.isEmpty {
            prompt = " applying for job:\n"
            
            var finalDescrioption = targetJobDescription
            if targetJobDescription.count > 1200 {
                finalDescrioption = targetJobDescription.substring(to: 1198)
            }
            prompt = prompt + finalDescrioption + "\n"
            
        } else if !targetJob.isEmpty || !targetCompany.isEmpty {
            prompt = " applying for "
            if !targetJob.isEmpty {
                prompt = prompt + targetJob + " position "
            }
            if !targetCompany.isEmpty {
                prompt = prompt + targetCompany
            }
            prompt = prompt + ". "
        } else {
            prompt = prompt + ". "
        }
        
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
        
        prompt = prompt + "Include only a letter body without contacts. "
        prompt = prompt + "In " + language + " language"
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
    
    static func createProofreadPrompt (text: String) -> String {
        let prompt = "Proofread and correct grammar or spelling mistakes. Stay as close as possible to original. Don't add dots. Keep original language. Return only correct text. Text:\n" + text
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createTranslatePrompt (text: String, language: String) -> String {
        let prompt = "Translate to " + language + " language. Text:\n" + text
        print("Prompt structure: " + prompt)
        return prompt
    }
    
    static func createOptimizePrompt (text: String, targetJob: String, targetCompany: String, targetJobDescription: String) -> String {
        var prompt = "Optimize when applying for "
        if !targetJobDescription.isEmpty {
            prompt = prompt + "job with description:\n"
            
            var finalDescrioption = targetJobDescription
            if targetJobDescription.count > 1200 {
                finalDescrioption = targetJobDescription.substring(to: 1198)
            }
            
            prompt = prompt + finalDescrioption
            
        } else {
            if !targetJob.isEmpty {
                prompt = prompt + targetJob + " "
                if !targetCompany.isEmpty {
                    prompt = prompt + "in "
                }
            }
            if !targetCompany.isEmpty {
                prompt = prompt + targetCompany
            }
        }
        prompt = prompt + "\n\n"
        
        prompt = prompt + "Text:\n" + text + "\n\n"
        prompt = prompt + "Stay as close as possible to original"
        
        print("Prompt structure: " + prompt)
        return prompt
    }
}
