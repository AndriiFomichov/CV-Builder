//
//  SkillsCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct SkillsCategoryView: View, KeyboardReadable {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = SkillsCategoryViewModel()
    
    @State var isCollapsed = false
    @State private var actionsSheetShown = false
    
    @State var actionItemIndex = -1
    @State var actionItemCategory = -1
    
    @State private var draggedSoftSkill: SkillsItem?
    @State private var draggedHardSkill: SkillsItem?
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("skills_input_header", comment: "")), description: .constant(NSLocalizedString("skills_input_description", comment: "")), isCollapsed: $isCollapsed)

                VStack {
                    
                    if viewModel.softSkillsList.count == 0 && viewModel.hardSkillsList.count == 0 {
                        
                        EmptyInputListView(icon: "lightbulb.max.fill", header: NSLocalizedString("empty_skills_header", comment: ""), description: NSLocalizedString("empty_skills_description", comment: ""), buttonOneName: NSLocalizedString("add_soft_skill", comment: ""), buttonOneIcon: "plus", buttonOneHandler: {
                            withAnimation {
                                viewModel.addSkill(category: 0)
                            }
                        }, buttonTwoName: NSLocalizedString("add_hard_skill", comment: ""), buttonTwoIcon: "plus", buttonTwoHandler: {
                            withAnimation {
                                viewModel.addSkill(category: 1)
                            }
                        }).padding()
                        
                    } else {
                        
                        HStack {
                            
                            ActionButtonView(icon: "plus", text: NSLocalizedString("add_soft_skill", comment: ""), clickHandler: {
                                withAnimation {
                                    viewModel.addSkill(category: 0)
                                }
                            }, addArrow: true)
                            
                            ActionButtonView(icon: "plus", text: NSLocalizedString("add_hard_skill", comment: ""), clickHandler: {
                                withAnimation {
                                    viewModel.addSkill(category: 1)
                                }
                            }, addArrow: true)
                            
                        }.padding([.leading, .top, .trailing])
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                if viewModel.softSkillsList.count > 0 {
                                    Text(NSLocalizedString("soft_skills", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    ForEach(viewModel.softSkillsList.indices, id: \.self) { index in
                                        SkillsItemView(item: $viewModel.softSkillsList[index], actionsHandler: {
                                            actionsSheetShown = true
                                            actionItemIndex = index
                                            actionItemCategory = 0
                                        }, selectionHandler: { photos in
                                            viewModel.handleIconSelection(index: index, item: viewModel.softSkillsList[index], selectedPhotos: photos)
                                        }).onDrag {
                                            self.draggedSoftSkill = viewModel.softSkillsList[index]
                                            return NSItemProvider()
                                        }.onDrop(of: [.text], delegate: SkillsDropDelegate(destinationItem: viewModel.softSkillsList[index], skills: $viewModel.softSkillsList, draggedItem: $draggedSoftSkill, dropEndHandler: {
                                            viewModel.handleSoftSkillMoved()
                                        }))
                                    }
                                }
                               
                                if viewModel.hardSkillsList.count > 0 {
                                    Text(NSLocalizedString("hard_skills", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.top)
                                    
                                    ForEach(viewModel.hardSkillsList.indices, id: \.self) { index in
                                        SkillsItemView(item: $viewModel.hardSkillsList[index], actionsHandler: {
                                            actionsSheetShown = true
                                            actionItemIndex = index
                                            actionItemCategory = 1
                                        }, selectionHandler: { photos in
                                            viewModel.handleIconSelection(index: index, item: viewModel.hardSkillsList[index], selectedPhotos: photos)
                                        }).onDrag {
                                            self.draggedHardSkill = viewModel.hardSkillsList[index]
                                            return NSItemProvider()
                                        }.onDrop(of: [.text], delegate: SkillsDropDelegate(destinationItem: viewModel.hardSkillsList[index], skills: $viewModel.hardSkillsList, draggedItem: $draggedHardSkill, dropEndHandler: {
                                            viewModel.handleHardSkillMoved()
                                        }))
                                    }
                                }
                            }.padding()
                            
                        }.confirmationDialog(NSLocalizedString("edit", comment: ""), isPresented: $actionsSheetShown) {
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                                withAnimation {
                                    viewModel.deleteSkill(index: actionItemIndex, category: actionItemCategory)
                                }
                            }
                        }
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                if isCollapsed {
                    KeyboardActionsView(clearHanlder: {
                        self.endEditing()
                    }, doneHanlder: {
                        self.endEditing()
                    })
                } else {
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                        viewModel.save()
                        presentationMode.wrappedValue.dismiss()
                    }).padding(.vertical)
                }
            }
            
        }.navigationTitle(isCollapsed ? NSLocalizedString("skills_input_header", comment: "") : "").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.addSkill(category: 0)
                    }
                }) {
                    Image(systemName: "plus").foregroundColor(Color.accent)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showGuide()
                }) {
                    Image(systemName: "info.circle").foregroundColor(Color.accent)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(clickHandler: {
                    viewModel.save()
                    presentationMode.wrappedValue.dismiss()
                }, text: NSLocalizedString("profile", comment: ""))
            }
            
        }.sheet(isPresented: $viewModel.guideSheetShown) {
            GuideView(guideId: 5).presentationDetents([.large])
        }.onAppear() {
            viewModel.updateData(profile: profile)
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                isCollapsed = newIsKeyboardVisible
            }
        }
    }
}

#Preview {
    SkillsCategoryView(profile: nil)
}
