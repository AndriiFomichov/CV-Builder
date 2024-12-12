//
//  ReferenceAddingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct ReferenceAddingView: View, KeyboardReadable {

    var profile: ProfileEntity?
    var entity: ReferenceEntity?
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ReferenceAddingViewModel()
    
    @State var isCollapsed = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("reference", comment: "")), description: .constant(""), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: $isCollapsed, lineIllustration: "small_line_one_illustration", illustration: "work_illustration", maxHeight: 200)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                Text(NSLocalizedString("field_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.name, icon: "person.crop.circle", hint: NSLocalizedString("field_name_hint", comment: "")).padding(.bottom)
                                
                                Text(NSLocalizedString("field_company_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.company, icon: "building.columns.fill", hint: NSLocalizedString("field_company_name_hint", comment: "")).padding(.bottom)
                                
                                Text(NSLocalizedString("field_email", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.email, icon: "envelope.fill", hint: NSLocalizedString("field_email_hint", comment: "")).padding(.bottom)
                                
                                Text(NSLocalizedString("field_phone_number", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.phone, icon: "phone.fill", hint: NSLocalizedString("field_phone_number_hint", comment: "")).padding(.bottom)
                                
                            }.padding()
                            
                        }.alert(NSLocalizedString("delete_reference_header", comment: ""), isPresented: $viewModel.deleteAlertShown) {
                            Button(NSLocalizedString("keep", comment: ""), role: .cancel, action: {})
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive, action: {
                                viewModel.performDelete()
                            })
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
                            MainButtonView(isSelected: .constant(true), text: viewModel.btnMainText, clickHandler: {
                                viewModel.save()
                            }).padding(.vertical)
                        }
                    }
                }
                
            }.navigationTitle(isCollapsed ? NSLocalizedString("reference", comment: "") : "").navigationBarTitleDisplayMode(.inline).toolbar {
                
                if viewModel.deleteVisible {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.delete()
                        }) {
                            Image(systemName: "trash.fill").foregroundColor(Color.accent)
                        }
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
                viewModel.updateData(profile: profile, entity: entity)
            }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
                withAnimation {
                    isCollapsed = newIsKeyboardVisible
                }
            }.onChange(of: viewModel.dismissed) {
                dismiss()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    ReferenceAddingView()
}
