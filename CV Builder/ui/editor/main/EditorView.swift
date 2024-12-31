//
//  EditorView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct EditorView: View, KeyboardReadable {
    
    let cv: CVEntity?
    
    @StateObject var viewModel = EditorViewModel()
    
    @State var currentState = 0
    @State var profileVisible = true
    @State var bottomScreensHeight = 0.6
    @State var btnAiAssistantVisible = true
    @State var keyboardVisible = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                if profileVisible {
                    EditorProfileView(name: $viewModel.userName, description: $viewModel.userDescription, photo: $viewModel.userPhoto, clickHandler: {
                        viewModel.openProfile()
                    }).transition(.move(edge: .top).combined(with: .opacity))
                }
                
                GeometryReader { proxy in
                    
                    VStack (spacing: 0) {
                        
                        ZStack (alignment: .top) {
                            
                            if !keyboardVisible || viewModel.page == 1 {
                                EditorPreviewView(wrapper: $viewModel.wrapper, isLoading: $viewModel.isLoading, isCoverLetterGenerating: $viewModel.isCoverLetterGenerating, pageModel: $viewModel.page, pageChangeHandler: {
                                    viewModel.handlePageChanged()
                                }, pagesUpdateHandler: {
                                    viewModel.savePagesUpdated()
                                }, pagesSelectHandler: { page in
                                    viewModel.showPage(page: page)
                                }, generateClickHandler: {
                                    viewModel.applyCoverLetterAiAction(action: 0)
                                }, textChangeHandler: { text in
                                    viewModel.handleCoverLetterTextChanged(text: text)
                                }, tapHandler: { page, isCv in
                                    viewModel.updateState(state: 2)
                                }, doubleTapHandler: { page, isCv in
                                    viewModel.showZoomablePreview(page: page, isCv: isCv)
                                })
                            }
                            
                            if !keyboardVisible && btnAiAssistantVisible {
                                SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("ai_assistant", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                                    viewModel.updateState(state: 1)
                                }, isGradient: true).shadow(color: .black.opacity(0.1), radius: 10).padding()
                            }
                        }
                        
                        HStack {
                            
                            switch currentState {
                            case 0:
                                if keyboardVisible {
                                    KeyboardActionsAiView(actionAvailable: $viewModel.isCoverLetterAiActionAvailable, aiHanlder: { action in
                                        self.endEditing()
                                        viewModel.applyCoverLetterAiAction(action: action)
                                    }, doneHanlder: {
                                        self.endEditing()
                                    })
                                } else {
                                    EditorBottomView().transition(.move(edge: .bottom))
                                }
                            case 1:
                                EditorAiAssistantView().frame(height: proxy.size.height * bottomScreensHeight).transition(.move(edge: .bottom))
                            case 2:
                                EditorContentView().frame(height: proxy.size.height * bottomScreensHeight).transition(.move(edge: .bottom))
                            case 3:
                                EditorDesignView().frame(height: proxy.size.height * bottomScreensHeight).transition(.move(edge: .bottom))
                            default:
                                HStack {}
                            }
                            
                        }.clipShape(UnevenRoundedRectangle(topLeadingRadius: 24.0, topTrailingRadius: 24.0))
                        
                    }.background() {
                        Color.backgroundDark
                    }
                }
                
            }.sheet(isPresented: $viewModel.shareSheetShown, onDismiss: {
                viewModel.checkShareFinish()
            }) {
                ShareView(cv: viewModel.cv)
            }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.checkPaywallFinish()
            }) {
                PaywallView(benefitsId: 0, source: "Editor").presentationDetents([.large])
            }.sheet(isPresented: $viewModel.previewSheetShown) {
                EditorZoomablePreviewView(page: viewModel.previewPage, isCv: viewModel.previewIsCv, wrapper: $viewModel.wrapper).presentationDetents([.large])
            }.sheet(isPresented: $viewModel.changesSheetShown) {
                CVChangeView(changes: viewModel.changesList, appliedHandler: { applied in
                    viewModel.handleProfileChangesSheet(apply: applied)
                }).presentationDetents([.large])
            }.sheet(isPresented: $viewModel.aiCommandSheetShown) {
                CustomAIActionView(initialText: viewModel.customAction.text, actionHandler: { command in
                    viewModel.handleAiCommandApplied(command: command)
                }).presentationDetents([.medium])
            }.sheet(isPresented: $viewModel.limitSheetShown) {
                AiLimitView(type: 2).presentationDetents([.large])
            }.sheet(isPresented: $viewModel.connectionSheetShown) {
                CheckConnectionView(allowOffline: false).presentationDetents([.medium])
            }.sheet(isPresented: $viewModel.profileSheetShown, onDismiss: {
                viewModel.handleProfileUpdated()
            }) {
                ProfileView().presentationDetents([.large])
            }.alert(NSLocalizedString("cover_letter_generation_alert", comment: ""), isPresented: $viewModel.coverAlertShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
                Button(NSLocalizedString("cover_to_profile", comment: ""), action: {
                    viewModel.openProfile()
                })
                Button(NSLocalizedString("cover_to_assistant", comment: ""), action: {
                    viewModel.showPage(page: 0)
                })
            }
            
        }.onAppear() {
            viewModel.updateData(cv: cv)
        }.onDisappear() {
            viewModel.updateLastModified()
        }.onChange(of: viewModel.btnProfileVisible) {
            withAnimation {
                profileVisible = viewModel.btnProfileVisible
            }
        }.onChange(of: viewModel.state) {
            self.endEditing()
            withAnimation {
                currentState = viewModel.state
            }
        }.onChange(of: viewModel.btnAiAssistantVisible) {
            withAnimation {
                btnAiAssistantVisible = viewModel.btnAiAssistantVisible
            }
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                keyboardVisible = newIsKeyboardVisible
            }
        }.onChange(of: keyboardVisible) {
            withAnimation {
                bottomScreensHeight = keyboardVisible ? 1.0 : 0.6
            }
        }.navigationTitle(viewModel.header).navigationBarTitleDisplayMode(.inline).toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.share()
                }) {
                    Image(systemName: "square.and.arrow.up").foregroundColor(Color.accent)
                }
            }
            
        }.environmentObject(viewModel)
    }
}

#Preview {
    EditorView(cv: CVEntity.getDefault())
}
