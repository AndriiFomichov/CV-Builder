//
//  OnBoardViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation

class OnBoardViewModel: ObservableObject {
    
    @Published var sheetClosed = false
    
    let profileManager = ProfileManager()
    
    var profile: ProfileEntity?
    var style = 0
    var cv: CVEntity?
    var jobTitle = ""
    var company = ""
    
    func createProfile () {
        if profile == nil {
            profile = profileManager.createProfile()
        }
    }
    
    func saveStyle (id: Int) {
        style = id
    }
    
    func saveTargetJob (jobTitle: String, company: String) {
        self.jobTitle = jobTitle
        self.company = company
    }
    
    func saveCv (entity: CVEntity) {
        cv = entity
    }
    
    func closeSheet () {
        DispatchQueue.main.async {
            self.sheetClosed = true
        }
    }
}
