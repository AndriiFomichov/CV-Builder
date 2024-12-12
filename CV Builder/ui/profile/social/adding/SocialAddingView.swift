//
//  SocialAddingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct SocialAddingView: View, KeyboardReadable {
    
    var profile: ProfileEntity?
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SocialAddingViewModel()
    
    @State var keyboardVisible = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    EditableTopBarView(header: .constant(NSLocalizedString("social_media_adding_header", comment: "")), description: .constant(NSLocalizedString("social_media_adding_description", comment: "")), text: $viewModel.link, icon: "globe", hint: NSLocalizedString("social_media_adding_hint", comment: ""), lineIllustration: "small_line_one_illustration", maxHeight: 200)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            LazyVGrid(columns: [ GridItem(.adaptive(minimum: 120)) ]) {
                                
                                ForEach(viewModel.list.indices, id: \.self) { index in
                                    SocialMediaView(item: $viewModel.list[index], clickHandler: {
                                        viewModel.selectMedia(id: index)
                                    })
                                }
                                
                            }.padding()
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                    }.padding(.top, -24)
                    
                    if keyboardVisible {
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
                    keyboardVisible = newIsKeyboardVisible
                }
            }.onChange(of: viewModel.dismissed) {
                dismiss()
            }.onChange(of: viewModel.link) {
                viewModel.handleLinkChange()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    SocialAddingView()
}
