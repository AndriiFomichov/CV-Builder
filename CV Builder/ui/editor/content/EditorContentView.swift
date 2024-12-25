//
//  EditorContentView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorContentView: View, KeyboardReadable {
    
    @EnvironmentObject var parentViewModel: EditorViewModel
    @StateObject var viewModel = EditorContentViewModel()
    
    @StateObject var monitor = NetworkMonitor()
    
    @State private var draggedItem: ContentBlock?
    @State var keywordVisible = false
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                HStack {
                    
                    BackButtonView(clickHandler: {
                        viewModel.back()
                    }).offset(x: 8)
                    
                    Spacer()
                    
                    Button (action: {
                        viewModel.openContentSelection()
                    }) {
                        Image(systemName: "plus").font(.title3).fontWeight(.regular).foregroundStyle(.accent)
                    }
                    
                }.padding()
                
                ScrollView(showsIndicators: false) {
                    
                    LazyVStack {
                        
                        HStack {
                            
                            Button (action: {
                                parentViewModel.openProfile()
                            }) {
                                HStack (spacing: 0) {
                                    
                                    ZStack {
                                        
                                        if let photo = parentViewModel.userPhoto {
                                            Image(uiImage: photo).centerCropped()
                                        } else {
                                            Image(systemName: "person.crop.circle").font(.headline).foregroundStyle(.accent)
                                        }
                                        
                                    }.clipShape(RoundedRectangle(cornerRadius: 32.0)).frame(width: 42, height: 42).background() {
                                        RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                                    }.padding(8)
                                    
                                    Text(NSLocalizedString("edit_profile", comment: "")).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4).lineLimit(2)
                                    
                                    Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                                    
                                }.frame(maxWidth: .infinity).background() {
                                    RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
                                }
                            }
                            
                            ActionButtonView(icon: "arrow.up.arrow.down", text: NSLocalizedString("rearrange_content", comment: ""), clickHandler: {
                                viewModel.openContentSelection()
                            }, addArrow: true)
                            
                        }.padding(.bottom)
                        
                        if viewModel.hasAdditionalBlock {
                            Text(NSLocalizedString("main_block", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                        }
                        
                        VStack {
                            if viewModel.mainList.count > 0 {
                                ForEach(viewModel.mainList.indices, id: \.self) { index in
                                    ContentBlockView(item: $viewModel.mainList[index], clickHandler: {
                                        viewModel.handleMainItemClick(index: index)
                                    }, textChangeHandler: {
                                        viewModel.handleItemTextChanged(item: viewModel.mainList[index])
                                    }, itemMoveHandler: {
                                        viewModel.updateAdditionalItems(item: viewModel.mainList[index])
                                    }, actionClickHandler: { position in
                                        viewModel.handleMainItemAiActionClick(index: index, action: position)
                                    }, itemTextChangeHandler: { ind in
                                        viewModel.updateAdditionalItems(item: viewModel.mainList[index])
                                    }, actionItemClickHandler: { ind, position in
                                        viewModel.handleMainItemItemAiActionClick(itemIndex: index, index: ind, action: position)
                                    }, networkStatus: $monitor.status).onDrag {
                                        if index >= 0 && index < viewModel.mainList.count {
                                            self.draggedItem = viewModel.mainList[index]
                                        }
                                        return NSItemProvider()
                                    }.onDrop(of: [.text], delegate: ContentBlockDropDelegate(destinationIsMainBlock: true, destinationItem: viewModel.mainList[index], listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                        viewModel.handleItemsMoved()
                                    }))
                                }
                            } else {
                                EmptyBlockView(text: NSLocalizedString("drop_here_main_block", comment: "")).onDrop(of: [.text], delegate: ContentBlockDropDelegate(destinationIsMainBlock: true, destinationItem: nil, listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                    viewModel.handleItemsMoved()
                                }))
                            }
                        }.padding(.bottom)
                        
                        if viewModel.hasAdditionalBlock {
                            Text(NSLocalizedString("additional_block", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            VStack {
                                if viewModel.additionalList.count > 0 {
                                    ForEach(viewModel.additionalList.indices, id: \.self) { index in
                                        ContentBlockView(item: $viewModel.additionalList[index], clickHandler: {
                                            viewModel.handleAdditionalItemClick(index: index)
                                        }, textChangeHandler: {
                                            viewModel.handleItemTextChanged(item: viewModel.additionalList[index])
                                        }, itemMoveHandler: {
                                            viewModel.updateAdditionalItems(item: viewModel.additionalList[index])
                                        }, actionClickHandler: { position in
                                            viewModel.handleAdditionalItemAiActionClick(index: index, action: position)
                                        }, itemTextChangeHandler: { ind in
                                            viewModel.updateAdditionalItems(item: viewModel.additionalList[index])
                                        }, actionItemClickHandler: { ind, position in
                                            viewModel.handleAdditionalItemItemAiActionClick(itemIndex: index, index: ind, action: position)
                                        }, networkStatus: $monitor.status).onDrag {
                                            if index >= 0 && index < viewModel.additionalList.count {
                                                self.draggedItem = viewModel.additionalList[index]
                                            }
                                            return NSItemProvider()
                                        }.onDrop(of: [.text], delegate: ContentBlockDropDelegate(destinationIsMainBlock: false, destinationItem: viewModel.additionalList[index], listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                            viewModel.handleItemsMoved()
                                        }))
                                    }
                                } else {
                                    EmptyBlockView(text: NSLocalizedString("drop_here_additional_block", comment: "")).onDrop(of: [.text], delegate: ContentBlockDropDelegate(destinationIsMainBlock: false, destinationItem: nil, listOne: $viewModel.mainList, listTwo: $viewModel.additionalList, draggedItem: $draggedItem, dropEndHandler: {
                                        viewModel.handleItemsMoved()
                                    }))
                                }
                            }.padding(.bottom)
                        }
                        
                        LargeAttemptsLabel(text: $viewModel.attemptsText).padding(.bottom, 8)
                        
                        Text(NSLocalizedString("made_with_ai_description", comment: "")).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.bottom)
                        
                    }.padding(.horizontal).padding(.bottom)
                    
                }
                
                if keywordVisible {
                    KeyboardActionsView(clearHanlder: {
                        self.endEditing()
                    }, doneHanlder: {
                        self.endEditing()
                    }).transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                }
                
            }.sheet(isPresented: $viewModel.contentSheetShown) {
                EditorContentSelectionView(cv: viewModel.cv, finishHandler: { isChanged in
                    viewModel.handleContentSelection(isChanged: isChanged)
                }).presentationDetents([.large])
            }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.handlePaywallSheetShown()
            }) {
                PaywallView(benefitsId: 0, source: "Content ai text").presentationDetents([.large])
            }.sheet(isPresented: $viewModel.limitSheetShown) {
                AiLimitView(type: 2).presentationDetents([.large])
            }
            
            if !keywordVisible {
                LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 36)
            }
            
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                keywordVisible = newIsKeyboardVisible
            }
        }
    }
}

#Preview {
    EditorContentView().environmentObject(EditorViewModel())
}
