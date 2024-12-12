//
//  OnBoardStyleView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI
import SwiftUIPager

struct OnBoardStyleView: View {
    
    @EnvironmentObject var parentViewModel: OnBoardViewModel
    @StateObject var viewModel = OnBoardStyleViewModel()
    
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
            
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
////                    viewModel.showGuideSheet()
//                }) {
//                    Image(systemName: "info.circle").foregroundColor(Color.white)
//                }
//            }
            
        }.navigationDestination(isPresented: $viewModel.nextStepPresented) {
            OnBoardInputView()
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }
    }
}

#Preview {
    OnBoardStyleView().environmentObject(OnBoardViewModel())
}
