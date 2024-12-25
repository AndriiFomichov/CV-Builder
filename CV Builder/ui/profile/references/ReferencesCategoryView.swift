//
//  ReferencesCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct ReferencesCategoryView: View {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = ReferencesCategoryViewModel()
    
    @State private var actionsSheetShown = false
    
    @State private var draggedItem: ReferenceItem?
    @State var actionItemIndex = -1
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("reference_input_header", comment: "")), description: .constant(NSLocalizedString("reference_input_description", comment: "")), isCollapsed: .constant(false))

                VStack {
                    
                    if viewModel.referencesList.count == 0 {
                        
                        EmptyInputListView(icon: "star.bubble.fill", header: NSLocalizedString("empty_reference_header", comment: ""), description: NSLocalizedString("empty_reference_description", comment: ""), buttonOneName: NSLocalizedString("add_reference", comment: ""), buttonOneIcon: "plus", buttonOneHandler: {
                            withAnimation {
                                viewModel.showReferenceAdding(reference: nil)
                            }
                        }).padding()
                        
                    } else {
                        
                        HStack {
                            
                            ActionButtonView(icon: "plus", text: NSLocalizedString("add_reference", comment: ""), clickHandler: {
                                withAnimation {
                                    viewModel.showReferenceAdding(reference: nil)
                                }
                            }, addArrow: true)
                            
                        }.padding([.leading, .top, .trailing])
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                ForEach(viewModel.referencesList.indices, id: \.self) { index in
                                    ReferenceItemView(item: $viewModel.referencesList[index], clickHandler: {
                                        viewModel.showReferenceAdding(reference: viewModel.referencesList[index].entity)
                                    }, actionsHandler: {
                                        actionsSheetShown = true
                                        actionItemIndex = index
                                    }).onDrag {
                                        self.draggedItem = viewModel.referencesList[index]
                                        return NSItemProvider()
                                    }.onDrop(of: [.text], delegate: ReferenceDropDelegate(destinationItem: viewModel.referencesList[index], list: $viewModel.referencesList, draggedItem: $draggedItem, dropEndHandler: {
                                        viewModel.handleItemsMoved()
                                    }))
                                }
                                
                            }.padding()
                            
                        }.confirmationDialog(NSLocalizedString("edit", comment: ""), isPresented: $actionsSheetShown) {
                            Button(NSLocalizedString("edit", comment: "")) {
                                if actionItemIndex != -1 {
                                    viewModel.showReferenceAdding(reference: viewModel.referencesList[actionItemIndex].entity)
                                }
                            }
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                                if actionItemIndex != -1 {
                                    viewModel.deleteReference(index: actionItemIndex)
                                }
                            }
                        }
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                    presentationMode.wrappedValue.dismiss()
                }).padding(.vertical)
                
            }.sheet(isPresented: $viewModel.referenceAddingSheetShown, onDismiss: {
                withAnimation {
                    viewModel.updateList()
                }
            }) {
                ReferenceAddingView(profile: viewModel.profile, entity: viewModel.selectedReference).presentationDetents([.large])
            }
            
        }.navigationBarTitleDisplayMode(.inline).toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showReferenceAdding(reference: nil)
                }) {
                    Image(systemName: "plus").foregroundColor(Color.accent)
                }
            }
            
        }.onAppear() {
            viewModel.updateData(profile: profile)
        }
    }
}

#Preview {
    ReferencesCategoryView(profile: nil)
}
