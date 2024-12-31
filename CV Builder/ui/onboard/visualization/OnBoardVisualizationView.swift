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
    
    @State var visualizationVisible = false
    @State var loadingPreview = false
    
    var body: some View {
        ZStack {
            
            ColoredBackgroundLargeView(animating: true).ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                
                ZStack {
                    Color.clear
                    
                    VisualizationView(isGenerating: $viewModel.isGenerating, item: $viewModel.wrapper, clickHandler: { page in
                        viewModel.showPreview(page: page)
                    }).frame(maxHeight: 700).aspectRatio(0.65, contentMode: .fit).padding([.leading, .trailing]).padding(.bottom, loadingPreview ? 48 : 16)
                }
                
                ZStack (alignment: .top) {
                    
                    VStack (spacing: 8) {
                        
                        if visualizationVisible {
                            
                            ZStack (alignment: .bottom) {
                                ScrollView (showsIndicators: false) {
                                    
                                    VStack {
                                        
                                        Text(viewModel.description).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                                        
                                        ForEach(viewModel.visualizationList.indices, id: \.self) { index in
                                            VisualizationItemView(item: $viewModel.visualizationList[index], clickHandler: {
                                                viewModel.selectVisualization(id: viewModel.visualizationList[index].id)
                                            })
                                        }
                                        
                                    }.padding(.horizontal).padding(.top)
                                    
                                }
                                
                                LinearGradient(colors: [ .clear, .windowColored ], startPoint: .top, endPoint: .bottom).frame(height: 10)
                                
                            }.frame(height: 150)
                            
                        } else {
                            Text(viewModel.header).font(.title).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.horizontal).padding(.top).padding(.top)
                            
                            Text(viewModel.description).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal).padding(.bottom, 8)
                        }
                        
                        MainButtonView(isSelected: $viewModel.btnMainSelected, progressVisible: $viewModel.isLoading, text: viewModel.btnMainText, clickHandler: {
                            viewModel.nextStep()
                        }).padding(.top, 8)
                        
                    }.padding(.bottom).background() {
                        UnevenRoundedRectangle(topLeadingRadius: 24.0, topTrailingRadius: 24.0).fill(Color.windowColored).ignoresSafeArea()
                    }.padding(.horizontal, 8)
                    
                    if loadingPreview {
                        ZStack {
                            
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 28, height: 28)
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }.offset(y: -32)
                    }
                    
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
                
            }.background {
                formViewControllerRepresentable.frame(width: .zero, height: .zero)
            }.sheet(isPresented: $viewModel.previewSheetShown) {
                EditorZoomablePreviewView(page: viewModel.previewPage, isCv: true, wrapper: $viewModel.wrapper).presentationDetents([.large])
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
        }.onChange(of: viewModel.isGenerating) {
            withAnimation {
                loadingPreview = viewModel.isGenerating
            }
        }.onChange(of: viewModel.visualizationShown) {
            withAnimation {
                visualizationVisible = viewModel.visualizationShown
            }
        }
    }
}

#Preview {
    OnBoardVisualizationView().environmentObject(OnBoardViewModel())
}
