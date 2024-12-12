//
//  EducationCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation

class EducationCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var educationList: [EducationItem] = []
    @Published var selectedEducation: EducationEntity?
    @Published var educationAddingSheetShown = false
    
    @Published var guideSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateEducationList()
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
    
    func handleItemsMoved () {
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
    
    func showEducationAdding (education: EducationEntity?) {
        selectedEducation = education
        educationAddingSheetShown = true
    }
    
    func showGuide () {
        guideSheetShown = true
    }
}
