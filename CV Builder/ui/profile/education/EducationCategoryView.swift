//
//  EducationCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct EducationCategoryView: View {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = EducationCategoryViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("education_input_header", comment: "")), description: .constant(NSLocalizedString("education_input_description", comment: "")), isCollapsed: .constant(false))

                VStack {
                    
                    EducationFieldsInputView(list: $viewModel.educationList, addingClickHandler: { education in
                        viewModel.showEducationAdding(education: education)
                    }, deleteClickHandler: { education, index in
                        withAnimation {
                            viewModel.deleteEducation(education: education, index: index)
                        }
                    }, dropEndHandler: {
                        viewModel.handleItemsMoved()
                    }).sheet(isPresented: $viewModel.educationAddingSheetShown, onDismiss: {
                        withAnimation {
                            viewModel.updateEducationList()
                        }
                    }) {
                        EducationAddingView(profile: viewModel.profile, entity: viewModel.selectedEducation, allFields: true).presentationDetents([.large])
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                    presentationMode.wrappedValue.dismiss()
                }).padding(.vertical)
            }
            
        }.navigationBarTitleDisplayMode(.inline).toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showEducationAdding(education: nil)
                }) {
                    Image(systemName: "plus").foregroundColor(Color.accent)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.showGuide()
                }) {
                    Image(systemName: "info.circle").foregroundColor(Color.accent)
                }
            }
            
        }.sheet(isPresented: $viewModel.guideSheetShown) {
            GuideView(guideId: 1).presentationDetents([.large])
        }.onAppear() {
            viewModel.updateData(profile: profile)
        }
    }
}

#Preview {
    EducationCategoryView(profile: nil)
}
