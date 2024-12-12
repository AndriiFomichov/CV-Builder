//
//  SkillsDropDelegate.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import SwiftUI

struct SkillsDropDelegate: DropDelegate {
    
    let destinationItem: SkillsItem?
    @Binding var skills: [SkillsItem]
    @Binding var draggedItem: SkillsItem?
    
    let dropEndHandler: () -> Void
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
//         Swap Items
        if let draggedItem {
            let fromIndex = getIndexOfSkill(skill: draggedItem)
            if let fromIndex {
                let toIndex = getIndexOfSkill(skill: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.skills.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                        dropEndHandler()
                }
            }
        }
    }
    
    func dropExited(info: DropInfo) {
        dropEndHandler()
    }
    
    private func getIndexOfSkill (skill: SkillsItem?) -> Int? {
        if let skill {
            for i in 0..<skills.count {
                let s = skills[i]
                if s.position == skill.position {
                    return i
                }
            }
        }
        return nil
    }
}
