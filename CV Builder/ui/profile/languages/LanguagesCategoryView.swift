//
//  LanguagesCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct LanguagesCategoryView: View {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = LanguagesCategoryViewModel()
    
    @State private var actionsSheetShown = false
    
    @State var actionItemIndex = -1
    @State private var draggedItem: LanguageItem?
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("languages_input_header", comment: "")), description: .constant(NSLocalizedString("languages_input_description", comment: "")), isCollapsed: .constant(false))

                VStack {
                    
                    if viewModel.languagesList.count == 0 {
                        
                        EmptyInputListView(icon: "globe", header: NSLocalizedString("empty_languages_header", comment: ""), description: NSLocalizedString("empty_languages_description", comment: ""), buttonOneName: NSLocalizedString("add_language", comment: ""), buttonOneIcon: "plus", buttonOneHandler: {
                            withAnimation {
                                viewModel.showLanguageAdding()
                            }
                        }).padding()
                        
                    } else {
                        
                        HStack {
                            
                            ActionButtonView(icon: "plus", text: NSLocalizedString("add_language", comment: ""), clickHandler: {
                                withAnimation {
                                    viewModel.showLanguageAdding()
                                }
                            }, addArrow: true)
                            
                        }.padding([.leading, .top, .trailing])
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                ForEach(viewModel.languagesList.indices, id: \.self) { index in
                                    LanguageItemView(item: $viewModel.languagesList[index], actionsHandler: {
                                        actionsSheetShown = true
                                        actionItemIndex = index
                                    }).onDrag {
                                        self.draggedItem = viewModel.languagesList[index]
                                        return NSItemProvider()
                                    }.onDrop(of: [.text], delegate: LanguageDropDelegate(destinationItem: viewModel.languagesList[index], list: $viewModel.languagesList, draggedItem: $draggedItem, dropEndHandler: {
                                        viewModel.handleItemsMoved()
                                    }))
                                }
                                
                            }.padding()
                            
                        }.confirmationDialog(NSLocalizedString("edit", comment: ""), isPresented: $actionsSheetShown) {
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                                withAnimation {
                                    viewModel.deleteLanguage(index: actionItemIndex)
                                }
                            }
                        }
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                    viewModel.save()
                    presentationMode.wrappedValue.dismiss()
                }).padding(.vertical)
                
            }.sheet(isPresented: $viewModel.languageAddingSheetShown, onDismiss: {
                withAnimation {
                    viewModel.updateLanguagesList()
                }
            }) {
                LanguageAddingView(profile: viewModel.profile).presentationDetents([.large])
            }
            
        }.navigationTitle("").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.showLanguageAdding()
                    }
                }) {
                    Image(systemName: "plus").foregroundColor(Color.accent)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(clickHandler: {
                    viewModel.save()
                    presentationMode.wrappedValue.dismiss()
                }, text: NSLocalizedString("profile", comment: ""))
            }
            
        }.onAppear() {
            viewModel.updateData(profile: profile)
        }
    }
}

#Preview {
    LanguagesCategoryView(profile: nil)
}
