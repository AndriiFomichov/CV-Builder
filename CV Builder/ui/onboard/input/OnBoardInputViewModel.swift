//
//  OnBoardInputViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation
import UIKit

class OnBoardInputViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var header = ""
    @Published var description = ""
    @Published var step = 0
    @Published var progress: CGFloat = 0.0
    
    @Published var name = ""
    @Published var job = ""
    
    @Published var photoId = -1
    @Published var preview: UIImage?
    @Published var previewBackgroundRemoveAvailable = false
    
    @Published var educationList: [EducationItem] = []
    
    @Published var workList: [WorkItem] = []
    
    var guideId = 0
    @Published var guideSheetPresented = false
    
    @Published var previousStepPresented = false
    @Published var nextStepPresented = false
    
    var parentViewModel: OnBoardViewModel?
    
    func updateData (parentViewModel: OnBoardViewModel) {
        self.parentViewModel = parentViewModel
        self.profile = parentViewModel.profile
        updateStep()
    }
    
    private func updateStep () {
        if step == 0 {
            updateGeneralState()
        } else if step == 1 {
            updatePhotoState()
        } else if step == 2 {
            updateEducationState()
        } else if step == 3 {
            updateWorkState()
        }
    }
    
    
    // General
    
    private func updateGeneralState () {
        header = NSLocalizedString("create_profile_header", comment: "")
        description = NSLocalizedString("create_profile_description", comment: "")
        progress = 0.25
        if let profile {
            name = profile.name
            job = profile.jobTitle
        }
        AnalyticsManager.saveEvent(event: Events.ONBOARD_GENERAL_OPENED)
    }
    
    
    // Photo
    
    private func updatePhotoState () {
        header = NSLocalizedString("add_photo_header", comment: "")
        description = NSLocalizedString("add_photo_description", comment: "")
        progress = 0.5
        if let profile {
            photoId = profile.photoId
        }
        Task {
            await loadImage()
        }
        AnalyticsManager.saveEvent(event: Events.ONBOARD_PHOTO_OPENED)
    }
    
    @MainActor
    private func loadImage () async {
        if photoId != -1, let image = DatabaseBox.getImage(id: photoId), let data = image.image, let uiImage = UIImage(data: data) {
            preview = await uiImage.resizeAsync(height: 450)
            previewBackgroundRemoveAvailable = !image.isBackgroundRemoved
        } else {
            previewBackgroundRemoveAvailable = false
        }
    }
    
    func handlePhotoSelection (id: Int) {
        if id != -1 && id != photoId {
            photoId = id
            Task {
                await loadImage()
            }
        }
    }
    
    
    // Education
    
    private func updateEducationState () {
        header = NSLocalizedString("education_input_header", comment: "")
        description = NSLocalizedString("education_input_description", comment: "")
        progress = 0.75
        updateEducationList()
        AnalyticsManager.saveEvent(event: Events.ONBOARD_EDUCATION_OPENED)
    }
    
    func updateEducationList () {
        var list: [EducationItem] = []
        
        if let profile, let educationList = profile.educationsList {
            for education in educationList {
                list.append(EducationItem(entity: education))
            }
        }
        
        educationList = list.sorted(by: { $0.position < $1.position })
    }
    
    func deleteEducation (education: EducationEntity?, index: Int) {
        if let profile, let education {
            profileManager.deleteEducation(profile: profile, education: education)
            educationList.remove(at: index)
        }
    }
    
    func handleEducationItemsMoved () {
        if educationList.count > 1 {
            for i in 0..<educationList.count {
                let item = educationList[i]
                item.position = i
                educationList[i] = item
                
                item.entity.position = item.position
            }
            DatabaseBox.saveContext()
        }
    }
    
    
    // Work
    
    private func updateWorkState () {
        header = NSLocalizedString("work_input_header", comment: "")
        description = NSLocalizedString("work_input_description", comment: "")
        progress = 1.0
        updateWorkList()
        AnalyticsManager.saveEvent(event: Events.ONBOARD_WORK_OPENED)
    }
    
    func updateWorkList () {
        var list: [WorkItem] = []
        
        if let profile, let worksList = profile.worksList {
            for work in worksList {
                list.append(WorkItem(entity: work))
            }
        }
        
        workList = list.sorted(by: { $0.position < $1.position })
    }
    
    func deleteWork (work: WorkEntity?, index: Int) {
        if let profile, let work {
            profileManager.deleteWork(profile: profile, work: work)
            workList.remove(at: index)
        }
    }
    
    func handleWorkItemsMoved () {
        if workList.count > 1 {
            for i in 0..<workList.count {
                let item = workList[i]
                item.position = i
                workList[i] = item
                
                item.entity.position = item.position
            }
            DatabaseBox.saveContext()
        }
    }
    
    
    func backStep () {
        if step == 0 {
            previousStepPresented = true
        } else {
            step-=1
            updateStep()
        }
    }
    
    func nextStep () {
        if step == 3 {
            nextStepPresented = true
        } else {
            if step == 0 {
                saveGeneralData()
            } else if step == 1 {
                savePhoto()
            }
            step+=1
            updateStep()
        }
    }
    
    private func saveGeneralData () {
        if let profile {
            profile.name = name
            profile.jobTitle = job
            DatabaseBox.saveContext()
        }
    }
    
    private func savePhoto () {
        if let profile {
            profile.photoId = photoId
            DatabaseBox.saveContext()
        }
    }
    
    func showGuideSheet () {
        if step == 0 {
            guideId = 0
        } else if step == 2 {
            guideId = 1
        } else if step == 3 {
            guideId = 2
        }
        guideSheetPresented = true
    }
}
