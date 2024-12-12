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
            
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                ZStack {
                    Color.backgroundDark.ignoresSafeArea()
                    
                    Image("large_line_illustration").renderingMode(.template).centerCropped().foregroundStyle(.backgroundDarker)
                    
                    VStack {
                        
                        Image("logo_1024_rounded").resizable().scaledToFit().frame(width: 64, height: 64).clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(.bottom)
                        
                        Text(NSLocalizedString("front_header", comment: "")).font(.title).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
                        
                        HStack {
                            Text(NSLocalizedString("front_description", comment: "")).foregroundStyle(Color.text).multilineTextAlignment(.center)
                            
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 24, height: 24)
                        }
                        
                    }.padding().padding(.bottom, 24)
                }
                
                VStack {
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("get_started", comment: ""), clickHandler: {
                        viewModel.nextStep()
                    }).padding(.vertical)
                    
                }.background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
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
