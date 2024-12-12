//
//  WorkAddingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import Foundation
import UIKit
import PhotosUI
import _PhotosUI_SwiftUI

class WorkAddingViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    
    var profile: ProfileEntity?
    var entity: WorkEntity?
    
    @Published var jobTitle = ""
    @Published var company = ""
    @Published var iconId = -1
    @Published var icon: UIImage?
    @Published var location = ""
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var isStillWorking = false
    @Published var responsibilities = ""
    @Published var remote = false
    @Published var partTime = false
    
    @Published var deleteVisible = false
    @Published var btnMainText = ""
    
    @Published var deleteAlertShown = false
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?, entity: WorkEntity?) {
        self.profile = profile
        self.entity = entity
        getData()
    }
    
    private func getData () {
        if let entity {
            jobTitle = entity.jobTitle
            company = entity.company
            iconId = entity.iconId
            location = entity.location
            startDate = entity.startDate
            endDate = entity.endDate
            isStillWorking = entity.isStillWorking
            responsibilities = entity.responsibilities
            remote = entity.remote
            partTime = entity.partTime
            
            if iconId != -1 {
                Task {
                    await loadLogo()
                }
            }
            
            deleteVisible = true
            btnMainText = NSLocalizedString("save", comment: "")
        } else {
            deleteVisible = false
            btnMainText = NSLocalizedString("add", comment: "")
        }
    }
    
    @MainActor
    private func loadLogo () async {
        if iconId != -1, let image = DatabaseBox.getImage(id: iconId), let data = image.image, let uiImage = UIImage(data: data) {
            icon = await uiImage.resizeAsync(height: 150)
        }
    }
    
    func handleImageSelection (selectedPhotos: [PhotosPickerItem]) {
        Task {
            await performImageSaving(selectedPhotos: selectedPhotos)
        }
    }
    
    @MainActor
    private func performImageSaving (selectedPhotos: [PhotosPickerItem]) async {
        if !selectedPhotos.isEmpty && selectedPhotos.count >= 1 {
            let photo = selectedPhotos[0]

            if let imageData = try? await photo.loadTransferable(type: Data.self) {
                
                profileManager.deleteImage(id: iconId)
                
                iconId = await profileManager.savePhoto(image: imageData)
                
                await loadLogo()
            }
        }
    }
    
    func saveDate (dateType: Int, date: Date?) {
        if dateType == 0 {
            startDate = date
        } else if dateType == 1 {
            endDate = date
        }
    }
    
    func save () {
        if let profile, (!jobTitle.isEmpty || !company.isEmpty || !location.isEmpty || !responsibilities.isEmpty) {
            if let entity {
                profileManager.updateWork(work: entity, jobTitle: jobTitle, company: company, iconId: iconId, location: location, start: startDate, end: endDate, isStillWorking: isStillWorking, responsibilities: responsibilities, remote: remote, partTime: partTime, position: entity.position)
            } else {
                profileManager.saveWorkExperience(profile: profile, jobTitle: jobTitle, company: company, iconId: iconId, location: location, start: startDate, end: endDate, isStillWorking: isStillWorking, responsibilities: responsibilities, remote: remote, partTime: partTime)
            }
        }
        dismissed = true
    }
    
    func delete () {
        deleteAlertShown = true
    }
    
    func performDelete () {
        if let profile, let entity {
            profileManager.deleteWork(profile: profile, work: entity)
            dismissed = true
        }
    }
}
