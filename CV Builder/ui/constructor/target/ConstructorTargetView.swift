//
//  ConstructorTargetView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import SwiftUI

struct ConstructorTargetView: View, KeyboardReadable {
    
    @EnvironmentObject var parentViewModel: ConstructorViewModel
    @StateObject var viewModel = ConstructorTargetViewModel()
    
    @State var isCollapsed = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("target_vacancy_header", comment: "")), description: .constant(NSLocalizedString("target_vacancy_description", comment: "")), isCollapsed: $isCollapsed)
                
                VStack {
                    
                    ScrollView (showsIndicators: false) {
                        VStack {
                            
                            Text(NSLocalizedString("field_job_title", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.jobTitle, icon: "briefcase.fill", hint: NSLocalizedString("field_job_title_hint", comment: ""), limit: 200).padding(.bottom)
                            
                            Text(NSLocalizedString("field_company_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.company, icon: "building.columns.fill", hint: NSLocalizedString("field_company_name_hint", comment: ""), limit: 200).padding(.bottom)
                            
                            Text(NSLocalizedString("field_job_description_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.description, icon: "text.page.fill", hint: NSLocalizedString("field_job_description_name_hint", comment: "")).padding(.bottom)
                            
                            TargetJobTipView()
                            
                        }.padding()
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
                    VStack (alignment: .center) {
                        
                        MainButtonView(isSelected: .constant(true), text: NSLocalizedString("generate_your_cv", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                            viewModel.nextStep()
                        })
                        
                        if viewModel.attemptsVisible {
                            AttemptsLabel(text: $viewModel.attemptsText)
                        }
                        
                    }.padding(.vertical)
                }
            }
            
        }.navigationTitle(isCollapsed ? NSLocalizedString("target_vacancy_header", comment: "") : "").navigationBarTitleDisplayMode(.inline).toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showGuideSheet()
                }) {
                    Image(systemName: "info.circle").foregroundColor(Color.accent)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(NSLocalizedString("optional", comment: "")).font(.subheadline).foregroundStyle(.accentLight).padding(6).background {
                    RoundedRectangle(cornerRadius: 32.0).fill(.window)
                }
            }
            
        }.navigationDestination(isPresented: $viewModel.nextStepPresented) {
            ConstructorVisualizationView()
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                isCollapsed = newIsKeyboardVisible
            }
        }.sheet(isPresented: $viewModel.guideSheetShown) {
            GuideView(guideId: 3).presentationDetents([.large])
        }.sheet(isPresented: $viewModel.limitSheetShown) {
            AiLimitView(type: 0).presentationDetents([.large])
        }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
            viewModel.handlePaywallSheetShown()
        }) {
            PaywallView(benefitsId: 0, source: "Constructor CV generation").presentationDetents([.large])
        }.sheet(isPresented: $viewModel.connectionSheetShown, onDismiss: {
            viewModel.startNextStep()
        }) {
            CheckConnectionView().presentationDetents([.medium])
        }.sheet(isPresented: $viewModel.profileFillAlertShown, onDismiss: {
            viewModel.checkReachibility()
        }) {
            ProfileFillAlertView().presentationDetents([.medium])
        }
    }
}

#Preview {
    ConstructorTargetView().environmentObject(ConstructorViewModel())
}
