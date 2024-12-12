//
//  CVVisualizationBuilder.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 16.11.2024.
//

import Foundation

class CVVisualizationBuilder {
    
    func createVisualization (cv: CVEntity) -> CVEntityWrapper {
        return CVEntityWrapper(entity: cv)
    }
    
    func createVisualizationsList (style: Style, cv: CVEntity) -> [CVEntityWrapper] {
        var wrappersList: [CVEntityWrapper] = []
        
        var wrapperOne = CVEntityWrapper(entity: cv)
        wrapperOne.id = 0
        wrapperOne.wrapperName = NSLocalizedString("wrapper_name_0", comment: "")
        wrapperOne = updatePositionsWrapperOne(style: style, wrapper: wrapperOne)
        wrappersList.append(wrapperOne)
        
        var wrapperTwo = CVEntityWrapper(entity: cv)
        wrapperTwo.id = 1
        wrapperTwo.wrapperName = NSLocalizedString("wrapper_name_1", comment: "")
        wrapperTwo = updatePositionsWrapperTwo(style: style, wrapper: wrapperTwo)
        wrappersList.append(wrapperTwo)
        
        var wrapperThree = CVEntityWrapper(entity: cv)
        wrapperThree.id = 2
        wrapperThree.wrapperName = NSLocalizedString("wrapper_name_2", comment: "")
        wrapperThree = updatePositionsWrapperThree(style: style, wrapper: wrapperThree)
        wrappersList.append(wrapperThree)
        
        var wrapperFour = CVEntityWrapper(entity: cv)
        wrapperFour.id = 3
        wrapperFour.wrapperName = NSLocalizedString("wrapper_name_3", comment: "")
        wrapperFour = updatePositionsWrapperFour(style: style, wrapper: wrapperFour)
        wrappersList.append(wrapperFour)
        
        var wrapperFive = CVEntityWrapper(entity: cv)
        wrapperFive.id = 4
        wrapperFive.wrapperName = NSLocalizedString("wrapper_name_4", comment: "")
        wrapperFive = updatePositionsWrapperFive(style: style, wrapper: wrapperFive)
        wrappersList.append(wrapperFive)
    
        return wrappersList
    }
    
    func updatePositionsWrapperOne (style: Style, wrapper: CVEntityWrapper) -> CVEntityWrapper {
        let hasAdditionalBlock = style.hasAdditionalBlock
        
        if let profileDescBlock = wrapper.profileDescBlock {
            profileDescBlock.position = 0
            profileDescBlock.isMainBlock = true
            wrapper.profileDescBlock = profileDescBlock
        }
        if let contactBlock = wrapper.contactBlock {
            if hasAdditionalBlock {
                contactBlock.position = 0
                contactBlock.isMainBlock = false
            } else {
                contactBlock.position = 1
                contactBlock.isMainBlock = true
            }
            wrapper.contactBlock = contactBlock
        }
        if let educationBlock = wrapper.educationBlock {
            educationBlock.isMainBlock = true
            if hasAdditionalBlock {
                educationBlock.position = 2
            } else {
                educationBlock.position = 3
            }
            wrapper.educationBlock = educationBlock
        }
        if let workBlock = wrapper.workBlock {
            workBlock.isMainBlock = true
            if hasAdditionalBlock {
                workBlock.position = 1
            } else {
                workBlock.position = 2
            }
            wrapper.workBlock = workBlock
        }
        if let skillsBlock = wrapper.skillsBlock {
            skillsBlock.isMainBlock = true
            if hasAdditionalBlock {
                skillsBlock.position = 3
            } else {
                skillsBlock.position = 4
            }
            wrapper.skillsBlock = skillsBlock
        }
        if let languagesBlock = wrapper.languagesBlock {
            languagesBlock.isMainBlock = true
            if hasAdditionalBlock {
                languagesBlock.position = 4
            } else {
                languagesBlock.position = 5
            }
            wrapper.languagesBlock = languagesBlock
        }
        if let interestsBlock = wrapper.interestsBlock {
            if hasAdditionalBlock {
                interestsBlock.position = 1
                interestsBlock.isMainBlock = false
            } else {
                interestsBlock.position = 7
                interestsBlock.isMainBlock = true
            }
            wrapper.interestsBlock = interestsBlock
        }
        if let certificatesBlock = wrapper.certificatesBlock {
            certificatesBlock.isMainBlock = true
            if hasAdditionalBlock {
                certificatesBlock.position = 5
            } else {
                certificatesBlock.position = 6
            }
            wrapper.certificatesBlock = certificatesBlock
        }
        if let referencesBlock = wrapper.referencesBlock {
            referencesBlock.isMainBlock = true
            if hasAdditionalBlock {
                referencesBlock.position = 6
            } else {
                referencesBlock.position = 8
            }
            wrapper.referencesBlock = referencesBlock
        }
        if let socialBlock = wrapper.socialBlock {
            if hasAdditionalBlock {
                socialBlock.position = 2
                socialBlock.isMainBlock = false
            } else {
                socialBlock.position = 9
                socialBlock.isMainBlock = true
            }
            wrapper.socialBlock = socialBlock
        }
        if let qrCodesBlock = wrapper.qrCodesBlock {
            qrCodesBlock.isMainBlock = true
            if hasAdditionalBlock {
                qrCodesBlock.position = 7
            } else {
                qrCodesBlock.position = 10
            }
            wrapper.qrCodesBlock = qrCodesBlock
        }
        return wrapper
    }
    
    func updatePositionsWrapperTwo (style: Style, wrapper: CVEntityWrapper) -> CVEntityWrapper {
        let hasAdditionalBlock = style.hasAdditionalBlock
        
        if let profileDescBlock = wrapper.profileDescBlock {
            profileDescBlock.position = 0
            profileDescBlock.isMainBlock = true
            wrapper.profileDescBlock = profileDescBlock
        }
        if let contactBlock = wrapper.contactBlock {
            if hasAdditionalBlock {
                contactBlock.position = 2
                contactBlock.isMainBlock = false
            } else {
                contactBlock.position = 8
                contactBlock.isMainBlock = true
            }
            wrapper.contactBlock = contactBlock
        }
        if let educationBlock = wrapper.educationBlock {
            educationBlock.isMainBlock = true
            educationBlock.position = 1
            wrapper.educationBlock = educationBlock
        }
        if let workBlock = wrapper.workBlock {
            workBlock.isMainBlock = true
            workBlock.position = 2
            wrapper.workBlock = workBlock
        }
        if let skillsBlock = wrapper.skillsBlock {
            if hasAdditionalBlock {
                skillsBlock.isMainBlock = false
                skillsBlock.position = 0
            } else {
                skillsBlock.isMainBlock = true
                skillsBlock.position = 3
            }
            wrapper.skillsBlock = skillsBlock
        }
        if let languagesBlock = wrapper.languagesBlock {
            if hasAdditionalBlock {
                languagesBlock.position = 1
                languagesBlock.isMainBlock = false
            } else {
                languagesBlock.position = 4
                languagesBlock.isMainBlock = true
            }
            wrapper.languagesBlock = languagesBlock
        }
        if let interestsBlock = wrapper.interestsBlock {
            interestsBlock.isMainBlock = true
            if hasAdditionalBlock {
                interestsBlock.position = 5
            } else {
                interestsBlock.position = 7
            }
            wrapper.interestsBlock = interestsBlock
        }
        if let certificatesBlock = wrapper.certificatesBlock {
            certificatesBlock.isMainBlock = true
            if hasAdditionalBlock {
                certificatesBlock.position = 3
            } else {
                certificatesBlock.position = 5
            }
            wrapper.certificatesBlock = certificatesBlock
        }
        if let referencesBlock = wrapper.referencesBlock {
            referencesBlock.isMainBlock = true
            if hasAdditionalBlock {
                referencesBlock.position = 4
            } else {
                referencesBlock.position = 6
            }
            wrapper.referencesBlock = referencesBlock
        }
        if let socialBlock = wrapper.socialBlock {
            socialBlock.isMainBlock = true
            if hasAdditionalBlock {
                socialBlock.position = 6
            } else {
                socialBlock.position = 9
            }
            wrapper.socialBlock = socialBlock
        }
        if let qrCodesBlock = wrapper.qrCodesBlock {
            qrCodesBlock.isMainBlock = true
            if hasAdditionalBlock {
                qrCodesBlock.position = 7
            } else {
                qrCodesBlock.position = 10
            }
            wrapper.qrCodesBlock = qrCodesBlock
        }
        return wrapper
    }
    
    func updatePositionsWrapperThree (style: Style, wrapper: CVEntityWrapper) -> CVEntityWrapper {
        let hasAdditionalBlock = style.hasAdditionalBlock
        
        if let profileDescBlock = wrapper.profileDescBlock {
            profileDescBlock.position = 0
            if hasAdditionalBlock {
                profileDescBlock.isMainBlock = false
            } else {
                profileDescBlock.isMainBlock = true
            }
            wrapper.profileDescBlock = profileDescBlock
        }
        if let contactBlock = wrapper.contactBlock {
            if hasAdditionalBlock {
                contactBlock.position = 2
                contactBlock.isMainBlock = false
            } else {
                contactBlock.position = 8
                contactBlock.isMainBlock = true
            }
            wrapper.contactBlock = contactBlock
        }
        if let educationBlock = wrapper.educationBlock {
            educationBlock.isMainBlock = true
            if hasAdditionalBlock {
                educationBlock.position = 3
            } else {
                educationBlock.position = 4
            }
            wrapper.educationBlock = educationBlock
        }
        if let workBlock = wrapper.workBlock {
            workBlock.isMainBlock = true
            if hasAdditionalBlock {
                workBlock.position = 0
            } else {
                workBlock.position = 1
            }
            wrapper.workBlock = workBlock
        }
        if let skillsBlock = wrapper.skillsBlock {
            skillsBlock.isMainBlock = true
            if hasAdditionalBlock {
                skillsBlock.position = 1
            } else {
                skillsBlock.position = 2
            }
            wrapper.skillsBlock = skillsBlock
        }
        if let languagesBlock = wrapper.languagesBlock {
            languagesBlock.isMainBlock = true
            if hasAdditionalBlock {
                languagesBlock.position = 2
            } else {
                languagesBlock.position = 3
            }
            wrapper.languagesBlock = languagesBlock
        }
        if let interestsBlock = wrapper.interestsBlock {
            if hasAdditionalBlock {
                interestsBlock.position = 1
                interestsBlock.isMainBlock = false
            } else {
                interestsBlock.position = 7
                interestsBlock.isMainBlock = true
            }
            wrapper.interestsBlock = interestsBlock
        }
        if let certificatesBlock = wrapper.certificatesBlock {
            certificatesBlock.isMainBlock = true
            if hasAdditionalBlock {
                certificatesBlock.position = 5
            } else {
                certificatesBlock.position = 6
            }
            wrapper.certificatesBlock = certificatesBlock
        }
        if let referencesBlock = wrapper.referencesBlock {
            referencesBlock.isMainBlock = true
            if hasAdditionalBlock {
                referencesBlock.position = 4
            } else {
                referencesBlock.position = 5
            }
            wrapper.referencesBlock = referencesBlock
        }
        if let socialBlock = wrapper.socialBlock {
            if hasAdditionalBlock {
                socialBlock.position = 3
                socialBlock.isMainBlock = false
            } else {
                socialBlock.position = 9
                socialBlock.isMainBlock = true
            }
            wrapper.socialBlock = socialBlock
        }
        if let qrCodesBlock = wrapper.qrCodesBlock {
            qrCodesBlock.isMainBlock = true
            if hasAdditionalBlock {
                qrCodesBlock.position = 6
            } else {
                qrCodesBlock.position = 10
            }
            wrapper.qrCodesBlock = qrCodesBlock
        }
        return wrapper
    }
    
    func updatePositionsWrapperFour (style: Style, wrapper: CVEntityWrapper) -> CVEntityWrapper {
        let hasAdditionalBlock = style.hasAdditionalBlock
        
        if let profileDescBlock = wrapper.profileDescBlock {
            profileDescBlock.position = 0
            if hasAdditionalBlock {
                profileDescBlock.isMainBlock = false
            } else {
                profileDescBlock.isMainBlock = true
            }
            wrapper.profileDescBlock = profileDescBlock
        }
        if let contactBlock = wrapper.contactBlock {
            contactBlock.isMainBlock = true
            if hasAdditionalBlock {
                contactBlock.position = 7
            } else {
                contactBlock.position = 8
            }
            wrapper.contactBlock = contactBlock
        }
        if let educationBlock = wrapper.educationBlock {
            educationBlock.isMainBlock = true
            if hasAdditionalBlock {
                educationBlock.position = 0
            } else {
                educationBlock.position = 1
            }
            wrapper.educationBlock = educationBlock
        }
        if let workBlock = wrapper.workBlock {
            workBlock.isMainBlock = true
            if hasAdditionalBlock {
                workBlock.position = 4
            } else {
                workBlock.position = 5
            }
            wrapper.workBlock = workBlock
        }
        if let skillsBlock = wrapper.skillsBlock {
            skillsBlock.isMainBlock = true
            if hasAdditionalBlock {
                skillsBlock.position = 1
            } else {
                skillsBlock.position = 2
            }
            wrapper.skillsBlock = skillsBlock
        }
        if let languagesBlock = wrapper.languagesBlock {
            languagesBlock.isMainBlock = true
            if hasAdditionalBlock {
                languagesBlock.position = 2
            } else {
                languagesBlock.position = 3
            }
            wrapper.languagesBlock = languagesBlock
        }
        if let interestsBlock = wrapper.interestsBlock {
            interestsBlock.isMainBlock = true
            if hasAdditionalBlock {
                interestsBlock.position = 6
            } else {
                interestsBlock.position = 7
            }
            wrapper.interestsBlock = interestsBlock
        }
        if let certificatesBlock = wrapper.certificatesBlock {
            certificatesBlock.isMainBlock = true
            if hasAdditionalBlock {
                certificatesBlock.position = 3
            } else {
                certificatesBlock.position = 4
            }
            wrapper.certificatesBlock = certificatesBlock
        }
        if let referencesBlock = wrapper.referencesBlock {
            referencesBlock.isMainBlock = true
            if hasAdditionalBlock {
                referencesBlock.position = 5
            } else {
                referencesBlock.position = 6
            }
            wrapper.referencesBlock = referencesBlock
        }
        if let socialBlock = wrapper.socialBlock {
            if hasAdditionalBlock {
                socialBlock.position = 1
                socialBlock.isMainBlock = false
            } else {
                socialBlock.position = 9
                socialBlock.isMainBlock = true
            }
            wrapper.socialBlock = socialBlock
        }
        if let qrCodesBlock = wrapper.qrCodesBlock {
            if hasAdditionalBlock {
                qrCodesBlock.position = 2
                qrCodesBlock.isMainBlock = false
            } else {
                qrCodesBlock.position = 10
                qrCodesBlock.isMainBlock = true
            }
            wrapper.qrCodesBlock = qrCodesBlock
        }
        return wrapper
    }
    
    func updatePositionsWrapperFive (style: Style, wrapper: CVEntityWrapper) -> CVEntityWrapper {
        let hasAdditionalBlock = style.hasAdditionalBlock
        
        if let profileDescBlock = wrapper.profileDescBlock {
            profileDescBlock.position = 0
            if hasAdditionalBlock {
                profileDescBlock.isMainBlock = false
            } else {
                profileDescBlock.isMainBlock = true
            }
            wrapper.profileDescBlock = profileDescBlock
        }
        if let contactBlock = wrapper.contactBlock {
            contactBlock.isMainBlock = true
            if hasAdditionalBlock {
                contactBlock.position = 5
            } else {
                contactBlock.position = 8
            }
            wrapper.contactBlock = contactBlock
        }
        if let educationBlock = wrapper.educationBlock {
            if hasAdditionalBlock {
                educationBlock.position = 1
                educationBlock.isMainBlock = false
            } else {
                educationBlock.position = 4
                educationBlock.isMainBlock = true
            }
            wrapper.educationBlock = educationBlock
        }
        if let workBlock = wrapper.workBlock {
            workBlock.isMainBlock = true
            if hasAdditionalBlock {
                workBlock.position = 1
            } else {
                workBlock.position = 2
            }
            wrapper.workBlock = workBlock
        }
        if let skillsBlock = wrapper.skillsBlock {
            skillsBlock.isMainBlock = true
            if hasAdditionalBlock {
                skillsBlock.position = 0
            } else {
                skillsBlock.position = 1
            }
            wrapper.skillsBlock = skillsBlock
        }
        if let languagesBlock = wrapper.languagesBlock {
            if hasAdditionalBlock {
                languagesBlock.position = 2
                languagesBlock.isMainBlock = false
            } else {
                languagesBlock.position = 6
                languagesBlock.isMainBlock = true
            }
            wrapper.languagesBlock = languagesBlock
        }
        if let interestsBlock = wrapper.interestsBlock {
            interestsBlock.isMainBlock = true
            if hasAdditionalBlock {
                interestsBlock.position = 4
            } else {
                interestsBlock.position = 7
            }
            wrapper.interestsBlock = interestsBlock
        }
        if let certificatesBlock = wrapper.certificatesBlock {
            certificatesBlock.isMainBlock = true
            if hasAdditionalBlock {
                certificatesBlock.position = 2
            } else {
                certificatesBlock.position = 3
            }
            wrapper.certificatesBlock = certificatesBlock
        }
        if let referencesBlock = wrapper.referencesBlock {
            referencesBlock.isMainBlock = true
            if hasAdditionalBlock {
                referencesBlock.position = 3
            } else {
                referencesBlock.position = 5
            }
            wrapper.referencesBlock = referencesBlock
        }
        if let socialBlock = wrapper.socialBlock {
            if hasAdditionalBlock {
                socialBlock.position = 3
                socialBlock.isMainBlock = false
            } else {
                socialBlock.position = 9
                socialBlock.isMainBlock = true
            }
            wrapper.socialBlock = socialBlock
        }
        if let qrCodesBlock = wrapper.qrCodesBlock {
            qrCodesBlock.isMainBlock = true
            if hasAdditionalBlock {
                qrCodesBlock.position = 6
            } else {
                qrCodesBlock.position = 10
            }
            wrapper.qrCodesBlock = qrCodesBlock
        }
        return wrapper
    }
    
    static func getWrapperPagesCount (wrapper: CVEntityWrapper) -> Int {
        var pages = 0
        if let profileDescBlock = wrapper.profileDescBlock, profileDescBlock.page > pages {
            pages = profileDescBlock.page
        }
        if let contactBlock = wrapper.contactBlock, contactBlock.page > pages {
            pages = contactBlock.page
        }
        if let educationBlock = wrapper.educationBlock, educationBlock.page > pages {
            pages = educationBlock.page
        }
        if let workBlock = wrapper.workBlock, workBlock.page > pages {
            pages = workBlock.page
        }
        if let skillsBlock = wrapper.skillsBlock, skillsBlock.page > pages {
            pages = skillsBlock.page
        }
        if let languagesBlock = wrapper.languagesBlock, languagesBlock.page > pages {
            pages = languagesBlock.page
        }
        if let interestsBlock = wrapper.interestsBlock, interestsBlock.page > pages {
            pages = interestsBlock.page
        }
        if let certificatesBlock = wrapper.certificatesBlock, certificatesBlock.page > pages {
            pages = certificatesBlock.page
        }
        if let referencesBlock = wrapper.referencesBlock, referencesBlock.page > pages {
            pages = referencesBlock.page
        }
        if let socialBlock = wrapper.socialBlock, socialBlock.page > pages {
            pages = socialBlock.page
        }
        if let qrCodesBlock = wrapper.qrCodesBlock, qrCodesBlock.page > pages {
            pages = qrCodesBlock.page
        }
        return pages + 1
    }
}
