//
//  OnBoardTargetView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct OnBoardTargetView: View, KeyboardReadable {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var parentViewModel: OnBoardViewModel
    @StateObject var viewModel = OnBoardTargetViewModel()
    
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
                            
                            TextInputView(text: $viewModel.jobTitle, icon: "briefcase.fill", hint: NSLocalizedString("field_job_title_hint", comment: "")).padding(.bottom)
                            
                            Text(NSLocalizedString("field_company_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.company, icon: "building.columns.fill", hint: NSLocalizedString("field_company_name_hint", comment: "")).padding(.bottom)
                            
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
            
        }.navigationTitle(isCollapsed ? NSLocalizedString("target_vacancy_header", comment: "") : "").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {
            
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
            
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(clickHandler: {
                    presentationMode.wrappedValue.dismiss()
                })
            }
            
        }.navigationDestination(isPresented: $viewModel.nextStepPresented) {
            OnBoardVisualizationView()
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
            PaywallView(benefitsId: 0, source: "OnBoard CV generation").presentationDetents([.large])
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

struct TargetJobTipView: View {
    
    var backColor: Color = .window
    
    var body: some View {
        VStack (alignment: .center) {
            
            ZStack {
                
                Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 28, height: 28)
                
            }.frame(width: 54, height: 54).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(.windowColored)
            }
            
            Text(NSLocalizedString("why_important_to_optimize", comment: "")).font(.title2).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 8)
            
            HStack (alignment: .top) {
                
                GuideItemView(item: GuideItem(header: NSLocalizedString("job_specific_tip_one_header", comment: ""), description: NSLocalizedString("job_specific_tip_one_description", comment: ""), tip: NSLocalizedString("job_specific_tip_one_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: true, isHeaderLarge: true, alignment: 0, backgroundAlignment: .bottomLeading))
                
                GuideItemView(item: GuideItem(header: NSLocalizedString("job_specific_tip_two_header", comment: ""), description: NSLocalizedString("job_specific_tip_two_description", comment: ""), tip: NSLocalizedString("job_specific_tip_two_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: true, isHeaderLarge: true, alignment: 0, backgroundAlignment: .topTrailing))
                
            }
            
        }.padding().background() {
            RoundedRectangle(cornerRadius: 20.0).fill(backColor)
        }
    }
}

#Preview {
    OnBoardTargetView().environmentObject(OnBoardViewModel())
}
