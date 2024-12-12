//
//  BackgroundRemoverView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct BackgroundRemoverView: View {
    
    let imageId: Int
    let selectionHandler: (_ id: Int) -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = BackgroundRemoverViewModel()
    
    @State var tipsShown = false
    @State var attemptsVisible = true
    @State var btnCancelVisible = false
    @State var isBackgroundRemoving = false
    @State var showInitialImage = false
    @State var preview: UIImage?
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("ai_background_remover", comment: "")), description: .constant(""), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_one_illustration", illustration: "back_remover_illustration", maxHeight: 200)
                
                    VStack {
                        
                        if tipsShown {
                            
                            VStack {
                                
                                ScrollView (showsIndicators: false) {
                                    
                                    VStack {
                                        
                                        Text(NSLocalizedString("before_you_begin", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
                                        
                                        PhotoTipView(tip: PhotoTip(header: NSLocalizedString("ai_back_remover_tip_one_header", comment: ""), description: NSLocalizedString("ai_back_remover_tip_one_description", comment: ""), imageOne: "profile_photo_two_illustration", imageTwo: "", orientation: 0))
                                        
                                        PhotoTipView(tip: PhotoTip(header: NSLocalizedString("ai_back_remover_tip_two_header", comment: ""), description: NSLocalizedString("ai_back_remover_tip_two_description", comment: ""), imageOne: "profile_photo_five_illustration", imageTwo: "", orientation: 0))
                                        
                                        PhotoTipView(tip: PhotoTip(header: NSLocalizedString("ai_back_remover_tip_three_header", comment: ""), description: NSLocalizedString("ai_back_remover_tip_three_description", comment: ""), imageOne: "profile_photo_nine_illustration", imageTwo: "", orientation: 0))
                                        
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                                    
                                }
                                
                                MainButtonView(isSelected: .constant(true), text: NSLocalizedString("continue", comment: ""), clickHandler: {
                                    viewModel.showTips()
                                }).padding(.vertical)
                            }
                            
                        } else {
                            
                            VStack {
                                ZStack {
                                    
                                    if let image = viewModel.imagePreview, showInitialImage {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .background(Color.windowTwo)
                                    }
                                    
                                    if let preview {
                                        Image(uiImage: preview)
                                            .resizable()
                                            .scaledToFit()
                                            .background(Color.windowTwo).opacity(isBackgroundRemoving ? 0.5 : (showInitialImage ? 0.0 : 1.0))
                                            .onLongPressGesture(minimumDuration: .infinity) {
                                              // Do nothing as an action, only the state change matters.
                                            } onPressingChanged: { starting in
                                                withAnimation {
                                                    showInitialImage = starting
                                                }
                                            }
                                    }
                                    
                                    if isBackgroundRemoving {
                                        ProgressView().tint(Color.accent)
                                    }
                                    
                                }.clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(8).background {
                                    RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                                }
                                
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                            
                            VStack {

                                MainButtonView(isSelected: $viewModel.btnMainSelected, progressVisible: $viewModel.btnMainLoading, text: viewModel.btnMainText, icon: viewModel.lockedIconVisible ? "lock.fill" : nil, clickHandler: {
                                    viewModel.nextStep()
                                })
                                
                                if attemptsVisible {
                                    AttemptsLabel(text: $viewModel.attemptsText).padding(.top, 4)
                                }
                                
                                if btnCancelVisible {
                                    Button (action: {
                                        viewModel.close()
                                    }) {
                                        HStack {
                                            Text(NSLocalizedString("keep_previous_version", comment: "")).font(.headline).bold().foregroundStyle(Color.textAdditional)
                                        }.frame(maxWidth: .infinity).padding().background() {
                                            RoundedRectangle(cornerRadius: 50.0).fill(Color.window)
                                        }.padding(.horizontal).padding(.top, 4)
                                    }
                                }
                                
                            }.padding(.bottom)
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                    }.padding(.top, -24)
                }
                
            }.navigationDestination(isPresented: $viewModel.paywallPresented) {
                
                PaywallView(benefitsId: 8, source: "Background remover")
                
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showTips()
                    }) {
                        Image(systemName: "info.circle").foregroundColor(Color.accent)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(imageId: imageId)
            }.onChange(of: viewModel.dismissed) {
                if viewModel.dismissed {
                    finish()
                }
            }.onChange(of: viewModel.tipsShown) {
                withAnimation {
                    self.tipsShown = viewModel.tipsShown
                }
            }.onChange(of: viewModel.attemptsVisible) {
                withAnimation {
                    self.attemptsVisible = viewModel.attemptsVisible
                }
            }.onChange(of: viewModel.btnCancelVisible) {
                withAnimation {
                    self.btnCancelVisible = viewModel.btnCancelVisible
                }
            }.onChange(of: viewModel.isBackgroundRemoving) {
                withAnimation {
                    self.isBackgroundRemoving = viewModel.isBackgroundRemoving
                }
            }.onChange(of: viewModel.imagePreview) {
                withAnimation {
                    self.preview = viewModel.imagePreview
                }
            }.onChange(of: viewModel.imageResultPreview) {
                if viewModel.imageResultPreview != nil {
                    withAnimation {
                        self.preview = viewModel.imageResultPreview
                    }
                }
            }
            
        }.tint(Color.accent)
    }
    
    func finish () {
        selectionHandler(viewModel.imageId)
        dismiss()
    }
}

#Preview {
    BackgroundRemoverView(imageId: 0, selectionHandler: { id in })
}
