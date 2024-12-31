//
//  AdditionalTextViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.12.2024.
//

import Foundation

class AdditionalTextViewModel: ObservableObject {
    
    var cv: CVEntity?
    
    @Published var textsList: [AdditionalTextItem] = []
    @Published var dismissed = false
    
    var isChanged = false
    
    func updateData (cv: CVEntity?) {
        self.cv = cv
        updateList()
    }
    
    private func updateList () {
        var list: [AdditionalTextItem] = []
        
        if let cv {
            if let block = cv.coverLetter {
                list.append(AdditionalTextItem(id: 0, text: block.textCoverLetter, icon: "text.document.fill"))
            }
            
            if let block = cv.profileDescBlock {
                list.append(AdditionalTextItem(id: 1, text: block.textAboutMe, icon: "text.bubble.fill"))
            }
            
            if let block = cv.contactBlock {
                list.append(AdditionalTextItem(id: 2, text: block.textContact, icon: "paperplane.fill"))
                list.append(AdditionalTextItem(id: 3, text: block.textPhone, icon: "phone.fill"))
                list.append(AdditionalTextItem(id: 4, text: block.textEmail, icon: "envelope.fill"))
                list.append(AdditionalTextItem(id: 5, text: block.textWebsite, icon: "network"))
            }
            
            if let block = cv.educationBlock {
                list.append(AdditionalTextItem(id: 6, text: block.textEducation, icon: "graduationcap.fill"))
            }
            
            if let block = cv.workBlock {
                list.append(AdditionalTextItem(id: 7, text: block.textWorkExperience, icon: "briefcase.fill"))
            }
            
            if let block = cv.languagesBlock {
                list.append(AdditionalTextItem(id: 8, text: block.textLanguages, icon: "globe"))
            }
            
            if let block = cv.skillsBlock {
                list.append(AdditionalTextItem(id: 9, text: block.textSkills, icon: "lightbulb.max.fill"))
            }
            
            if let block = cv.interestsBlock {
                list.append(AdditionalTextItem(id: 10, text: block.textInterests, icon: "gamecontroller.fill"))
            }
            
            if let block = cv.certificatesBlock {
                list.append(AdditionalTextItem(id: 11, text: block.textCertificates, icon: "text.page.fill"))
            }
            
            if let block = cv.referencesBlock {
                list.append(AdditionalTextItem(id: 12, text: block.textReferences, icon: "star.bubble.fill"))
            }
            
            list.append(AdditionalTextItem(id: 13, text: cv.textResume, icon: "document.on.document.fill"))
            list.append(AdditionalTextItem(id: 14, text: cv.textProfile, icon: "person.crop.circle"))
            list.append(AdditionalTextItem(id: 15, text: cv.textThankYou, icon: "hand.thumbsup.fill"))
            
        }
        
        textsList = list
    }
    
    func saveTexts () {
        if let cv {
            for text in textsList {
                
                if !isChanged {
                    isChanged = text.text != text.textInitial
                }
                
                switch text.id {
                case 0:
                    if let coverLetter = cv.coverLetter {
                        coverLetter.textCoverLetter = text.text
                    }
                case 1:
                    if let block = cv.profileDescBlock {
                        block.textAboutMe = text.text
                    }
                case 2:
                    if let block = cv.contactBlock {
                        block.textContact = text.text
                    }
                case 3:
                    if let block = cv.contactBlock {
                        block.textPhone = text.text
                    }
                case 4:
                    if let block = cv.contactBlock {
                        block.textEmail = text.text
                    }
                case 5:
                    if let block = cv.contactBlock {
                        block.textWebsite = text.text
                    }
                case 6:
                    if let block = cv.educationBlock {
                        block.textEducation = text.text
                    }
                case 7:
                    if let block = cv.workBlock {
                        block.textWorkExperience = text.text
                    }
                case 8:
                    if let block = cv.languagesBlock {
                        block.textLanguages = text.text
                    }
                case 9:
                    if let block = cv.skillsBlock {
                        block.textSkills = text.text
                    }
                case 10:
                    if let block = cv.interestsBlock {
                        block.textInterests = text.text
                    }
                case 11:
                    if let block = cv.certificatesBlock {
                        block.textCertificates = text.text
                    }
                case 12:
                    if let block = cv.referencesBlock {
                        block.textReferences = text.text
                    }
                case 13:
                    cv.textResume = text.text
                case 14:
                    cv.textProfile = text.text
                case 15:
                    cv.textThankYou = text.text
                default:
                    break
                }
            }
        }
        dismissed = true
    }
}
