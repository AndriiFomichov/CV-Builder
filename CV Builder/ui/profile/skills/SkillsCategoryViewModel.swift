//
//  SkillsCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation
import UIKit
import PhotosUI
import _PhotosUI_SwiftUI

class SkillsCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var softSkillsList: [SkillsItem] = []
    @Published var hardSkillsList: [SkillsItem] = []
    
    @Published var guideSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        Task {
            await updateSoftSkillsList()
            await updateHardSkillsList()
        }
    }
    
    @MainActor
    private func updateSoftSkillsList () async {
        var soft: [SkillsItem] = []
        
        if let profile, let skills = profile.skillsList {
            for skill in skills {
                if skill.category == 0 {
                    soft.append(SkillsItem(entity: skill, iconPreview: nil))
                }
            }
        }
        
        softSkillsList = soft.sorted(by: { $0.position < $1.position })
    }
    
    @MainActor
    private func updateHardSkillsList () async {
        var hard: [SkillsItem] = []
        
        if let profile, let skills = profile.skillsList {
            for skill in skills {
                if skill.category == 1 {
                    var preview: UIImage?
                    if skill.iconId != -1 {
                        preview = await uploadIcon(id: skill.iconId)
                    }
                    hard.append(SkillsItem(entity: skill, iconPreview: preview))
                }
            }
        }
        
        hardSkillsList = hard.sorted(by: { $0.position < $1.position })
    }
    
    private func uploadIcon (id: Int) async -> UIImage? {
        if let icon = DatabaseBox.getImage(id: id), let data = icon.image, let uiImage = UIImage(data: data) {
            return await uiImage.resizeAsync(height: 120)
        }
        return nil
    }
    
    func addSkill (category: Int) {
        if let profile {
            let skill = profileManager.saveSkill(profile: profile, category: category)
            let item = SkillsItem(entity: skill, iconPreview: nil)
            if category == 0 {
                softSkillsList.append(item)
            } else if category == 1 {
                hardSkillsList.append(item)
            }
        }
    }
    
    func deleteSkill (index: Int, category: Int) {
        if let profile, index != -1 {
            if category == 0 {
                let skill = softSkillsList[index]
                profileManager.deleteSkill(profile: profile, skill: skill.entity)
                softSkillsList.remove(at: index)
            } else if category == 1 {
                let skill = hardSkillsList[index]
                profileManager.deleteSkill(profile: profile, skill: skill.entity)
                hardSkillsList.remove(at: index)
            }
        }
    }
    
    func handleSoftSkillMoved () {
        if softSkillsList.count > 1 {
            for i in 0..<softSkillsList.count {
                let skill = softSkillsList[i]
                skill.position = i
                softSkillsList[i] = skill
            }
        }
    }
    
    func handleHardSkillMoved () {
        if hardSkillsList.count > 1 {
            for i in 0..<hardSkillsList.count {
                let skill = hardSkillsList[i]
                skill.position = i
                hardSkillsList[i] = skill
            }
        }
    }
    
    func handleIconSelection (index: Int, item: SkillsItem, selectedPhotos: [PhotosPickerItem]) {
        Task {
            await performImageSaving(index: index, item: item, selectedPhotos: selectedPhotos)
        }
    }
    
    @MainActor
    private func performImageSaving (index: Int, item: SkillsItem, selectedPhotos: [PhotosPickerItem]) async {
        if !selectedPhotos.isEmpty && selectedPhotos.count >= 1 && index != -1 {
            let photo = selectedPhotos[0]

            if let imageData = try? await photo.loadTransferable(type: Data.self) {
                
                let iconId = await profileManager.savePhoto(image: imageData, maxSize: 450)
                
                profileManager.deleteImage(id: item.iconId)
                
                item.iconId = iconId
                item.iconPreview = await uploadIcon(id: iconId)
                
                if item.category == 0 {
                    softSkillsList[index] = item
                } else if item.category == 1 {
                    hardSkillsList[index] = item
                }
            }
        }
    }
    
    func save () {
        for item in softSkillsList {
            profileManager.updateSkill(skill: item.entity, name: item.name, level: item.level, iconId: item.iconId, category: item.category, position: item.position)
        }
        for item in hardSkillsList {
            profileManager.updateSkill(skill: item.entity, name: item.name, level: item.level, iconId: item.iconId, category: item.category, position: item.position)
        }
    }
    
    func showGuide () {
        guideSheetShown = true
    }
}
