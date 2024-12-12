//
//  ContentItemDropDelegate.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import SwiftUI

struct ContentItemDropDelegate: DropDelegate {
    
    let destinationItem: ContentItem?
    @Binding var list: [ContentItem]
    @Binding var draggedItem: ContentItem?
    
    let dropEndHandler: () -> Void
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem, let destinationItem {
            let fromIndex = getIndexOfItem(item: draggedItem)
            if let fromIndex {
                let toIndex = getIndexOfItem(item: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    if draggedItem.blockId == destinationItem.blockId {
                        withAnimation {
                            self.list.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                        }
                        dropEndHandler()
                    }
                }
            }
        }
    }
    
    func dropExited(info: DropInfo) {
        dropEndHandler()
    }
    
    private func getIndexOfItem (item: ContentItem?) -> Int? {
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
