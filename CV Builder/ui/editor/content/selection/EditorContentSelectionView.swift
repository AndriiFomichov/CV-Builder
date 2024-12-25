//
//  EditorContentSelectionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorContentSelectionView: View {
    
    var cv: CVEntity?
    var finishHandler: (_ isChanged: Bool) -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditorContentSelectionViewModel()
    
    @State private var draggedItem: ContentBlock?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("content_header", comment: "")), description: .constant(NSLocalizedString("content_description", comment: "")), isCollapsed: .constant(false), maxHeight: 150)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            LazyVStack {
                                
                                if viewModel.hasAdditionalBlock {
                                    Text(NSLocalizedString("main_block", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                }
                                
                                VStack {
                                    if viewModel.mainList.count > 0 {
                                        ForEach(viewModel.mainList.indices, id: \.self) { index in
                                            ContentSelectionItemView(item: $viewModel.mainList[index], clickHandler: {
                                                viewModel.handleMainItemClick(index: index)
                                            }).onDrag {
                                                if index >= 0 && index < viewModel.mainList.count {
                                                    self.draggedItem = viewModel.mainList[index]
                                                }
                                                return NSItemProvider()
                                            }.onDrop(of: [.text], delegate: ContentSelectionDropDelegate(destinationIsMainBlock: true, destinationItem: viewModel.mainList[index], listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                                viewModel.handleItemsMoved()
                                            }))
                                        }
                                    } else {
                                        EmptyBlockView(text: NSLocalizedString("drop_here_main_block", comment: "")).onDrop(of: [.text], delegate: ContentSelectionDropDelegate(destinationIsMainBlock: true, destinationItem: nil, listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                            viewModel.handleItemsMoved()
                                        }))
                                    }
                                }.padding(.bottom)
                                
                                if viewModel.hasAdditionalBlock {
                                    Text(NSLocalizedString("additional_block", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    VStack {
                                        if viewModel.additionalList.count > 0 {
                                            ForEach(viewModel.additionalList.indices, id: \.self) { index in
                                                ContentSelectionItemView(item: $viewModel.additionalList[index], clickHandler: {
                                                    viewModel.handleAdditionalItemClick(index: index)
                                                }).onDrag {
                                                    if index >= 0 && index < viewModel.additionalList.count {
                                                        self.draggedItem = viewModel.additionalList[index]
                                                    }
                                                    return NSItemProvider()
                                                }.onDrop(of: [.text], delegate: ContentSelectionDropDelegate(destinationIsMainBlock: false, destinationItem: viewModel.additionalList[index], listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                                    viewModel.handleItemsMoved()
                                                }))
                                            }
                                        } else {
                                            EmptyBlockView(text: NSLocalizedString("drop_here_additional_block", comment: "")).onDrop(of: [.text], delegate: ContentSelectionDropDelegate(destinationIsMainBlock: false, destinationItem: nil, listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                                viewModel.handleItemsMoved()
                                            }))
                                        }
                                    }.padding(.bottom)
                                }
                                
                                if let general = viewModel.generalItem {
                                    Text(NSLocalizedString("general_block_fixed_header", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    ContentSelectionItemView(item: .constant(general), clickHandler: {}).padding(.bottom)
                                }
                                
                            }.padding()
                            
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                    }.padding(.top, -24)
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                        viewModel.save()
                    }).padding(.vertical)
                }
                
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.save()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(cv: cv)
            }.onChange(of: viewModel.dismissed) {
                finishHandler(viewModel.isChanged)
                dismiss()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    EditorContentSelectionView(cv: CVEntity.getDefault(), finishHandler: { a in })
}
