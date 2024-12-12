//
//  InterestsCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct InterestsCategoryView: View {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = InterestsCategoryViewModel()
    
    @State private var actionsSheetShown = false
    
    @State var actionItemIndex = -1
    @State private var draggedItem: InterestItem?
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("interests_input_header", comment: "")), description: .constant(NSLocalizedString("interests_input_description", comment: "")), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_four_illustration")

                VStack {
                    
                    HStack {
                        
                        ActionButtonView(icon: "plus", text: NSLocalizedString("add_interest", comment: ""), clickHandler: {
                            withAnimation {
                                viewModel.showInterestAdding()
                            }
                        }, addArrow: true)
                        
                    }.padding([.leading, .top, .trailing])
                    
                    if viewModel.interestsList.count == 0 {
                        
                        EmptyInputListView(header: NSLocalizedString("empty_interests_header", comment: ""), description: NSLocalizedString("empty_interests_description", comment: "")).padding()
                        
                    } else {
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                ForEach(viewModel.interestsList.indices, id: \.self) { index in
                                    InterestItemView(item: $viewModel.interestsList[index], actionsHandler: {
                                        actionsSheetShown = true
                                        actionItemIndex = index
                                    }).onDrag {
                                        self.draggedItem = viewModel.interestsList[index]
                                        return NSItemProvider()
                                    }.onDrop(of: [.text], delegate: InterestDropDelegate(destinationItem: viewModel.interestsList[index], list: $viewModel.interestsList, draggedItem: $draggedItem, dropEndHandler: {
                                        viewModel.handleItemsMoved()
                                    }))
                                }
                                
                            }.padding()
                            
                        }.confirmationDialog(NSLocalizedString("edit", comment: ""), isPresented: $actionsSheetShown) {
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                                withAnimation {
                                    viewModel.deleteInterest(index: actionItemIndex)
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
                
            }.sheet(isPresented: $viewModel.interestAddingSheetShown, onDismiss: {
                withAnimation {
                    viewModel.updateList()
                }
            }) {
                InterestsAddingView(profile: viewModel.profile).presentationDetents([.large])
            }
            
        }.navigationTitle("").navigationBarTitleDisplayMode(.inline).toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.showInterestAdding()
                    }
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
    InterestsCategoryView(profile: nil)
}
