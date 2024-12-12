//
//  ShareViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation

class ShareViewModel: ObservableObject {
    
    var cv: CVEntity?
    
    var name = ""
    var format = -1
    var quality = 0
    
    @Published var sheetClosed = false
    
    func updateData (cv: CVEntity?) {
        self.cv = cv
        createName()
        AnalyticsManager.saveEvent(event: Events.SHARE_OPENED)
    }
    
    private func createName () {
        if let cv {
            name = cv.name
        }
    }
    
    func saveName () {
        if let cv {
            cv.name = name
            DatabaseBox.saveContext()
        }
    }
    
    func closeSheet () {
        sheetClosed = true
    }
}
