//
//  ContentSelectionDropDelegate.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import SwiftUI

struct ContentSelectionDropDelegate: DropDelegate {
    
    let destinationIsMainBlock: Bool
    let destinationItem: ContentBlock?
    @Binding var listOne: [ContentBlock]
    @Binding var listTwo: [ContentBlock]
    @Binding var draggedItem: ContentBlock?
    
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
            
            if draggedItem.isMainBlock != destinationIsMainBlock {
                
                // insert
                
                if destinationIsMainBlock {
                    
                    insertItemInsideMainList()
                    
                } else {
                    
                    
                    insertItemInsideAdditionalList()
                    
                }
                
                
                
                
                
            } else {
                
                // move
                
                if destinationIsMainBlock {
                    moveItemInsideMainList()
                } else {
                    moveItemInsideAdditionalList()
                }
            }
        }
    }
    
    private func moveItemInsideMainList () {
        let fromIndex = getIndexOfItem(items: listOne, item: draggedItem)
        if let fromIndex {
            let toIndex = getIndexOfItem(items: listOne, item: destinationItem)
            if let toIndex, fromIndex != toIndex {
                withAnimation {
                    self.listOne.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                }
                dropEndHandler()
            }
        }
    }
    
    private func moveItemInsideAdditionalList () {
        let fromIndex = getIndexOfItem(items: listTwo, item: draggedItem)
        if let fromIndex {
            let toIndex = getIndexOfItem(items: listTwo, item: destinationItem)
            if let toIndex, fromIndex != toIndex {
                withAnimation {
                    self.listTwo.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                }
                dropEndHandler()
            }
        }
    }
    
    private func insertItemInsideMainList () {
        if let draggedItem {
            if let destinationItem {
                if let toIndex = getIndexOfItem(items: listOne, item: destinationItem) {
                    withAnimation {
                        self.listOne.insert(draggedItem, at: toIndex)
                        self.listTwo.removeAll { $0.blockId == draggedItem.blockId }
                    }
                    dropEndHandler()
                }
            } else {
                withAnimation {
                    self.listOne.append(draggedItem)
                    self.listTwo.removeAll { $0.blockId == draggedItem.blockId }
                }
                dropEndHandler()
            }
        }
    }
    
    private func insertItemInsideAdditionalList () {
        if let draggedItem {
            if let destinationItem {
                if let toIndex = getIndexOfItem(items: listOne, item: destinationItem) {
                    withAnimation {
                        self.listTwo.insert(draggedItem, at: toIndex)
                        self.listOne.removeAll { $0.blockId == draggedItem.blockId }
                    }
                    dropEndHandler()
                }
            } else {
                withAnimation {
                    self.listTwo.append(draggedItem)
                    self.listOne.removeAll { $0.blockId == draggedItem.blockId }
                }
                dropEndHandler()
            }
        }
    }
    
    func dropExited(info: DropInfo) {
        dropEndHandler()
    }
    
    private func getIndexOfItem (items: [ContentBlock], item: ContentBlock?) -> Int? {
        if let item {
            for i in 0..<items.count {
                let s = items[i]
                if s.position == item.position {
                    return i
                }
            }
        }
        return nil
    }
}
