//
//  ProfileViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import Foundation
import UIKit

class ProfileViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var photoId = -1
    @Published var photo: UIImage?
    @Published var backRemoveAvailable = false
    
    @Published var profileProgress: CGFloat = 0.0
    
    @Published var essentialList: [ProfileItem] = []
    @Published var additionalList: [ProfileItem] = []
    
    @Published var imageSelectionSheetShown = false
    @Published var backgroundRemoveSheetShown = false
    
    @Published var guideSheetAvailable = false
    @Published var guideSheetShown = false
    
    var nextStepView = -1
    @Published var nextStepPresented = false
    
    @Published var dismissed = false
    
    var firstUpdated = false
    
    func updateData () {
        if !firstUpdated {
            firstUpdated = true
            getProfile()
            Task {
                await updateProgress()
                await updatePhoto()
                await updateEssentialList()
                await updateAdditionalList()
            }
        }
    }
    
    private func getProfile () {
        profile = profileManager.getProfile()
    }
    
    @MainActor
    private func updateProgress () async {
        if let profile {
            profileProgress = profileManager.getProfileFillPercent(profile: profile)
            guideSheetAvailable = profileProgress < 1.0
        }
    }
    
    @MainActor
    private func updatePhoto () async {
        if let profile {
            photoId = profile.photoId
            await loadImage()
        }
    }
    
    @MainActor
    private func loadImage () async {
        if photoId != -1, let image = DatabaseBox.getImage(id: photoId), let data = image.image, let uiImage = UIImage(data: data) {
            photo = await uiImage.resizeAsync(height: 450)
            backRemoveAvailable = !image.isBackgroundRemoved
        } else {
            backRemoveAvailable = false
        }
    }
    
    @MainActor
    private func updateEssentialList () async {
        var list: [ProfileItem] = []
        
        if let profile {
            list.append(ProfileItem(header: NSLocalizedString("general_category_header", comment: ""), description: NSLocalizedString("general_category_description", comment: ""), icon: "person.fill", progress: profileManager.getGeneralInfoCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("education_category_header", comment: ""), description: NSLocalizedString("education_category_description", comment: ""), icon: "graduationcap.fill", progress: profileManager.getEducationCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("work_category_header", comment: ""), description: NSLocalizedString("work_category_description", comment: ""), icon: "briefcase.fill", progress: profileManager.getWorkCategoryStatus(profile: profile).progress))
        }
        
        essentialList = list
    }
    
    @MainActor
    private func updateAdditionalList () async {
        var list: [ProfileItem] = []
        
        if let profile {
            list.append(ProfileItem(header: NSLocalizedString("languages_category_header", comment: ""), description: NSLocalizedString("languages_category_description", comment: ""), icon: "globe", progress: profileManager.getLanguagesCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("skills_category_header", comment: ""), description: NSLocalizedString("skills_category_description", comment: ""), icon: "lightbulb.max.fill", progress: profileManager.getSkillsCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("interests_category_header", comment: ""), description: NSLocalizedString("interests_category_description", comment: ""), icon: "heart.circle", progress: profileManager.getInterestsCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("contact_category_header", comment: ""), description: NSLocalizedString("contact_category_description", comment: ""), icon: "paperplane.fill", progress: profileManager.getContactCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("social_category_header", comment: ""), description: NSLocalizedString("social_category_description", comment: ""), icon: "link.circle.fill", progress: profileManager.getSocialCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("certificates_category_header", comment: ""), description: NSLocalizedString("certificates_category_description", comment: ""), icon: "text.document.fill", progress: profileManager.getCertificatesCategoryStatus(profile: profile).progress))
            list.append(ProfileItem(header: NSLocalizedString("references_category_header", comment: ""), description: NSLocalizedString("references_category_description", comment: ""), icon: "star.bubble.fill", progress: profileManager.getReferencesCategoryStatus(profile: profile).progress))
        }
        
        additionalList = list
    }
    
    func showCategory (index: Int) {
        nextStepView = index
        nextStepPresented = true
    }
    
    func handleCategoryFinished () {
        Task {
            await updateProgress()
            if nextStepView < 3 {
                await updateEssentialList()
            } else {
                await updateAdditionalList()
            }
            nextStepView = -1
        }
    }
    
    func showPhotoSelection () {
        imageSelectionSheetShown = true
    }
    
    func showBackremover () {
        backgroundRemoveSheetShown = true
    }
    
    func handlePhotoSelection (id: Int) {
        if id != -1 && id != photoId {
            if let profile {
                profile.photoId = id
                DatabaseBox.saveContext()
                Task {
                    await updateProgress()
                    await updatePhoto()
                }
            }
        }
    }
    
    func showGuide () {
        guideSheetShown = true
    }
}
