//
//  ConstructorStyleView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import SwiftUI
import SwiftUIPager

struct ConstructorStyleView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var parentViewModel: ConstructorViewModel
    @StateObject var viewModel = ConstructorStyleViewModel()
    
    @Binding var sheetClosed: Bool
    
    @StateObject var page: Page = .first()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("select_style_header", comment: "")), description: .constant(NSLocalizedString("select_style_description", comment: "")), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_four_illustration")

                VStack {
                    
                    GeometryReader { geo in
                        
                        Pager(page: page, data: viewModel.list, id: \.id, content: { item in
                            
                            StyleView(style: $viewModel.list[item.id], clickHandler: {
                                viewModel.selectStyle(id: item.id)
                            })
                            
                        }).preferredItemSize(CGSize(width: geo.size.height * 0.6, height: geo.size.height)).itemSpacing(16).interactive(scale: 0.8).interactive(opacity: 0.5)
                        
                    }.padding(.vertical)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                VStack {
                    
                    MainButtonView(isSelected: $viewModel.btnMainSelected, text: NSLocalizedString("continue", comment: ""), clickHandler: {
                        viewModel.nextStep()
                    }).padding(.bottom)
                }
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
            ConstructorTargetView()
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
    ConstructorStyleView(sheetClosed: .constant(false)).environmentObject(ConstructorViewModel())
}
