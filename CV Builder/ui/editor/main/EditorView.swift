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
    @State var keyboardVisible = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                if profileVisible {
                    EditorProfileView(name: $viewModel.userName, description: $viewModel.userDescription, photo: $viewModel.userPhoto, profileUpdateHandler: {
                        viewModel.handleProfileUpdated()
                    })
                }
                
                GeometryReader { proxy in
                    
                    VStack (spacing: 0) {
                        
                        if !keyboardVisible || viewModel.page == 1 {
                            EditorPreviewView(wrapper: $viewModel.wrapper, isLoading: $viewModel.isLoading, isCoverLetterGenerating: $viewModel.isCoverLetterGenerating, pageModel: $viewModel.page, pageChangeHandler: {
                                viewModel.handlePageChanged()
                            }, pagesUpdateHandler: {
                                viewModel.savePagesUpdated()
                            }, generateClickHandler: {
                                viewModel.generateCoverLetter()
                            }, textChangeHandler: { text in
                                viewModel.handleCoverLetterTextChanged(text: text)
                            }, doubleTapHandler: { page, isCv in
                                viewModel.showZoomablePreview(page: page, isCv: isCv)
                            })
                        }
                        
                        HStack {
                            
                            switch currentState {
                            case 0:
                                if keyboardVisible {
                                    KeyboardActionsView(clearHanlder: {
                                        self.endEditing()
                                    }, doneHanlder: {
                                        self.endEditing()
                                    })
                                } else {
                                    EditorBottomView().transition(.push(from: .bottom))
                                }
                            case 1:
                                EditorAiAssistantView().frame(height: proxy.size.height * bottomScreensHeight).transition(.push(from: .bottom))
                            case 2:
                                EditorContentView().frame(height: proxy.size.height * bottomScreensHeight).transition(.push(from: .bottom))
                            case 3:
                                EditorDesignView().frame(height: proxy.size.height * bottomScreensHeight).transition(.push(from: .bottom))
                            default:
                                HStack {}
                            }
                            
                        }.clipShape(UnevenRoundedRectangle(topLeadingRadius: 20.0, topTrailingRadius: 20.0))
                        
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
            }.sheet(isPresented: $viewModel.changeSheetShown) {
                CVChangeView().presentationDetents([.large])
            }.sheet(isPresented: $viewModel.limitSheetShown) {
                AiLimitView().presentationDetents([.large])
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
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                keyboardVisible = newIsKeyboardVisible
            }
        }.onChange(of: keyboardVisible) {
            withAnimation {
                bottomScreensHeight = keyboardVisible ? 1.0 : 0.6
            }
        }.navigationTitle(viewModel.header).navigationBarTitleDisplayMode(.inline).toolbar {
            
            if viewModel.btnAddVisible {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showCoverLetter()
                    }) {
                        Image(systemName: "plus").foregroundColor(Color.accent)
                    }
                }
            }
            
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
