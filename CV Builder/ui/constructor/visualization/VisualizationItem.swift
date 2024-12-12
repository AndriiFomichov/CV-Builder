//
//  VisualizationItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation

class VisualizationItem: Hashable {
    
    var id: Int
    var wrapper: CVEntityWrapper
    
    var isSelected = false
    
    init(wrapper: CVEntityWrapper, isSelected: Bool = false) {
        self.id = wrapper.id
        self.wrapper = wrapper
        self.isSelected = isSelected
    }
    
    static func == (lhs: VisualizationItem, rhs: VisualizationItem) -> Bool {
        return lhs.wrapper.id == rhs.wrapper.id && lhs.wrapper.wrapperName == rhs.wrapper.wrapperName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(wrapper.id)
        hasher.combine(wrapper.wrapperName)
    }
    
    static func getDefault () -> VisualizationItem {
        return VisualizationItem(wrapper: CVEntityWrapper.getDefault(), isSelected: false)
    }
    
}
