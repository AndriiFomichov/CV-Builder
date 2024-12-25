//
//  EditorAiAssistantView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorAiAssistantView: View {

    @EnvironmentObject var parentViewModel: EditorViewModel
    @StateObject var viewModel = EditorAiAssistantViewModel()
    
    @State var screen = 0
    
    @Namespace private var backAnimationProofread
    @Namespace private var backAnimationOptimize
    @Namespace private var backAnimationTranslate
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                HStack {
                    
                    BackButtonView(clickHandler: {
                        viewModel.back()
                    }).offset(x: 8)
                    
                    Spacer()
                    
                }.padding()
                
                if screen == 0 {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            
                            HStack (spacing: 8) {
                                if viewModel.actions.count > 0 {
                                    AiAssistantActionView(action: viewModel.actions[0], namespaceAnimation: backAnimationProofread)
                                }
                                
                                if viewModel.actions.count > 1 {
                                    AiAssistantActionView(action: viewModel.actions[1], namespaceAnimation: backAnimationOptimize)
                                }
                            }
                            
                            if viewModel.actions.count > 2 {
                                AiAssistantActionView(action: viewModel.actions[2], namespaceAnimation: backAnimationTranslate, ifHorizontal: true).padding(.bottom, 8)
                            }
                            
                            LargeAttemptsLabel(text: $viewModel.attemptsText)
                            
                        }.padding(.horizontal).padding(.bottom)
                    }
                } else if screen == 1 {
                    AiProofreadingView(namespaceAnimation: backAnimationProofread)
                } else if screen == 2 {
                    AiOptimizingView(namespaceAnimation: backAnimationOptimize)
                } else if screen == 3 {
                    AiTranslatingView(namespaceAnimation: backAnimationTranslate)
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.handlePaywallSheetShown()
            }) {
                PaywallView(benefitsId: 0, source: "Ai Assistant").presentationDetents([.large])
            }.sheet(isPresented: $viewModel.limitSheetShown) {
                AiLimitView(type: 1).presentationDetents([.large])
            }.sheet(isPresented: $viewModel.noConnectionSheetShown) {
                CheckConnectionView(allowOffline: false).presentationDetents([.medium])
            }.alert(NSLocalizedString("ai_wait_alert", comment: ""), isPresented: $viewModel.waitErrorShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
            }.environmentObject(viewModel)
            
            if screen == 0 {
                LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 36)
            }
            
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onChange(of: viewModel.screen) {
            withAnimation {
                screen = viewModel.screen
            }
        }
    }
}

#Preview {
    EditorAiAssistantView().environmentObject(EditorViewModel())
}
