//
//  WorkCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct WorkCategoryView: View {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = WorkCategoryViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("work_input_header", comment: "")), description: .constant(NSLocalizedString("work_input_description", comment: "")), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_four_illustration")

                VStack {
                    
                    WorkFieldsInputView(list: $viewModel.workList, addingClickHandler: { work in
                        viewModel.showWorkAdding(work: work)
                    }, deleteClickHandler: { work, index in
                        withAnimation {
                            viewModel.deleteWork(work: work, index: index)
                        }
                    }, dropEndHandler: {
                        viewModel.handleItemsMoved()
                    }).sheet(isPresented: $viewModel.workAddingSheetShown, onDismiss: {
                        withAnimation {
                            viewModel.updateWorkList()
                        }
                    }) {
                        WorkAddingView(profile: viewModel.profile, entity: viewModel.selectedWork, allFields: true).presentationDetents([.large])
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
                    viewModel.showWorkAdding(work: nil)
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
            GuideView(guideId: 2).presentationDetents([.large])
        }.onAppear() {
            viewModel.updateData(profile: profile)
        }
    }
}

#Preview {
    WorkCategoryView(profile: nil)
}
