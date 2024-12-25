//
//  InterestsAddingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct InterestsAddingView: View, KeyboardReadable {
    
    var profile: ProfileEntity?
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = InterestsAddingViewModel()
    
    @State var isCollapsed = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("interests_adding_header", comment: "")), description: .constant(""), isCollapsed: $isCollapsed, icon: "gamecontroller.fill", iconPlusAdded: true, maxHeight: 180)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                Text(NSLocalizedString("interests_category_0", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.listOne.indices, id: \.self) { index in
                                            InterestView(item: $viewModel.listOne[index], clickHandler: {
                                                viewModel.selectInterestOne(index: index)
                                            })
                                        }
                                    }.padding(.horizontal)
                                }.padding(.bottom)
                                
                                Text(NSLocalizedString("interests_category_1", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.listTwo.indices, id: \.self) { index in
                                            InterestView(item: $viewModel.listTwo[index], clickHandler: {
                                                viewModel.selectInterestTwo(index: index)
                                            })
                                        }
                                    }.padding(.horizontal)
                                }.padding(.bottom)
                                
                                Text(NSLocalizedString("interests_category_2", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.listThree.indices, id: \.self) { index in
                                            InterestView(item: $viewModel.listThree[index], clickHandler: {
                                                viewModel.selectInterestThree(index: index)
                                            })
                                        }
                                    }.padding(.horizontal)
                                }.padding(.bottom)
                                
                                Text(NSLocalizedString("interests_category_3", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.listFour.indices, id: \.self) { index in
                                            InterestView(item: $viewModel.listFour[index], clickHandler: {
                                                viewModel.selectInterestFour(index: index)
                                            })
                                        }
                                    }.padding(.horizontal)
                                }.padding(.bottom)
                                
                                Text(NSLocalizedString("interests_category_4", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.listFive.indices, id: \.self) { index in
                                            InterestView(item: $viewModel.listFive[index], clickHandler: {
                                                viewModel.selectInterestFive(index: index)
                                            })
                                        }
                                    }.padding(.horizontal)
                                }.padding(.bottom)
                                
                                Text(NSLocalizedString("interests_category_5", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.listSix.indices, id: \.self) { index in
                                            InterestView(item: $viewModel.listSix[index], clickHandler: {
                                                viewModel.selectInterestSix(index: index)
                                            })
                                        }
                                    }.padding(.horizontal)
                                }.padding(.bottom)
                                
                                Text(NSLocalizedString("field_interest_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.horizontal)
                                
                                TextInputView(text: $viewModel.text, icon: "gamecontroller.fill", hint: NSLocalizedString("field_interest_name_hint", comment: "")).padding(.horizontal).padding(.bottom)
                                
                            }.padding(.vertical)
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
    InterestsAddingView(profile: nil)
}
