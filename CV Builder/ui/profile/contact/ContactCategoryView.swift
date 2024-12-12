//
//  ContactCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct ContactCategoryView: View, KeyboardReadable {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = ContactCategoryViewModel()
    
    @State var qrPreview: UIImage?
    @State var isCollapsed = false
    @State var qrCodeAddingVisible = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("contact_input_header", comment: "")), description: .constant(NSLocalizedString("contact_input_description", comment: "")), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: $isCollapsed, lineIllustration: "small_line_four_illustration")

                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            Text(NSLocalizedString("field_phone_number", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.phone, icon: "phone.fill", hint: NSLocalizedString("field_phone_number_hint", comment: "")).padding(.bottom)
                            
                            Text(NSLocalizedString("field_email", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            TextInputView(text: $viewModel.email, icon: "envelope.fill", hint: NSLocalizedString("field_email_hint", comment: "")).padding(.bottom)
                            
                            Text(NSLocalizedString("field_website", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                            
                            VStack {
                                HStack {
                                    TextInputView(text: $viewModel.website, icon: "globe", hint: NSLocalizedString("field_website_hint", comment: "")).onChange(of: viewModel.website) {
                                        viewModel.handleLinkChange()
                                        
                                        withAnimation {
                                            qrCodeAddingVisible = !viewModel.website.isEmpty
                                        }
                                    }
                                    
                                    if let qrPreview {
                                        Button (action: {
                                            viewModel.openQrCode()
                                        }) {
                                            HStack (spacing: 0) {
                                                
                                                ZStack {
                                                    
                                                    Image(uiImage: qrPreview).resizable().scaledToFit().frame(width: 24, height: 24)
                                                    
                                                }.frame(width: 42, height: 42).background() {
                                                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo)
                                                }.padding(8)
                                                
                                            }.background() {
                                                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                                            }
                                        }
                                    }
                                }
                                
                                if qrPreview == nil && qrCodeAddingVisible {
                                    VStack {
                                        
                                        ActionButtonView(icon: "qrcode", text: NSLocalizedString("create_qr_code", comment: ""), clickHandler: {
                                            viewModel.openQrCode()
                                        }, addArrow: true)
                                        
                                        Text(NSLocalizedString("create_qr_code_tip", comment: "")).font(.subheadline).foregroundStyle(Color.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                        
                                    }.padding(.top, 4)
                                }
                                
                            }.padding(.bottom)
                            
                            
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
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                        viewModel.save()
                        presentationMode.wrappedValue.dismiss()
                    }).padding(.vertical)
                }
                
            }.sheet(isPresented: $viewModel.qrGeneratorSheetShown) {
                QRCodeGeneratorView(link: viewModel.website, initialId: viewModel.qrCodeId, generationHandler: { id in
                    viewModel.handleQrCodeGenerator(id: id)
                }).presentationDetents([.medium])
            }
            
        }.navigationTitle(isCollapsed ? NSLocalizedString("contact_input_header", comment: "") : "").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(clickHandler: {
                    viewModel.save()
                    presentationMode.wrappedValue.dismiss()
                }, text: NSLocalizedString("profile", comment: ""))
            }
            
        }.onAppear() {
            viewModel.updateData(profile: profile)
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                isCollapsed = newIsKeyboardVisible
            }
        }.onChange(of: viewModel.qrCodePreview) {
            withAnimation {
                qrPreview = viewModel.qrCodePreview
            }
        }
    }
}

#Preview {
    ContactCategoryView(profile: nil)
}
