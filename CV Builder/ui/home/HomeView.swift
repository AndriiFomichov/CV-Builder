//
//  HomeView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    @StateObject var viewModel = HomeViewModel()
    @StateObject var consentManager = ConsentManager()
    
    private let formViewControllerRepresentable = CV_BuilderApp.FormViewControllerRepresentable()
    
    var body: some View {
        SideBarStack(sidebarWidth: UIScreen.main.bounds.size.width * 0.85, show: $viewModel.sideMenuShown, sidebar: {
            SideMenuView(userName: $viewModel.userName, userPhoto: $viewModel.userPhoto, userProfileFill: $viewModel.userFill, isPremium: $viewModel.isPremium)
        }, content: {
            NavigationStack {
                
                ZStack {
                    
                    Color.background.ignoresSafeArea()
                    
                    ZStack (alignment: .bottom) {
                        
                        VStack {
                            if viewModel.isLoading && viewModel.cvList.count == 0 {
                                
                                ScrollView (showsIndicators: false) {
                                    
                                    LazyVGrid(columns: [ GridItem(.adaptive(minimum: 420)) ]) {
                                        ForEach(viewModel.defaultCvList.indices, id: \.self) { index in
                                            CVItemView(cv: $viewModel.defaultCvList[index], clickHandler: {}, additionalClickHandler: {}).padding(.bottom, 4)
                                        }
                                    }.padding(.bottom, 36)
                                    
                                }
                                
                            } else {
                                
                                if viewModel.cvList.count > 0 {
                                    
                                    ScrollView (showsIndicators: false) {
                                        
                                        LazyVStack {
                                            
                                            if !viewModel.isPremium {
                                                LabelProView(clickHandler: {
                                                    viewModel.showPaywallSheet()
                                                }).padding(.bottom)
                                            }
                                            
                                            LazyVGrid(columns: [ GridItem(.adaptive(minimum: 160)) ]) {
                                                ForEach(viewModel.cvList.indices, id: \.self) { index in
                                                    CVItemView(cv: $viewModel.cvList[index], clickHandler: {
                                                        if let cv = viewModel.cvList[index] {
                                                            viewModel.showEditor(cv: cv.entity)
                                                        }
                                                    }, additionalClickHandler: {
                                                        if let cv = viewModel.cvList[index] {
                                                            viewModel.selectedCV = cv.entity
                                                            viewModel.showActionsSheet()
                                                        }
                                                    }).padding(.bottom, 4).confirmationDialog(NSLocalizedString("delete", comment: ""), isPresented: $viewModel.actionsSheetShown) {
                                                        Button(NSLocalizedString("edit", comment: "")) {
                                                            viewModel.openCv()
                                                        }
                                                        Button(NSLocalizedString("duplicate", comment: "")) {
                                                            viewModel.duplicateCv()
                                                        }
                                                        Button(NSLocalizedString("share", comment: "")) {
                                                            viewModel.showShareSheet()
                                                        }
                                                        Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                                                            viewModel.deleteCv()
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }.frame(maxHeight: .infinity).padding(.bottom, 36)
                                        
                                    }.alert(NSLocalizedString("went_wrong", comment: ""), isPresented: $viewModel.defaultErrorDialogShown) {
                                        Button(NSLocalizedString("c_continue", comment: "")) {}
                                    }
                                    
                                } else {
                                    
                                    VStack {
                                        
                                        Text(NSLocalizedString("create_cv_header", comment: "")).font(.largeTitle).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 8)
                                        
                                        Text(NSLocalizedString("create_cv_description", comment: "")).font(.subheadline).foregroundStyle(Color.textAdditional).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
                                        
                                        HStack (alignment: .center) {
                                            SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("create", comment: ""), clickHandler: {
                                                viewModel.showConstructorSheet()
                                            })
                                        }
                                    }.frame(maxWidth: 380)
                                }
                            }
                            
                        }.padding().frame(maxWidth: .infinity, maxHeight: .infinity).onChange(of: viewModel.editorPresented) {
                            if !viewModel.editorPresented { viewModel.checkEditorFinish() }
                        }.onChange(of: viewModel.notificationsRequestShown) {
                            AppDelegate.requestNotifications(application: UIApplication.shared)
                        }.onReceive(purchaseManager.$isPremium) { pr in
                            viewModel.setPurchasesAvailable()
                        }.onChange(of: consentManager.isChecked) {
                            if !consentManager.consentShown {
                                viewModel.showInitialPaywallIfAvailable()
                            }
                        }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                            viewModel.checkPaywallFinish()
                        }) {
                            PaywallView(benefitsId: 0, source: "Home view").presentationDetents([.large])
                        }.sheet(isPresented: $viewModel.constructorSheetShown) {
                            ConstructorView(profile: viewModel.profile, generationHandler: { cv in
                                viewModel.checkConstructorFinish(cv: cv)
                            }).presentationDetents([.large])
                        }.sheet(isPresented: $viewModel.onboardSheetShown) {
                            OnBoardView(generationHandler: { cv in
                                viewModel.checkOnBoardFinish(cv: cv)
                            }).presentationDetents([.large])
                        }.sheet(isPresented: $viewModel.shareSheetShown, onDismiss: {
                            viewModel.checkShareFinish()
                        }) {
                            ShareView(cv: viewModel.selectedCV)
                        }.environmentObject(viewModel)
                        
                        LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 90)
                        
                    }.background {
                        formViewControllerRepresentable.frame(width: .zero, height: .zero)
                    }
                    
                }.onAppear() {
                    viewModel.updateData()
                    viewModel.isVisible = true
                    
                    if !viewModel.onboardSheetShown {
                        consentManager.checkConsentOnAppStart(viewController: formViewControllerRepresentable.viewController)
                    }
                    
                }.onDisappear() {
                    viewModel.isVisible = false
                }.navigationDestination(isPresented: $viewModel.editorPresented) {
                    EditorView(cv: viewModel.selectedCV)
                }.navigationBarTitleDisplayMode(.inline).navigationTitle(NSLocalizedString("welcome", comment: "")).toolbar {

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.showConstructorSheet()
                        }) {
                            Image(systemName: "plus").foregroundColor(Color.accent)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.showSideMenu()
                        }) {
                            Image(systemName: "line.horizontal.3").foregroundColor(Color.accent)
                        }
                    }
                }.edgesIgnoringSafeArea(.bottom)
                
            }
        })
    }
}

#Preview {
    HomeView().environmentObject(PurchaseManager())
}
