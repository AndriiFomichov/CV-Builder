//
//  CVContentManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 02.12.2024.
//

import Foundation

class CVContentManager {
    
    func getGeneralDataContent (cv: CVEntity) -> ContentBlock? {
        if let generalBlock = cv.generalBlock {
            return ContentBlock(blockId: 0, name: NSLocalizedString("content_category_0", comment: ""), icon: "person.crop.circle", text: "", isTextAdded: false, items: [], position: generalBlock.position, isMainBlock: true, isAdded: true, isLoading: false)
        }
        return nil
    }
    
    func getContentList (cv: CVEntity, isMainBlock: Bool, appendInnerItems: Bool) -> [ContentBlock] {
        var list: [ContentBlock] = []
        
        if let profileDescBlock = cv.profileDescBlock, profileDescBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 1, name: NSLocalizedString("content_category_1", comment: ""), icon: "text.bubble.fill", text: profileDescBlock.profileDescription, isTextAdded: true, items: [], position: profileDescBlock.position, isMainBlock: profileDescBlock.isMainBlock, isAdded: profileDescBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let educationBlock = cv.educationBlock, educationBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 2, name: NSLocalizedString("content_category_2", comment: ""), icon: "graduationcap.fill", text: "", isTextAdded: false, items: [], position: educationBlock.position, isMainBlock: educationBlock.isMainBlock, isAdded: educationBlock.isAdded, isLoading: false)
            
            if var list = educationBlock.list, appendInnerItems {
                list = list.sorted(by: { $0.position < $1.position })
                for i in list {
                    item.items.append(ContentItem(enitityId: i.id, blockId: 2, position: i.position, header: i.institution, description: i.fieldOfStudy, text: i.desc, isLoading: false))
                }
            }
            list.append(item)
        }
        
        if let workBlock = cv.workBlock, workBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 3, name: NSLocalizedString("content_category_3", comment: ""), icon: "briefcase.fill", text: "", isTextAdded: false, items: [], position: workBlock.position, isMainBlock: workBlock.isMainBlock, isAdded: workBlock.isAdded, isLoading: false)
            
            if var list = workBlock.list, appendInnerItems {
                list = list.sorted(by: { $0.position < $1.position })
                for i in list {
                    item.items.append(ContentItem(enitityId: i.id, blockId: 3, position: i.position, header: i.company, description: i.jobTitle, text: i.desc, isLoading: false))
                }
            }
            list.append(item)
        }
        
        if let languagesBlock = cv.languagesBlock, languagesBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 4, name: NSLocalizedString("content_category_4", comment: ""), icon: "globe", text: "", isTextAdded: false, items: [], position: languagesBlock.position, isMainBlock: languagesBlock.isMainBlock, isAdded: languagesBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let skillsBlock = cv.skillsBlock, skillsBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 5, name: NSLocalizedString("content_category_5", comment: ""), icon: "lightbulb.max.fill", text: "", isTextAdded: false, items: [], position: skillsBlock.position, isMainBlock: skillsBlock.isMainBlock, isAdded: skillsBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let interestsBlock = cv.interestsBlock, interestsBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 6, name: NSLocalizedString("content_category_6", comment: ""), icon: "heart.circle", text: "", isTextAdded: false, items: [], position: interestsBlock.position, isMainBlock: interestsBlock.isMainBlock, isAdded: interestsBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let contactBlock = cv.contactBlock, contactBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 7, name: NSLocalizedString("content_category_7", comment: ""), icon: "paperplane.fill", text: "", isTextAdded: false, items: [], position: contactBlock.position, isMainBlock: contactBlock.isMainBlock, isAdded: contactBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let socialBlock = cv.socialBlock, socialBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 8, name: NSLocalizedString("content_category_8", comment: ""), icon: "text.bubble.fill", text: "", isTextAdded: false, items: [], position: socialBlock.position, isMainBlock: socialBlock.isMainBlock, isAdded: socialBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let certificatesBlock = cv.certificatesBlock, certificatesBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 9, name: NSLocalizedString("content_category_9", comment: ""), icon: "text.document.fill", text: "", isTextAdded: false, items: [], position: certificatesBlock.position, isMainBlock: certificatesBlock.isMainBlock, isAdded: certificatesBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let referencesBlock = cv.referencesBlock, referencesBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 10, name: NSLocalizedString("content_category_10", comment: ""), icon: "star.bubble.fill", text: "", isTextAdded: false, items: [], position: referencesBlock.position, isMainBlock: referencesBlock.isMainBlock, isAdded: referencesBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        if let qrCodesBlock = cv.qrCodesBlock, qrCodesBlock.isMainBlock == isMainBlock {
            let item = ContentBlock(blockId: 11, name: NSLocalizedString("content_category_11", comment: ""), icon: "qrcode", text: "", isTextAdded: false, items: [], position: qrCodesBlock.position, isMainBlock: qrCodesBlock.isMainBlock, isAdded: qrCodesBlock.isAdded, isLoading: false)
            list.append(item)
        }
        
        return list.sorted(by: { $0.position < $1.position })
    }
 
    func handleItemClick (index: Int, list: inout [ContentBlock], cv: CVEntity?) {
        if index >= 0 && index < list.count {
            let content = list[index]
            content.isAdded.toggle()
            list[index] = content
            updateBlock(cv: cv, blockId: content.blockId, position: content.position, isMainBlock: content.isMainBlock, isAdded: content.isAdded)
        }
    }
    
    func handleItemsMoved (mainList: inout [ContentBlock], additionalList: inout [ContentBlock], cv: CVEntity?) {
        for i in 0..<mainList.count {
            let item = mainList[i]
            item.position = i
            item.isMainBlock = true
            updateBlock(cv: cv, blockId: item.blockId, position: item.position, isMainBlock: item.isMainBlock, isAdded: item.isAdded)
        }
        for i in 0..<additionalList.count {
            let item = additionalList[i]
            item.position = i
            item.isMainBlock = false
            updateBlock(cv: cv, blockId: item.blockId, position: item.position, isMainBlock: item.isMainBlock, isAdded: item.isAdded)
        }
    }
    
    func updateTextWithAi (currentJob: String?, workItem: WorkBlockItemEntity?, educationItem: EducationBlockItemEntity?, targetJob: String, targetCompany: String, action: Int, text: String, isBulletedList: Bool) async -> String? {
        
        let language = TextLangDetector.getDefaultLanguage()
        
        print("Text: " + text)
        
        var prompt: String = ""
        if text.isEmpty {
            if let educationItem {
                prompt = Prompts.createEducationDescriptionPrompt(degree: educationItem.degree, level: educationItem.level, institution: educationItem.institution, targetJob: targetJob, targetCompany: targetCompany, language: language.name, isBulletedList: isBulletedList)
            } else if let workItem {
                prompt = Prompts.createWorkDescriptionPrompt(jobTitle: workItem.jobTitle, company: workItem.company, targetJob: targetJob, targetCompany: targetCompany, language: language.name, isBulletedList: isBulletedList)
            } else if let currentJob {
                prompt = Prompts.createProfileDescriptionPrompt(currentJob: currentJob, targetJob: targetJob, targetCompany: targetCompany, language: language.name)
            }
        } else {
            prompt = Prompts.createAiTextPrompt(action: action, text: text)
        }
        let responce = await TextGenerator.completeText(prompt: prompt, maxTokens: 1000, temp: TextGenerator.TEMP_MEDIUM)
        if let responce, !responce.isEmpty {
            return responce
        }
        
        return nil
    }
    
    func updateBlockItems (cv: CVEntity?, item: ContentBlock) {
        if let cv {
            if item.blockId == 2 {
                if let block = cv.educationBlock, let list = block.list {
                    for index in 0..<item.items.count {
                        let content = item.items[index]
                        content.position = index
                        for i in list {
                            if content.enitityId == i.id {
                                i.position = content.position
                                i.desc = content.text
                            }
                        }
                    }
                }
            } else if item.blockId == 3 {
                if let block = cv.workBlock, let list = block.list {
                    for index in 0..<item.items.count {
                        let content = item.items[index]
                        content.position = index
                        for i in list {
                            if content.enitityId == i.id {
                                i.position = content.position
                                i.desc = content.text
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateBlock (cv: CVEntity?, blockId: Int, position: Int, isMainBlock: Bool, isAdded: Bool) {
        if let cv {
            switch blockId {
            case 0:
                if let block = cv.generalBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 1:
                if let block = cv.profileDescBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 2:
                if let block = cv.educationBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 3:
                if let block = cv.workBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 4:
                if let block = cv.languagesBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 5:
                if let block = cv.skillsBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 6:
                if let block = cv.interestsBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 7:
                if let block = cv.contactBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 8:
                if let block = cv.socialBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 9:
                if let block = cv.certificatesBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 10:
                if let block = cv.referencesBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            case 11:
                if let block = cv.qrCodesBlock {
                    block.position = position
                    block.isMainBlock = isMainBlock
                    block.isAdded = isAdded
                }
            default:
                break
            }
        }
    }
}
