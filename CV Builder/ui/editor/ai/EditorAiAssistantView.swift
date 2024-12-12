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
    
    @StateObject var monitor = NetworkMonitor()
    
    @State var screen = 0
    @State var noNetworkVisible = false
    
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
                            
                            if noNetworkVisible {
                                NoConnectionView().padding(.bottom)
                            }
                            
                            ForEach(viewModel.actions.indices, id: \.self) { index in
                                AiAssistantActionView(action: viewModel.actions[index]).padding(.bottom, 8)
                            }
                            
                            AttemptsLabel(text: $viewModel.attemptsText)
                            
                        }.padding(.horizontal).padding(.bottom)
                    }
                } else if screen == 1 {
                    AiProofreadingView()
                } else if screen == 2 {
                    AiOptimizingView()
                } else if screen == 3 {
                    AiTranslatingView()
                }
                
            }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.handlePaywallSheetShown()
            }) {
                PaywallView(benefitsId: 0, source: "Ai Assistant").presentationDetents([.large])
            }.sheet(isPresented: $viewModel.limitSheetShown) {
                AiLimitView().presentationDetents([.large])
            }.alert(NSLocalizedString("ai_wait_alert", comment: ""), isPresented: $viewModel.waitErrorShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
            }.environmentObject(viewModel)
            
            if screen == 0 {
                LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 36)
            }
            
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onChange(of: monitor.status) {
            withAnimation {
                noNetworkVisible = monitor.status == .disconnected
            }
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
