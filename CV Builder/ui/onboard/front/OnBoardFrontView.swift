//
//  OnBoardFrontView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct OnBoardFrontView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var parentViewModel: OnBoardViewModel
    @StateObject var viewModel = OnBoardFrontViewModel()
    
    @Binding var sheetClosed: Bool
    
    var body: some View {
        ZStack {
            
            ColoredBackgroundLargeView(animating: true).ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                ZStack {
                    Color.clear
                    FrontIllustrationView().frame(maxHeight: 700).padding(42)
                }
                
                ZStack (alignment: .top) {
                    
                    VStack (spacing: 8) {
                        
                        Text(NSLocalizedString("front_header", comment: "")).font(.title).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.horizontal)
                        
                        Text(NSLocalizedString("front_description", comment: "")).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                        
                        MainButtonView(isSelected: .constant(true), text: NSLocalizedString("get_started", comment: ""), clickHandler: {
                            viewModel.nextStep()
                        }).padding(.top)
                        
                    }.padding(.vertical).padding(.top).background() {
                        UnevenRoundedRectangle(topLeadingRadius: 24.0, topTrailingRadius: 24.0).fill(Color.windowColored).ignoresSafeArea()
                    }.padding(.horizontal, 8)
                    
                    ZStack {
                        
                        Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 28, height: 28)
                        
                    }.frame(width: 54, height: 54).background() {
                        RoundedRectangle(cornerRadius: 32.0).fill(.window)
                    }.offset(y: -32)
                    
                }
            }
            
        }.navigationBarTitleDisplayMode(.inline).navigationDestination(isPresented: $viewModel.nextStepPresented) {
            OnBoardStyleView()
        }.onChange(of: sheetClosed) {
            if sheetClosed {
                dismiss()
            }
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }
    }
}

#Preview {
    OnBoardFrontView(sheetClosed: .constant(false)).environmentObject(OnBoardViewModel())
}
