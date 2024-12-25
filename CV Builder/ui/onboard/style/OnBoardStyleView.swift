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
                
                TopBarView(header: .constant(NSLocalizedString("select_style_header", comment: "")), description: .constant(NSLocalizedString("select_style_description", comment: "")), isCollapsed: .constant(false))

                VStack {
                    
                    GeometryReader { geo in
                        
                        Pager(page: page, data: viewModel.list, id: \.id, content: { item in
                            
                            StyleView(style: $viewModel.list[item.id], clickHandler: {
                                viewModel.nextStep()
                            }).onAppear() {
                                withAnimation {
                                    page.update(.new(index: viewModel.currentPage))
                                }
                            }
                            
                        }).preferredItemSize(CGSize(width: geo.size.height * 0.6, height: geo.size.height)).itemSpacing(16).interactive(scale: 0.8).interactive(opacity: 0.5).onPageChanged({ index in
                            viewModel.selectStyle(id: index)
                        })
                    }
                    
                    PageIndicatorView(currentPage: $viewModel.currentPage, pages: viewModel.list.count).offset(y: -6).padding(.bottom)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                VStack {
                    
                    MainButtonView(isSelected: $viewModel.btnMainSelected, text: NSLocalizedString("select_style", comment: ""), clickHandler: {
                        viewModel.nextStep()
                    }).padding(.bottom)
                }
            }
            
        }.navigationBarTitleDisplayMode(.inline).navigationDestination(isPresented: $viewModel.nextStepPresented) {
            OnBoardInputView()
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }
    }
}

#Preview {
    OnBoardStyleView().environmentObject(OnBoardViewModel())
}
