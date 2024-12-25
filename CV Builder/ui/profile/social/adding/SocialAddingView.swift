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
    
    @State var isCollapsed = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("social_media_adding_header", comment: "")), description: .constant(""), isCollapsed: $isCollapsed, icon: "link.circle.fill", iconPlusAdded: true, maxHeight: 180)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                Text(NSLocalizedString("field_media_link", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.link, icon: "link.circle.fill", hint: NSLocalizedString("field_media_link_hint", comment: ""), keyboardType: .URL).padding(.bottom)
                                
                                Text(NSLocalizedString("field_media_media", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                SelectionInputView(text: $viewModel.mediaName, icon: "network", hint: NSLocalizedString("field_media_media_hint", comment: ""), options: viewModel.medias, selectionHandler: { item in
                                    viewModel.selectMedia(item: item)
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
            }.onChange(of: viewModel.link) {
                viewModel.handleLinkChange()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    SocialAddingView()
}
