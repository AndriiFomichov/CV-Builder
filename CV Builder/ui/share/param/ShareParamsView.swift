//
//  ShareParamsView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct ShareParamsView: View {
    
    @EnvironmentObject var parentViewModel: ShareViewModel
    @StateObject var viewModel = ShareParamsViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("select_options", comment: "")), description: .constant(""), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_four_illustration")

                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack {
                            
                            Text(NSLocalizedString("file_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.name, icon: "text.document.fill", hint: NSLocalizedString("file_name", comment: "")).padding(.bottom)
                            
                            Text(NSLocalizedString("export_quality", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            ForEach(viewModel.qualityParams.indices, id: \.self) { index in
                                QualityView(item: $viewModel.qualityParams[index], clickHandler: {
                                    viewModel.selectQuality(index: index)
                                })
                            }
                            
                        }.padding()
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                VStack {
                    
                    Color.backgroundDark.frame(height: 1).padding(.bottom, 8)
                    
                    if viewModel.btnBadgeVisible {
                        Button (action: {
                            viewModel.showPaywallSheet()
                        }) {
                            HStack {
                                Text(NSLocalizedString("premium_plan", comment: "")).font(.subheadline).foregroundStyle(Color.white).multilineTextAlignment(.leading).padding(6).background() {
                                    RoundedRectangle(cornerRadius: 12.0).fill(Color.accent)
                                }
                                
                                Text(NSLocalizedString("watermark_btn", comment: "")).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.leading).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 8)
                                
                                Toggle ("", isOn: .constant(true)).tint(Color.accent).disabled(true).frame(width: 32).padding(.trailing)
                                
                            }.padding(.horizontal).padding(.bottom, 8)
                        }
                    }
                    
                    MainButtonView(isSelected: $viewModel.btnMainSelected, text: NSLocalizedString("continue", comment: ""), clickHandler: {
                        viewModel.nextStep()
                    })
                    
                    if !viewModel.attemptsText.isEmpty {
                        AttemptsLabel(text: $viewModel.attemptsText)
                    }
                    
                }.padding(.bottom)
                
            }.alert(NSLocalizedString("select_options", comment: ""), isPresented: $viewModel.errorDialogShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
            }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.handlePaywallSheetFinished()
            }) {
                PaywallView(benefitsId: 0, source: "Export params").presentationDetents([.large])
            }
            
        }.navigationBarTitleDisplayMode(.inline).navigationDestination(isPresented: $viewModel.nextStepPresented) {
            ShareExportView()
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }
    }
}

#Preview {
    ShareParamsView().environmentObject(ShareViewModel())
}
