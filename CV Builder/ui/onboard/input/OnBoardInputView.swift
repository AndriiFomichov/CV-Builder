//
//  OnBoardInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct OnBoardInputView: View, KeyboardReadable {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var parentViewModel: OnBoardViewModel
    @StateObject var viewModel = OnBoardInputViewModel()
    
    @State var step = 0
    @State var isCollapsed = false
    
    @State var selectedEducation: EducationEntity?
    @State var educationAddingSheetShown = false
    
    @State var selectedWork: WorkEntity?
    @State var workAddingSheetShown = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: $viewModel.header, description: $viewModel.description, progress: $viewModel.progress, isLoading: .constant(false), isCollapsed: $isCollapsed, lineIllustration: "small_line_four_illustration", progressShown: true)

                VStack {
                    
                    if step == 0 {
                        
                        GeneralFieldsInputView(name: $viewModel.name, location: .constant(""), job: $viewModel.job, description: .constant(""), allFields: false)
                        
                    } else if step == 1 {
                        
                        PhotoFieldsInputView(imageId: $viewModel.photoId, preview: $viewModel.preview, previewBackgroundRemoveAvailable: $viewModel.previewBackgroundRemoveAvailable, photoSelectionHandler: { id in
                            viewModel.handlePhotoSelection(id: id)
                        })
                        
                    } else if step == 2 {
                        
                        EducationFieldsInputView(list: $viewModel.educationList, addingClickHandler: { education in
                            selectedEducation = education
                            educationAddingSheetShown = true
                        }, deleteClickHandler: { education, index in
                            withAnimation {
                                viewModel.deleteEducation(education: education, index: index)
                            }
                        }, dropEndHandler: {
                            viewModel.handleEducationItemsMoved()
                        }).sheet(isPresented: $educationAddingSheetShown, onDismiss: {
                            withAnimation {
                                viewModel.updateEducationList()
                            }
                        }) {
                            EducationAddingView(profile: viewModel.profile, entity: selectedEducation).presentationDetents([.large])
                        }
                        
                    } else if step == 3 {
                        
                        WorkFieldsInputView(list: $viewModel.workList, addingClickHandler: { work in
                            selectedWork = work
                            workAddingSheetShown = true
                        }, deleteClickHandler: { work, index in
                            withAnimation {
                                viewModel.deleteWork(work: work, index: index)
                            }
                        }, dropEndHandler: {
                            viewModel.handleWorkItemsMoved()
                        }).sheet(isPresented: $workAddingSheetShown, onDismiss: {
                            withAnimation {
                                viewModel.updateWorkList()
                            }
                        }) {
                            WorkAddingView(profile: viewModel.profile, entity: selectedWork).presentationDetents([.large])
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
                    VStack {
                        
                        StepView(currentStep: $step).padding(.top).padding(.bottom, 8)
                        
                        MainButtonView(isSelected: .constant(true), text: NSLocalizedString("continue", comment: ""), clickHandler: {
                            viewModel.nextStep()
                            self.endEditing()
                        }).padding(.bottom)
                        
                    }
                }
            }
            
        }.navigationTitle(isCollapsed ? viewModel.header : "").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {
            
            if viewModel.step == 2 || viewModel.step == 3 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if viewModel.step == 2 {
                            educationAddingSheetShown = true
                        } else if viewModel.step == 3 {
                            workAddingSheetShown = true
                        }
                    }) {
                        Image(systemName: "plus").foregroundColor(Color.accent)
                    }
                }
            }
            
            if viewModel.step != 1 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showGuideSheet()
                    }) {
                        Image(systemName: "info.circle").foregroundColor(Color.accent)
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(clickHandler: {
                    viewModel.backStep()
                    self.endEditing()
                })
            }
            
        }.navigationDestination(isPresented: $viewModel.nextStepPresented) {
            OnBoardTargetView()
        }.sheet(isPresented: $viewModel.guideSheetPresented) {
            GuideView(guideId: viewModel.guideId).presentationDetents([.large])
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onChange(of: viewModel.step) {
            withAnimation {
                step = viewModel.step
            }
        }.onChange(of: viewModel.previousStepPresented) {
            presentationMode.wrappedValue.dismiss()
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
//            if UIDevice.current.userInterfaceIdiom == .phone {
//
//            }
            withAnimation {
                isCollapsed = newIsKeyboardVisible
            }
        }
    }
}

#Preview {
    OnBoardInputView().environmentObject(OnBoardViewModel())
}
