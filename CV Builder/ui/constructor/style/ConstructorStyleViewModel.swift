//
//  ConstructorStyleViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation

class ConstructorStyleViewModel: ObservableObject {
    
    @Published var list: [Style] = []
    @Published var currentPage = -1
    @Published var btnMainSelected = false
    @Published var nextStepPresented = false
    
    var parentViewModel: ConstructorViewModel?
    
    func updateData (parentViewModel: ConstructorViewModel) {
        self.parentViewModel = parentViewModel
        getData()
        
        AnalyticsManager.saveEvent(event: Events.CONSTRUCTOR_STYLES_OPENED)
        
        Task {
            await updateList()
        }
    }
    
    private func getData () {
        if let parentViewModel {
            currentPage = parentViewModel.style
        }
    }
    
    @MainActor
    private func updateList () async {
        let styles: [Style] = PreloadedDatabase.getStyles()
        
        let position = getStylePosition(id: currentPage, list: styles)
        if position != -1 {
            styles[position].isSelected = true
            btnMainSelected = true
        }
        
        self.list = styles
    }
    
    func selectStyle (id: Int) {
        currentPage = id
    }
    
    func nextStep () {
        saveStyle()
        nextStepPresented = true
    }
    
    private func saveStyle () {
        if currentPage == -1 {
            currentPage = 0
        }
        if let parentViewModel {
            parentViewModel.saveStyle(id: currentPage)
        }
    }
    
    private func getStylePosition (id: Int, list: [Style]) -> Int {
        for i in 0..<list.count {
            let style = list[i]
            if style.id == id {
                return i
            }
        }
        return -1
    }
}
