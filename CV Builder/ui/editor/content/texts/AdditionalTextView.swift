//
//  AdditionalTextView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.12.2024.
//

import SwiftUI

struct AdditionalTextView: View, KeyboardReadable {
    
    var cv: CVEntity?
    var finishHandler: (_ isChanged: Bool) -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AdditionalTextViewModel()
    
    @State var isCollapsed = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("additional_texts_header", comment: "")), description: .constant(NSLocalizedString("additional_texts_description", comment: "")), isCollapsed: $isCollapsed, maxHeight: 150)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            VStack {
                                
                                ForEach(viewModel.textsList.indices, id: \.self) { index in
                                    AdditionalTextItemView(item: $viewModel.textsList[index])
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
                        MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                            viewModel.saveTexts()
                        }).padding(.vertical)
                    }
                }
                
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.saveTexts()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(cv: cv)
            }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
                withAnimation {
                    isCollapsed = newIsKeyboardVisible
                }
            }.onChange(of: viewModel.dismissed) {
                finishHandler(viewModel.isChanged)
                dismiss()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    AdditionalTextView(finishHandler: { i in })
}
