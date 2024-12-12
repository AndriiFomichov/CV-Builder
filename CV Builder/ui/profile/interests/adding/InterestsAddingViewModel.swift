//
//  InterestsAddingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class InterestsAddingViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    
    var profile: ProfileEntity?
    
    @Published var text = ""
    @Published var listOne: [Interest] = []
    @Published var listTwo: [Interest] = []
    @Published var listThree: [Interest] = []
    @Published var listFour: [Interest] = []
    @Published var listFive: [Interest] = []
    @Published var listSix: [Interest] = []
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateInterestList()
    }
    
    private func updateInterestList () {
        listOne = PreloadedDatabase.getInterestsOne()
        listTwo = PreloadedDatabase.getInterestsTwo()
        listThree = PreloadedDatabase.getInterestsThree()
        listFour = PreloadedDatabase.getInterestsFour()
        listFive = PreloadedDatabase.getInterestsFive()
        listSix = PreloadedDatabase.getInterestsSix()
    }
    
    func selectInterestOne (index: Int) {
        let item = listOne[index]
        item.isSelected.toggle()
        listOne[index] = item
    }
    
    func selectInterestTwo (index: Int) {
        let item = listTwo[index]
        item.isSelected.toggle()
        listTwo[index] = item
    }
    
    func selectInterestThree (index: Int) {
        let item = listThree[index]
        item.isSelected.toggle()
        listThree[index] = item
    }
    
    func selectInterestFour (index: Int) {
        let item = listFour[index]
        item.isSelected.toggle()
        listFour[index] = item
    }
    
    func selectInterestFive (index: Int) {
        let item = listFive[index]
        item.isSelected.toggle()
        listFive[index] = item
    }
    
    func selectInterestSix (index: Int) {
        let item = listSix[index]
        item.isSelected.toggle()
        listSix[index] = item
    }
    
    func save () {
        if let profile {
            if !text.isEmpty {
                let items = text.components(separatedBy: ", ")
                if items.count > 0 {
                    for item in items {
                        profileManager.saveInterest(profile: profile, name: item)
                    }
                }
            }
            for item in listOne {
                if item.isSelected {
                    profileManager.saveInterest(profile: profile, name: item.name)
                }
            }
            for item in listTwo {
                if item.isSelected {
                    profileManager.saveInterest(profile: profile, name: item.name)
                }
            }
            for item in listThree {
                if item.isSelected {
                    profileManager.saveInterest(profile: profile, name: item.name)
                }
            }
            for item in listFour {
                if item.isSelected {
                    profileManager.saveInterest(profile: profile, name: item.name)
                }
            }
            for item in listFive {
                if item.isSelected {
                    profileManager.saveInterest(profile: profile, name: item.name)
                }
            }
            for item in listSix {
                if item.isSelected {
                    profileManager.saveInterest(profile: profile, name: item.name)
                }
            }
        }
        dismissed = true
    }
    
    
}
