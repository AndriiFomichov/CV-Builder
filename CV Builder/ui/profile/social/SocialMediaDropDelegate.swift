//
//  SocialMediaDropDelegate.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct SocialMediaDropDelegate: DropDelegate {
    
    let destinationItem: SocialMediaItem?
    @Binding var list: [SocialMediaItem]
    @Binding var draggedItem: SocialMediaItem?
    
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
            let fromIndex = getIndexOfItem(item: draggedItem)
            if let fromIndex {
                let toIndex = getIndexOfItem(item: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.list.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                        dropEndHandler()
                }
            }
        }
    }
    
    func dropExited(info: DropInfo) {
        dropEndHandler()
    }
    
    private func getIndexOfItem (item: SocialMediaItem?) -> Int? {
        if let item {
            for i in 0..<list.count {
                let s = list[i]
                if s.position == item.position {
                    return i
                }
            }
        }
        return nil
    }
}
