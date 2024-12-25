//
//  EducationFieldsInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct EducationFieldsInputView: View {
    
    @Binding var list: [EducationItem]
    var addingClickHandler: (_ education: EducationEntity?) -> Void
    var deleteClickHandler: (_ education: EducationEntity?, _ index: Int) -> Void
    var dropEndHandler: () -> Void
    
    @State private var actionsSheetShown = false
    
    @State private var draggedItem: EducationItem?
    @State var actionItemIndex = -1
    
    var body: some View {
        VStack {
            
            if list.count > 0 {
                
                ActionButtonView(icon: "plus", text: NSLocalizedString("add_education", comment: ""), clickHandler: {
                    
                    addingClickHandler(nil)
                    
                }, addArrow: true).padding(.bottom, 8)
                
                ScrollView (showsIndicators: false) {
                    VStack {
                        ForEach(list.indices, id: \.self) { index in
                            EducationItemView(education: $list[index], clickHandler: {
                                addingClickHandler(list[index].entity)
                            }, actionsHandler: {
                                actionsSheetShown = true
                                actionItemIndex = index
                            }).onDrag {
                                self.draggedItem = list[index]
                                return NSItemProvider()
                            }.onDrop(of: [.text], delegate: EducationDropDelegate(destinationItem: list[index], list: $list, draggedItem: $draggedItem, dropEndHandler: dropEndHandler))
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
                EmptyInputListView(icon: "graduationcap.fill", header: NSLocalizedString("empty_education_header", comment: ""), description: NSLocalizedString("empty_education_description", comment: ""), buttonOneName: NSLocalizedString("add_education", comment: ""), buttonOneIcon: "plus", buttonOneHandler: {
                    addingClickHandler(nil)
                })
            }
            
        }.padding()
    }
}

#Preview {
    EducationFieldsInputView(list: .constant([]), addingClickHandler: { ed in }, deleteClickHandler: { ed, i in }, dropEndHandler: {})
}
