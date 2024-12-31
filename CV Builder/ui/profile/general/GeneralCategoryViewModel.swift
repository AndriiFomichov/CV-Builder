//
//  GeneralCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation

class GeneralCategoryViewModel: ObservableObject {
    
    var profile: ProfileEntity?
    
    @Published var name = ""
    @Published var job = ""
    @Published var location = ""
    
    @Published var guideSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        getData()
    }
    
    private func getData () {
        if let profile {
            name = profile.name
            job = profile.jobTitle
            location = profile.location
        }
    }
    
    func showGuide () {
        guideSheetShown = true
    }
    
    func save () {
        if let profile {
            profile.name = name
            profile.jobTitle = job
            profile.location = location
            DatabaseBox.saveContext()
        }
    }
}
