//
//  ConstructorViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation

class ConstructorViewModel: ObservableObject {
    
    @Published var sheetClosed = false
    
    var profile: ProfileEntity?
    var style = 0
    var cv: CVEntity?
    var jobTitle = ""
    var company = ""
    var description = ""
    
    func setProfile (profile: ProfileEntity?) {
        self.profile = profile
    }
    
    func saveStyle (id: Int) {
        style = id
    }
    
    func saveTargetJob (jobTitle: String, company: String, description: String) {
        self.jobTitle = jobTitle
        self.company = company
        self.description = description
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
