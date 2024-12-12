//
//  OnBoardVisualizationView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI
import SwiftUIPager
import SkeletonUI

struct OnBoardVisualizationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var parentViewModel: OnBoardViewModel
    @StateObject var viewModel = OnBoardVisualizationViewModel()
    @StateObject var consentManager = ConsentManager()
    
    private let formViewControllerRepresentable = CV_BuilderApp.FormViewControllerRepresentable()
    
    @StateObject var page: Page = .first()
    
    @State var noConnectionVisisble = false
    @State var loadingPreview = false
    
    @State var header = ""
    @State var description = ""
    
    var body: some View {
        ZStack {
            
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                ZStack (alignment: .top) {
                    
                    Color.backgroundDark.ignoresSafeArea()
                    
                    Image("large_line_illustration").renderingMode(.template).centerCropped().foregroundStyle(.backgroundDarker)
                    
                    LinearGradient(colors: [ .backgroundDark, .backgroundDark.opacity(0.0) ], startPoint: .top, endPoint: .bottom).frame(height: 20)
                    
                    VStack {
                        
                        if noConnectionVisisble {
                            NoConnectionView().padding([.leading, .trailing]).padding(.top, 4).transition(.move(edge: .top))
                        }
                        
                        if loadingPreview {
                            
                            RoundedRectangle(cornerRadius: 16.0).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(16.0, style: .circular))).aspectRatio(0.6, contentMode: .fit).borderLoadingAnimation(isAnimating: .constant(true)).padding([.leading, .top, .trailing])
                            
                        } else {
                            if viewModel.visualizationList.count > 0 {
                                GeometryReader { geo in
                                    
                                    Pager(page: page, data: viewModel.visualizationList, id: \.id, content: { item in
            
                                        VisualizationView(item: $viewModel.visualizationList[item.id], clickHandler: {
                                            viewModel.selectStyle(id: item.id)
                                        })
            
                                    }).preferredItemSize(CGSize(width: geo.size.height * 0.6, height: geo.size.height)).itemSpacing(16).interactive(scale: 0.8).interactive(opacity: 0.5)
                                    
                                }.padding(.top)
                            }
                        }
                        
                        VStack {
                            
                            Text(header).font(.title).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 4)
                            
                            Text(description).foregroundStyle(Color.text).multilineTextAlignment(.center)
                            
                        }.padding()
                        
                    }.padding(.bottom, 24)
                    
                }.alert(NSLocalizedString("go_back_header", comment: ""), isPresented: $viewModel.goBackDialogShown) {
                    Button(NSLocalizedString("stay", comment: ""), role: .cancel, action: {})
                    Button(NSLocalizedString("go_back", comment: ""), role: .destructive, action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                } message: {
                    Text(NSLocalizedString("go_back_description", comment: ""))
                }.alert(NSLocalizedString("made_with_ai_header", comment: ""), isPresented: $viewModel.tipDialogShown) {
                    Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
                } message: {
                    Text(NSLocalizedString("made_with_ai_description", comment: ""))
                }.alert(NSLocalizedString("error", comment: ""), isPresented: $viewModel.errorDialogShown) {
                    Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
                } message: {
                    Text(NSLocalizedString("default_error", comment: ""))
                }
                
                VStack {
                    
                    MainButtonView(isSelected: $viewModel.btnMainSelected, progressVisible: $viewModel.isLoading, text: viewModel.btnMainText, clickHandler: {
                        viewModel.nextStep()
                    }).padding(.vertical)
                    
                }.background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
            }.background {
                formViewControllerRepresentable.frame(width: .zero, height: .zero)
            }
            
        }.navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showAiTip()
                }) {
                    Image(systemName: "info.circle").foregroundColor(Color.accent)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(clickHandler: {
                    viewModel.backStep()
                })
            }
            
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onChange(of: consentManager.isChecked) {
            if consentManager.isChecked {
                AppDelegate.requestNotifications(application: UIApplication.shared, requestedHandler: {
                    viewModel.close()
                })
            }
        }.onChange(of: viewModel.consentWindowShown) {
            consentManager.checkConsentOnAppStart(viewController: formViewControllerRepresentable.viewController)
        }.onChange(of: viewModel.header) {
            withAnimation {
                header = viewModel.header
            }
        }.onChange(of: viewModel.description) {
            withAnimation {
                description = viewModel.description
            }
        }.onChange(of: viewModel.isGenerating) {
            withAnimation {
                loadingPreview = viewModel.isGenerating
            }
        }.onChange(of: viewModel.isConnectionAvailable) {
            withAnimation {
                noConnectionVisisble = !viewModel.isConnectionAvailable
            }
        }
    }
}

#Preview {
    OnBoardVisualizationView().environmentObject(OnBoardViewModel())
}
