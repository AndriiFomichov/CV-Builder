//
//  CertificatesCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct CertificatesCategoryView: View, KeyboardReadable {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = CertificatesCategoryViewModel()
    
    @State var isCollapsed = false
    @State private var actionsSheetShown = false
    
    @State var actionItemIndex = -1
    
    @State private var draggedItem: CertificateItem?
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("certificates_input_header", comment: "")), description: .constant(NSLocalizedString("certificates_input_description", comment: "")), isCollapsed: $isCollapsed)

                VStack {
                    
                    if viewModel.certificatesList.count == 0 {
                        
                        EmptyInputListView(icon: "text.document.fill", header: NSLocalizedString("empty_certificates_header", comment: ""), description: NSLocalizedString("empty_certificates_description", comment: ""), buttonOneName: NSLocalizedString("add_certificate", comment: ""), buttonOneIcon: "plus", buttonOneHandler: {
                            withAnimation {
                                viewModel.addCertificate()
                            }
                        }).padding()
                        
                    } else {
                        
                        HStack {
                            
                            ActionButtonView(icon: "plus", text: NSLocalizedString("add_certificate", comment: ""), clickHandler: {
                                withAnimation {
                                    viewModel.addCertificate()
                                }
                            }, addArrow: true)
                            
                        }.padding([.leading, .top, .trailing])
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                ForEach(viewModel.certificatesList.indices, id: \.self) { index in
                                    CertificateItemView(item: $viewModel.certificatesList[index], actionsHandler: {
                                        actionsSheetShown = true
                                        actionItemIndex = index
                                    }).onDrag {
                                        self.draggedItem = viewModel.certificatesList[index]
                                        return NSItemProvider()
                                    }.onDrop(of: [.text], delegate: CertificateDropDelegate(destinationItem: viewModel.certificatesList[index], list: $viewModel.certificatesList, draggedItem: $draggedItem, dropEndHandler: {
                                        viewModel.handleItemsMoved()
                                    }))
                                }
                                
                            }.padding()
                            
                        }.confirmationDialog(NSLocalizedString("edit", comment: ""), isPresented: $actionsSheetShown) {
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                                withAnimation {
                                    viewModel.deleteCertificate(index: actionItemIndex)
                                }
                            }
                        }
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
            }
            
        }.navigationTitle(isCollapsed ? NSLocalizedString("certificates_input_header", comment: "") : "").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.addCertificate()
                    }
                }) {
                    Image(systemName: "plus").foregroundColor(Color.accent)
                }
            }
            
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
        }
    }
}

#Preview {
    CertificatesCategoryView(profile: nil)
}
