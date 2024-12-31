//
//  GeneralCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct GeneralCategoryView: View, KeyboardReadable {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = GeneralCategoryViewModel()
    
    @State var isCollapsed = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("general_input_header", comment: "")), description: .constant(NSLocalizedString("general_input_description", comment: "")), isCollapsed: $isCollapsed)

                VStack {
                    
                    GeneralFieldsInputView(name: $viewModel.name, location: $viewModel.location, job: $viewModel.job, allFields: true)
                    
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
            
        }.navigationTitle(isCollapsed ? NSLocalizedString("general_input_header", comment: "") : "").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden().toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showGuide()
                }) {
                    Image(systemName: "info.circle").foregroundColor(Color.accent)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(clickHandler: {
                    viewModel.save()
                    presentationMode.wrappedValue.dismiss()
                }, text: NSLocalizedString("profile", comment: ""))
            }
            
        }.sheet(isPresented: $viewModel.guideSheetShown) {
            GuideView(guideId: 0).presentationDetents([.large])
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
    GeneralCategoryView(profile: nil)
}
