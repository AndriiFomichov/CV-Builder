//
//  ReferencesCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class ReferencesCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var referencesList: [ReferenceItem] = []
    @Published var selectedReference: ReferenceEntity?
    @Published var referenceAddingSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateList()
    }
    
    func updateList () {
        var list: [ReferenceItem] = []
        
        if let profile, let referencesList = profile.referencesList {
            for ref in referencesList {
                list.append(ReferenceItem(entity: ref))
            }
        }
        
        referencesList = list.sorted(by: { $0.position < $1.position })
    }
    
    func deleteReference (index: Int) {
        if let profile, index != -1 {
            let ref = referencesList[index]
            profileManager.deleteReference(profile: profile, reference: ref.entity)
            referencesList.remove(at: index)
        }
    }
    
    func handleItemsMoved () {
        if referencesList.count > 1 {
            for i in 0..<referencesList.count {
                let item = referencesList[i]
                item.position = i
                referencesList[i] = item
                
                item.entity.position = item.position
            }
            DatabaseBox.saveContext()
        }
    }
    
    func showReferenceAdding (reference: ReferenceEntity?) {
        selectedReference = reference
        referenceAddingSheetShown = true
    }
}
