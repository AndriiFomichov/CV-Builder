//
//  InterestsCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class InterestsCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var interestsList: [InterestItem] = []
    @Published var interestAddingSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateList()
    }
    
    func updateList () {
        var list: [InterestItem] = []
        
        if let profile, let interestsList = profile.interestsList {
            for item in interestsList {
                list.append(InterestItem(entity: item))
            }
        }
        
        interestsList = list.sorted(by: { $0.position < $1.position })
    }
    
    func deleteInterest (index: Int) {
        if let profile, index != -1 {
            let item = interestsList[index]
            profileManager.deleteInterest(profile: profile, interest: item.entity)
            interestsList.remove(at: index)
        }
    }
    
    func handleItemsMoved () {
        if interestsList.count > 1 {
            for i in 0..<interestsList.count {
                let item = interestsList[i]
                item.position = i
                interestsList[i] = item
                
                item.entity.position = item.position
            }
            DatabaseBox.saveContext()
        }
    }
    
    func showInterestAdding () {
        interestAddingSheetShown = true
    }
}
