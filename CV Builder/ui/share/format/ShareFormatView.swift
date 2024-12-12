//
//  ShareFormatView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct ShareFormatView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var parentViewModel: ShareViewModel
    @StateObject var viewModel = ShareFormatViewModel()
    
    @Binding var sheetClosed: Bool
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("select_format", comment: "")), description: .constant(""), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_four_illustration")

                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack {
                            
                            ForEach(viewModel.formatsList.indices, id: \.self) { index in
                                FormatView(format: $viewModel.formatsList[index], clickHandler: {
                                    viewModel.selectFormat(index: index)
                                })
                            }
                            
                        }.padding()
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                VStack {
                    
                    MainButtonView(isSelected: $viewModel.btnMainSelected, text: NSLocalizedString("continue", comment: ""), clickHandler: {
                        viewModel.nextStep()
                    }).padding(.bottom)
                }
                
            }.alert(NSLocalizedString("select_format", comment: ""), isPresented: $viewModel.errorDialogShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
            }
            
        }.navigationBarTitleDisplayMode(.inline).toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                }
            }
            
        }.navigationDestination(isPresented: $viewModel.nextStepPresented) {
            ShareParamsView()
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }.onChange(of: sheetClosed) {
            if sheetClosed {
                dismiss()
            }
        }
    }
}
 
#Preview {
    ShareFormatView(sheetClosed: .constant(false)).environmentObject(ShareViewModel())
}
