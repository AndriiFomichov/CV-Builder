//
//  OnBoardFrontViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import Foundation

class OnBoardFrontViewModel: ObservableObject {
    
    @Published var nextStepPresented = false
    
    var parentViewModel: OnBoardViewModel?
    
    func updateData (parentViewModel: OnBoardViewModel) {
        self.parentViewModel = parentViewModel
        
        createProfile()
        
        AnalyticsManager.identifyUser()
        AnalyticsManager.saveEvent(event: Events.ONBOARD_OPENED)
    }
    
    private func createProfile () {
        if let parentViewModel {
            parentViewModel.createProfile()
        }
    }
    
    func nextStep () {
        nextStepPresented = true
    }
}
