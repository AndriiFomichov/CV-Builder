//
//  ShareFormatViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation
import SwiftUI

class ShareFormatViewModel: ObservableObject {
    
    @Published var btnMainSelected = false
    @Published var formatsList: [Format] = []
    
    @Published var nextStepPresented = false
    @Published var errorDialogShown = false
    
    var parentViewModel: ShareViewModel?
    
    func updateData (parentViewModel: ShareViewModel) {
        self.parentViewModel = parentViewModel
        updateFormatsList()
    }
    
    private func updateFormatsList () {
        var selectedFormat = -1
        if let parentViewModel {
            selectedFormat = parentViewModel.format
        }
        
        let list = PreloadedDatabase.getFormatsList()
        if selectedFormat != -1 && selectedFormat < list.count {
            list[selectedFormat].isSelected = true
        }
        
        formatsList = list
        btnMainSelected = selectedFormat != -1
    }
    
    func selectFormat (index: Int) {
        if let parentViewModel {
            let selectedOption = parentViewModel.format
            
            if index != selectedOption {
                for i in 0...formatsList.count-1 {
                    let format = formatsList[i]
                    if i == index {
                        format.isSelected = true
                    } else {
                        format.isSelected = false
                    }
                    formatsList[i] = format
                }
            }
            saveFormat(format: index)
            btnMainSelected = true
        }
    }
    
    private func saveFormat (format: Int) {
        if let parentViewModel {
            parentViewModel.format = format
        }
    }
    
    func nextStep () {
        if let parentViewModel {
            if parentViewModel.format != -1 {
                showNextStep()
            } else {
                showErrorDialog()
            }
        }
    }
    
    private func showNextStep () {
        nextStepPresented = true
    }
    
    private func showErrorDialog () {
        errorDialogShown = true
    }
}
