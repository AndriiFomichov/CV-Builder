//
//  CVDefaultsWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import Foundation

class CVDefaultsWrapper {
    
    func fullfill (wrapper: CVEntityWrapper) -> CVEntityWrapper {
        
        wrapper.generalBlock = fullfillGeneralBlock(block: wrapper.generalBlock)
        wrapper.profileDescBlock = fullfillProfileDescriptionBlock(block: wrapper.profileDescBlock)
        wrapper.contactBlock = fullfillContactInfoBlock(block: wrapper.contactBlock)
        wrapper.socialBlock = fullfillSocialMediaBlock(block: wrapper.socialBlock)
        wrapper.educationBlock = fullfillEducationBlock(block: wrapper.educationBlock)
        wrapper.workBlock = fullfillWorkBlock(block: wrapper.workBlock)
        wrapper.languagesBlock = fullfillLanguagesBlock(block: wrapper.languagesBlock)
        wrapper.skillsBlock = fullfillSkillsBlock(block: wrapper.skillsBlock)
        wrapper.interestsBlock = fullfillInterestsBlock(block: wrapper.interestsBlock)
        wrapper.referencesBlock = fullfillReferencesBlock(block: wrapper.referencesBlock)
        wrapper.certificatesBlock = fullfillCertificatesBlock(block: wrapper.certificatesBlock)
        
        return wrapper
    }
    
    private func fullfillGeneralBlock (block: GeneralInfoBlockEntityWrapper?) -> GeneralInfoBlockEntityWrapper? {
        if let block {
            if block.name.isEmpty {
                block.name = NSLocalizedString("dummy_name", comment: "")
                if block.jobTitle.isEmpty {
                    block.jobTitle = NSLocalizedString("dummy_job_title", comment: "")
                }
            }
//            if block.location.isEmpty {
//                block.location = NSLocalizedString("dummy_location", comment: "")
//            }
        }
        return block
    }
    
    private func fullfillProfileDescriptionBlock (block: ProfileDescriptionBlockEntityWrapper?) -> ProfileDescriptionBlockEntityWrapper? {
        if let block {
            if block.profileDescription.isEmpty {
                block.profileDescription = NSLocalizedString("dummy_job_description", comment: "")
            }
        }
        return block
    }
    
    private func fullfillContactInfoBlock (block: ContactInfoBlockEntityWrapper?) -> ContactInfoBlockEntityWrapper? {
        if let block {
            if block.email.isEmpty && block.phone.isEmpty && block.websiteLink.isEmpty {
                block.email = NSLocalizedString("dummy_email", comment: "")
                block.phone = NSLocalizedString("dummy_phone", comment: "")
                block.websiteLink = NSLocalizedString("dummy_website", comment: "")
            }
        }
        return block
    }
    
    private func fullfillSocialMediaBlock (block: SocialMediaBlockEntityWrapper?) -> SocialMediaBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [SocialMediaBlockItemEntityWrapper] = []
                list.append(SocialMediaBlockItemEntityWrapper.getDefault(position: 0))
                list.append(SocialMediaBlockItemEntityWrapper.getDefault(position: 1))
                block.list = list
            }
        }
        return block
    }
    
    private func fullfillEducationBlock (block: EducationBlockEntityWrapper?) -> EducationBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [EducationBlockItemEntityWrapper] = []
                list.append(EducationBlockItemEntityWrapper.getDefault(position: 0))
                list.append(EducationBlockItemEntityWrapper.getDefault(position: 1))
                block.list = list
            }
        }
        return block
    }
    
    private func fullfillWorkBlock (block: WorkBlockEntityWrapper?) -> WorkBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [WorkBlockItemEntityWrapper] = []
                list.append(WorkBlockItemEntityWrapper.getDefault(position: 0))
                list.append(WorkBlockItemEntityWrapper.getDefault(position: 1))
                block.list = list
            }
        }
        return block
    }
    
    private func fullfillLanguagesBlock (block: LanguagesBlockEntityWrapper?) -> LanguagesBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [LanguageBlockItemEntityWrapper] = []
                list.append(LanguageBlockItemEntityWrapper.getDefault(position: 0))
                list.append(LanguageBlockItemEntityWrapper.getDefault(position: 1))
                block.list = list
            }
        }
        return block
    }
    
    private func fullfillSkillsBlock (block: SkillsBlockEntityWrapper?) -> SkillsBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [SkillBlockItemEntityWrapper] = []
                list.append(SkillBlockItemEntityWrapper.getDefault(position: 0))
                list.append(SkillBlockItemEntityWrapper.getDefault(position: 1))
                list.append(SkillBlockItemEntityWrapper.getDefault(position: 2))
                list.append(SkillBlockItemEntityWrapper.getDefault(position: 3))
                list.append(SkillBlockItemEntityWrapper.getDefault(position: 4))
                list.append(SkillBlockItemEntityWrapper.getDefault(position: 5))
                block.list = list
            }
        }
        return block
    }
    
    private func fullfillInterestsBlock (block: InterestsBlockEntityWrapper?) -> InterestsBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [InterestBlockItemEntityWrapper] = []
                list.append(InterestBlockItemEntityWrapper.getDefault(position: 0))
                list.append(InterestBlockItemEntityWrapper.getDefault(position: 1))
                list.append(InterestBlockItemEntityWrapper.getDefault(position: 2))
                block.list = list
            }
        }
        return block
    }
    
    private func fullfillReferencesBlock (block: ReferencesBlockEntityWrapper?) -> ReferencesBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [ReferenceBlockItemEntityWrapper] = []
                list.append(ReferenceBlockItemEntityWrapper.getDefault(position: 0))
                block.list = list
            }
        }
        return block
    }
    
    private func fullfillCertificatesBlock (block: CertificatesBlockEntityWrapper?) -> CertificatesBlockEntityWrapper? {
        if let block {
            if block.list.isEmpty {
                var list: [CertificateBlockItemEntityWrapper] = []
                list.append(CertificateBlockItemEntityWrapper.getDefault(position: 0))
                list.append(CertificateBlockItemEntityWrapper.getDefault(position: 1))
                block.list = list
            }
        }
        return block
    }
}
