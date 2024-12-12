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
        
        var list: [Format] = []
        list.append(Format(position: 0, icon: "illustration_pdf_vector", header: NSLocalizedString("format_pdf_vector_header", comment: ""), description: NSLocalizedString("format_pdf_vector_description", comment: ""), color: Color.pdf, isRecommended: true, isSelected: selectedFormat == 0))
        list.append(Format(position: 1, icon: "illustration_pdf", header: NSLocalizedString("format_pdf_header", comment: ""), description: NSLocalizedString("format_pdf_description", comment: ""), color: Color.pdf, isRecommended: false, isSelected: selectedFormat == 1))
        list.append(Format(position: 2, icon: "illustration_jpeg", header: NSLocalizedString("format_jpeg_header", comment: ""), description: NSLocalizedString("format_jpeg_description", comment: ""), color: Color.jpeg, isRecommended: false, isSelected: selectedFormat == 2))
        list.append(Format(position: 3, icon: "illustration_png", header: NSLocalizedString("format_png_header", comment: ""), description: NSLocalizedString("format_png_description", comment: ""), color: Color.png, isRecommended: false, isSelected: selectedFormat == 3))
        
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
