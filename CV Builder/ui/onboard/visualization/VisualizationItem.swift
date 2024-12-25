//
//  VisualizationItem.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.12.2024.
//

import Foundation

class VisualizationItem {
    
    var id: Int
    var wrapper: CVEntityWrapper
    var name: String
    var icon: String
    var isSelected: Bool
    
    init(id: Int, wrapper: CVEntityWrapper, name: String, icon: String, isSelected: Bool) {
        self.id = id
        self.wrapper = wrapper
        self.name = name
        self.icon = icon
        self.isSelected = isSelected
    }
    
    static func getDefault () -> VisualizationItem {
        return VisualizationItem(id: 0, wrapper: CVEntityWrapper.getDefault(), name: "Item", icon: "briefcase.fill", isSelected: true)
    }
    
//    var id: Int
//    var wrapper: CVEntityWrapper
//    
//    var isSelected = false
//    
//    init(wrapper: CVEntityWrapper, isSelected: Bool = false) {
//        self.id = wrapper.id
//        self.wrapper = wrapper
//        self.isSelected = isSelected
//    }
//    
//    static func == (lhs: VisualizationItem, rhs: VisualizationItem) -> Bool {
//        return lhs.wrapper.id == rhs.wrapper.id && lhs.wrapper.wrapperName == rhs.wrapper.wrapperName
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(wrapper.id)
//        hasher.combine(wrapper.wrapperName)
//    }
//    
//    static func getDefault () -> VisualizationItem {
//        return VisualizationItem(wrapper: CVEntityWrapper.getDefault(), isSelected: false)
//    }
}
