//
//  WorkFieldsInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct WorkFieldsInputView: View {
    
    @Binding var list: [WorkItem]
    var addingClickHandler: (_ education: WorkEntity?) -> Void
    var deleteClickHandler: (_ education: WorkEntity?, _ index: Int) -> Void
    var dropEndHandler: () -> Void
    
    @State private var actionsSheetShown = false
    
    @State private var draggedItem: WorkItem?
    @State var actionItemIndex = -1
    
    var body: some View {
        VStack {
            
            if list.count > 0 {
                
                ActionButtonView(icon: "plus", text: NSLocalizedString("add_work_experience", comment: ""), clickHandler: {
                    
                    addingClickHandler(nil)
                    
                }, addArrow: true).padding(.bottom, 8)
                
                ScrollView (showsIndicators: false) {
                    VStack {
                        ForEach(list.indices, id: \.self) { index in
                            WorkItemView(work: $list[index], clickHandler: {
                                addingClickHandler(list[index].entity)
                            }, actionsHandler: {
                                actionsSheetShown = true
                                actionItemIndex = index
                            }).onDrag {
                                self.draggedItem = list[index]
                                return NSItemProvider()
                            }.onDrop(of: [.text], delegate: WorkDropDelegate(destinationItem: list[index], list: $list, draggedItem: $draggedItem, dropEndHandler: dropEndHandler))
                        }
                    }.confirmationDialog(NSLocalizedString("edit", comment: ""), isPresented: $actionsSheetShown) {
                        Button(NSLocalizedString("edit", comment: "")) {
                            if actionItemIndex != -1 {
                                addingClickHandler(list[actionItemIndex].entity)
                            }
                        }
                        Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                            if actionItemIndex != -1 {
                                deleteClickHandler(list[actionItemIndex].entity, actionItemIndex)
                            }
                        }
                    }
                }
                
            } else {
                EmptyInputListView(icon: "briefcase.fill", header: NSLocalizedString("empty_work_header", comment: ""), description: NSLocalizedString("empty_work_description", comment: ""), buttonOneName: NSLocalizedString("add_work_experience", comment: ""), buttonOneIcon: "plus", buttonOneHandler: {
                    addingClickHandler(nil)
                })
            }
            
        }.padding()
    }
}

#Preview {
    WorkFieldsInputView(list: .constant([]), addingClickHandler: { wk in }, deleteClickHandler: { wk, i in }, dropEndHandler: {})
}
