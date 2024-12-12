//
//  ConstructorStyleViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation

class ConstructorStyleViewModel: ObservableObject {
    
    var selectedStyle = 0
    
    @Published var list: [Style] = []
    @Published var currentPage = 0
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
            selectedStyle = parentViewModel.style
        }
    }
    
    @MainActor
    private func updateList () async {
        let styles: [Style] = PreloadedDatabase.getStyles()
        
        let position = getStylePosition(id: selectedStyle, list: styles)
        if position != -1 {
            styles[position].isSelected = true
            btnMainSelected = true
            currentPage = selectedStyle
        }
        
        self.list = styles
    }
    
    func selectStyle (id: Int) {
        if id != selectedStyle {
            for i in 0...list.count-1 {
                let style = list[i]
                if i == id {
                    style.isSelected = true
                } else {
                    style.isSelected = false
                }
                list[i] = style
            }
            selectedStyle = id
        }
        saveStyle()
        btnMainSelected = true
    }
    
    func nextStep () {
        saveStyle()
        nextStepPresented = true
    }
    
    private func saveStyle () {
        if selectedStyle == -1 {
            selectedStyle = 0
        }
        if let parentViewModel {
            parentViewModel.saveStyle(id: selectedStyle)
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
