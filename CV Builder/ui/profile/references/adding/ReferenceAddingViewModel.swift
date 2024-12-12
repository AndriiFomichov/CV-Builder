//
//  ReferenceAddingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class ReferenceAddingViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    
    var profile: ProfileEntity?
    var entity: ReferenceEntity?
    
    @Published var name = ""
    @Published var company = ""
    @Published var email = ""
    @Published var phone = ""
    
    @Published var deleteVisible = false
    @Published var btnMainText = ""
    
    @Published var deleteAlertShown = false
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?, entity: ReferenceEntity?) {
        self.profile = profile
        self.entity = entity
        getData()
    }
    
    private func getData () {
        if let entity {
            name = entity.referralName
            company = entity.company
            email = entity.email
            phone = entity.phone
            
            deleteVisible = true
            btnMainText = NSLocalizedString("save", comment: "")
        } else {
            deleteVisible = false
            btnMainText = NSLocalizedString("add", comment: "")
        }
    }
    
    func save () {
        if let profile, (!name.isEmpty || !company.isEmpty || !email.isEmpty || !phone.isEmpty) {
            if let entity {
                profileManager.updateReference(reference: entity, referralName: name, company: company, email: email, phone: phone, position: entity.position)
            } else {
                profileManager.saveReference(profile: profile, referralName: name, company: company, email: email, phone: phone)
            }
        }
        dismissed = true
    }
    
    func delete () {
        deleteAlertShown = true
    }
    
    func performDelete () {
        if let profile, let entity {
            profileManager.deleteReference(profile: profile, reference: entity)
            dismissed = true
        }
    }
}
