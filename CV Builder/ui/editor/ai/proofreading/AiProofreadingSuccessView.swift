//
//  AiProofreadingSuccessView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct AiProofreadingSuccessView: View {
    
    let percent: Float
    let texts: Int
    let typos: Int
    
    @State var percentState: CGFloat = 0.0
    @State var textsState = 0
    @State var typosState = 0
    
    var body: some View {
        VStack {
            
            VStack {
                
                CircleProgressView(progress: percentState, backColor: .window, progressColor: .success).frame(maxHeight: 90).padding(.bottom)
                
                Text(NSLocalizedString("complete", comment: "")).font(.title).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 8)
                
                Text(NSLocalizedString("ai_proofread_success", comment: "")).foregroundStyle(Color.text).multilineTextAlignment(.center)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal, 12)
            
            HStack {
                TextsAnalyzedView(icon: "text.magnifyingglass", text: NSLocalizedString("texts_analyzed", comment: ""), number: texts, color: .text)
                TextsAnalyzedView(icon: "exclamationmark.triangle.fill", text: NSLocalizedString("typos_found", comment: ""), number: typos, color: .success)
            }
            
        }.padding(8).background() {
            ZStack (alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 20.0).fill(Color.backgroundDark)
                
                Image("small_line_two_illustration").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.backgroundDarker)
            }
        }.padding().onAppear() {
            withAnimation {
                percentState = CGFloat(percent)
                textsState = texts
                typosState = typos
            }
        }
    }
}

#Preview {
    AiProofreadingSuccessView(percent: 1.0, texts: 23, typos: 0)
}
