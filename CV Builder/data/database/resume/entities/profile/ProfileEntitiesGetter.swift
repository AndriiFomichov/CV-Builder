//
//  ProfileEntitiesGetter.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import Foundation

class ProfileEntitiesGetter {
    
    static func getSocialMediaPosition (media: SocialMediaEntity, profile: ProfileEntity) -> Int {
        if let medias = profile.socialMediasList, medias.count > 0 {
            for i in 0..<medias.count {
                let me = medias[i]
                if me.id == media.id {
                    return i
                }
            }
        }
        return -1
    }
    
    static func getSkillPosition (skill: SkillEntity, profile: ProfileEntity) -> Int {
        if let skills = profile.skillsList, skills.count > 0 {
            for i in 0..<skills.count {
                let sk = skills[i]
                if sk.id == skill.id {
                    return i
                }
            }
        }
        return -1
    }
    
    static func getEducationPosition (education: EducationEntity, profile: ProfileEntity) -> Int {
        if let educations = profile.educationsList, educations.count > 0 {
            for i in 0..<educations.count {
                let ed = educations[i]
                if ed.id == education.id {
                    return i
                }
            }
        }
        return -1
    }
    
    static func getWorkPosition (work: WorkEntity, profile: ProfileEntity) -> Int {
        if let works = profile.worksList, works.count > 0 {
            for i in 0..<works.count {
                let wo = works[i]
                if wo.id == work.id {
                    return i
                }
            }
        }
        return -1
    }
    
    static func getInterestPosition (interest: InterestEntity, profile: ProfileEntity) -> Int {
        if let interests = profile.interestsList, interests.count > 0 {
            for i in 0..<interests.count {
                let int = interests[i]
                if int.id == interest.id {
                    return i
                }
            }
        }
        return -1
    }
    
    static func getCertificatePosition (certificate: CertificateEntity, profile: ProfileEntity) -> Int {
        if let certificates = profile.certificatesList, certificates.count > 0 {
            for i in 0..<certificates.count {
                let ce = certificates[i]
                if ce.id == certificate.id {
                    return i
                }
            }
        }
        return -1
    }
    
    static func getLanguagePosition (language: LanguageEntity, profile: ProfileEntity) -> Int {
        if let languages = profile.languagesList, languages.count > 0 {
            for i in 0..<languages.count {
                let la = languages[i]
                if la.id == language.id {
                    return i
                }
            }
        }
        return -1
    }
    
    static func getReferencePosition (reference: ReferenceEntity, profile: ProfileEntity) -> Int {
        if let references = profile.referencesList, references.count > 0 {
            for i in 0..<references.count {
                let re = references[i]
                if re.id == reference.id {
                    return i
                }
            }
        }
        return -1
    }
}
