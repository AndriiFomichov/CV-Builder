//
//  QRCodeGeneratorView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI
import SkeletonUI

struct QRCodeGeneratorView: View {
    
    let link: String
    let initialId: Int
    let generationHandler: (_ id: Int) -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = QRCodeGeneratorViewModel()
    
    @State private var isAnimating = false
    @State var isLoading = false
    @State var preview: UIImage?
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack {
                    
                    ZStack {
                        
                        if isLoading {
                            
                            RoundedRectangle(cornerRadius: 16.0).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(16.0, style: .circular))).onAppear() {
                                withAnimation(.linear(duration: 1.6).repeatForever(autoreverses: false)) {
                                    self.isAnimating = true
                                }
                            }.borderLoadingAnimation(isAnimating: $isAnimating)
                            
                        } else {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                                
                                if let preview {
                                    Image(uiImage: preview).resizable().scaledToFit().padding()
                                }
                            }.padding(8)
                        }
                        
                    }.aspectRatio(1.0, contentMode: .fit).padding()
                    
                    VStack {

                        MainButtonView(isSelected: $viewModel.btnMainSelected, progressVisible: $viewModel.isLoading, text: viewModel.btnMainText, icon: viewModel.lockedIconVisible ? "lock.fill" : nil, clickHandler: {
                            viewModel.nextStep()
                        })
                        
                        if viewModel.attemptsVisible {
                            AttemptsLabel(text: $viewModel.attemptsText).padding(.top, 4)
                        }
                        
                    }.padding(.vertical)
                    
                }
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(initial: initialId, link: link)
            }.onChange(of: viewModel.dismissed) {
                if viewModel.dismissed {
                    finish()
                }
            }.onChange(of: viewModel.isLoading) {
                withAnimation {
                    self.isLoading = viewModel.isLoading
                }
            }.onChange(of: viewModel.preview) {
                withAnimation {
                    self.preview = viewModel.preview
                }
            }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.updateAttempts()
            }) {
                PaywallView(benefitsId: 3, source: "QR generator").presentationDetents([.large])
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
    
    func finish () {
        generationHandler(viewModel.selectedQRCodeId)
        dismiss()
    }
}

#Preview {
    QRCodeGeneratorView(link: "", initialId: -1, generationHandler: { id in })
}
