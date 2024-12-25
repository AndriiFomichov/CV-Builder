//
//  EducationAddingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import Foundation
import UIKit
import PhotosUI
import _PhotosUI_SwiftUI

class EducationAddingViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    
    var profile: ProfileEntity?
    var entity: EducationEntity?
    
    @Published var level = ""
    @Published var institution = ""
    @Published var logoId = -1
    @Published var logo: UIImage?
    @Published var field = ""
    @Published var degree = ""
    @Published var gpa = ""
    @Published var coursework = ""
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var isStillLearning = false
    
    @Published var deleteVisible = false
    @Published var btnMainText = ""
    
    @Published var datePickerSheetShown = false
    @Published var deleteAlertShown = false
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?, entity: EducationEntity?) {
        self.profile = profile
        self.entity = entity
        getData()
    }
    
    private func getData () {
        if let entity {
            level = entity.level
            institution = entity.institution
            logoId = entity.logoId
            field = entity.fieldOfStudy
            degree = entity.degree
            gpa = entity.gpa
            coursework = entity.coursework
            startDate = entity.startDate
            endDate = entity.endDate
            isStillLearning = entity.isStillLearning
            
            if logoId != -1 {
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
        if logoId != -1, let image = DatabaseBox.getImage(id: logoId), let data = image.image, let uiImage = UIImage(data: data) {
            logo = await uiImage.resizeAsync(height: 150)
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
                
                profileManager.deleteImage(id: logoId)
                
                logoId = await profileManager.savePhoto(image: imageData)
                
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
        if let profile, (!level.isEmpty || !institution.isEmpty || !field.isEmpty || !degree.isEmpty) {
            if let entity {
                profileManager.updateEducation(education: entity, level: level, institution: institution, logoId: logoId, field: field, start: startDate, end: endDate, degree: degree, isStillLearning: isStillLearning, gpa: gpa, coursework: coursework, position: entity.position)
            } else {
                profileManager.saveProfileEducation(profile: profile, level: level, institution: institution, logoId: logoId, field: field, start: startDate, end: endDate, degree: degree, isStillLearning: isStillLearning, gpa: gpa, coursework: coursework)
            }
        }
        dismissed = true
    }
    
    func showDatePicker () {
        datePickerSheetShown = true
    }
    
    func delete () {
        deleteAlertShown = true
    }
    
    func performDelete () {
        if let profile, let entity {
            profileManager.deleteEducation(profile: profile, education: entity)
            dismissed = true
        }
    }
}
