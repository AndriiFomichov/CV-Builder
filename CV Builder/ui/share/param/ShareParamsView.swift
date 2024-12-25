//
//  ShareParamsView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct ShareParamsView: View, KeyboardReadable {
    
    @EnvironmentObject var parentViewModel: ShareViewModel
    @StateObject var viewModel = ShareParamsViewModel()
    
    @State var isCollapsed = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("select_options", comment: "")), description: .constant(""), isCollapsed: $isCollapsed, maxHeight: 180)

                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack {
                            
                            Text(NSLocalizedString("file_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.name, icon: "text.document.fill", hint: NSLocalizedString("file_name", comment: "")).padding(.bottom)
                            
                            Text(NSLocalizedString("export_quality", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            ForEach(viewModel.qualityParams.indices, id: \.self) { index in
                                QualityView(format: viewModel.format, item: $viewModel.qualityParams[index], clickHandler: {
                                    viewModel.selectQuality(index: index)
                                })
                            }
                            
                            if viewModel.btnBadgeVisible {
                                
                                Text(NSLocalizedString("watermark", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.top)
                                
                                Button (action: {
                                    viewModel.showPaywallSheet()
                                }) {
                                    HStack (spacing: 0) {
                                        
                                        ZStack {
                                            
                                            Image(systemName: "checkmark.seal.fill").font(.headline).foregroundStyle(.accent)
                                            
                                        }.frame(width: 42, height: 42).background() {
                                            RoundedRectangle(cornerRadius: 24.0).fill(.windowTwo)
                                        }.padding(8)
                                        
                                        VStack (spacing: 4) {
                                            
                                            Text(NSLocalizedString("watermark_added", comment: "")).font(.title2).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).lineLimit(1)
                                            
                                            LabelView(text: NSLocalizedString("premium_plan", comment: ""))
                                            
                                        }.padding(.trailing, 4).padding(.vertical, 12)
                                        
                                        Toggle("", isOn: .constant(true)).toggleStyle(SwitchToggleStyle(tint: .accent)).disabled(true).padding(.trailing, 8).fixedSize()
                                        
                                    }.frame(maxWidth: .infinity).background() {
                                        RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
                                    }
                                }
                            }
                            
                        }.padding()
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                if isCollapsed {
                    KeyboardActionsView(clearHanlder: {
                        self.endEditing()
                    }, doneHanlder: {
                        self.endEditing()
                    })
                } else {
                    VStack {

                        MainButtonView(isSelected: $viewModel.btnMainSelected, text: NSLocalizedString("continue", comment: ""), clickHandler: {
                            viewModel.nextStep()
                        })
                        
                        if !viewModel.attemptsText.isEmpty {
                            AttemptsLabel(text: $viewModel.attemptsText)
                        }
                        
                    }.padding(.vertical)
                }
                
            }.alert(NSLocalizedString("select_options", comment: ""), isPresented: $viewModel.errorDialogShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
            }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.handlePaywallSheetFinished()
            }) {
                PaywallView(benefitsId: 2, source: "Export params").presentationDetents([.large])
            }
            
        }.navigationBarTitleDisplayMode(.inline).navigationDestination(isPresented: $viewModel.nextStepPresented) {
            ShareExportView()
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                isCollapsed = newIsKeyboardVisible
            }
        }
    }
}

#Preview {
    ShareParamsView().environmentObject(ShareViewModel())
}
