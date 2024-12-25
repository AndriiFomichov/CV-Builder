//
//  LanguageAddingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct LanguageAddingView: View, KeyboardReadable {
    
    var profile: ProfileEntity?
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = LanguageAddingViewModel()
    
    @State var isCollapsed = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("languages_adding_header", comment: "")), description: .constant(""), isCollapsed: $isCollapsed, icon: "globe", iconPlusAdded: true, maxHeight: 180)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                Text(NSLocalizedString("field_language_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.text, icon: "link.circle.fill", hint: NSLocalizedString("field_language_name_hint", comment: ""), options: viewModel.languageOptions).padding(.bottom)
                                
                                Text(NSLocalizedString("field_language_level", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                SelectionInputView(text: $viewModel.levelName, icon: "network", hint: NSLocalizedString("field_language_level_hint", comment: ""), options: viewModel.levelOptions, selectionHandler: { item in
                                    viewModel.selectLevel(item: item)
                                }).padding(.bottom)
                                
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
                            MainButtonView(isSelected: .constant(true), text: NSLocalizedString("add", comment: ""), clickHandler: {
                                viewModel.save()
                            }).padding(.vertical)
                        }
                    }
                }
                
            }.navigationTitle("").navigationBarTitleDisplayMode(.inline).toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(profile: profile)
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
    LanguageAddingView(profile: nil)
}
