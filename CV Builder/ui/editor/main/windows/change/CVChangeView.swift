//
//  CVChangeView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 04.12.2024.
//

import SwiftUI

struct CVChangeView: View {
    
    let changes: [CVChange]
    let appliedHandler: (_ apply: Bool) -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CVChangeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("profile_changes_header", comment: "")), description: .constant(NSLocalizedString("profile_changes_description", comment: "")), isCollapsed: .constant(false), maxHeight: 170)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            LazyVStack {
                                
                                VStack (spacing: 8) {
                                    
                                    Text(NSLocalizedString("select_changes", comment: "")).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                                    
                                    ForEach(viewModel.changesList.indices, id: \.self) { index in
                                        if viewModel.changesList[index].isChangeNeeded {
                                            CVChangeItemView(item: $viewModel.changesList[index], selectionHandler: {
                                                viewModel.selectChange(index: index)
                                            }, descriptionHandler: { selected in
                                                viewModel.selectChangeDescription(index: index)
                                            })
                                        }
                                    }
                                    
                                }.padding(8).background() {
                                    RoundedRectangle(cornerRadius: 20.0).fill(.window)
                                }.padding(.bottom, 8)
                                
                                LargeAttemptsLabel(text: $viewModel.attemptsText).padding(.bottom, 8)
                                
                                VStack (spacing: 8) {
                                    
                                    ZStack {
                                        
                                        Image(systemName: "exclamationmark.circle.fill").font(.title2).foregroundStyle(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        
                                    }.frame(width: 54, height: 54).background() {
                                        RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                                    }
                                    
                                    Text(NSLocalizedString("profile_changes_note_header", comment: "")).font(.title2).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                                    
                                    Text(NSLocalizedString("profile_changes_note_description", comment: "")).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                                    
                                }.padding().background() {
                                    RoundedRectangle(cornerRadius: 20.0).fill(.window)
                                }.padding(.bottom)
                                
                            }.padding()
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                    }.padding(.top, -24)
                    
                    MainButtonView(isSelected: .constant(true), progressVisible: .constant(false), text: NSLocalizedString("add_changes", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                        viewModel.nextStep()
                    }).padding(.top)
                    
                    AdditionalButtonView(text: NSLocalizedString("skip", comment: ""), clickHandler: {
                        appliedHandler(false)
                        dismiss()
                    }).padding(.top, 8).padding(.bottom)
                    
                }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                    viewModel.handlePaywallSheetShown()
                }) {
                    PaywallView(benefitsId: 0, source: "Profile changes").presentationDetents([.large])
                }.sheet(isPresented: $viewModel.limitSheetShown) {
                    AiLimitView(type: 2).presentationDetents([.large])
                }.sheet(isPresented: $viewModel.connectionSheetShown) {
                    CheckConnectionView(allowOffline: false).presentationDetents([.medium])
                }.alert(NSLocalizedString("profile_changes_alert_header", comment: ""), isPresented: $viewModel.applyAlertShown) {
                    Button(NSLocalizedString("skip", comment: ""), action: {})
                    Button(NSLocalizedString("apply", comment: ""), action: {
                        appliedHandler(true)
                        dismiss()
                    })
                } message: {
                    Text(NSLocalizedString("profile_changes_alert_description", comment: ""))
                }
                
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        appliedHandler(false)
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(changes: changes)
            }.onChange(of: viewModel.dismissed) {
                appliedHandler(false)
                dismiss()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    CVChangeView(changes: [], appliedHandler: { i in })
}
