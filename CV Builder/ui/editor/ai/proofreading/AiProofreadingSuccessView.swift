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
    
    var namespaceAnimation: Namespace.ID
    
    var body: some View {
        VStack {
            
            VStack {
                
                CircleProgressView(progress: percentState, backColor: .window, progressColor: .accent).frame(maxHeight: 90).padding(.bottom)
                
                Text(NSLocalizedString("complete", comment: "")).font(.title).bold().foregroundStyle(Color.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 4).matchedGeometryEffect(id: "Header", in: namespaceAnimation)
                
                Text(NSLocalizedString("ai_proofread_success", comment: "")).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).matchedGeometryEffect(id: "Description", in: namespaceAnimation)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal, 12)
            
            HStack {
                TextsAnalyzedView(icon: "text.viewfinder", text: NSLocalizedString("texts_analyzed", comment: ""), number: texts, color: .text)
                TextsAnalyzedView(icon: "exclamationmark.triangle.fill", text: NSLocalizedString("typos_found", comment: ""), number: typos, color: .accent)
            }
            
        }.padding(8).background() {
            
            ColoredBackgroundLargeView().matchedGeometryEffect(id: "Back", in: namespaceAnimation)
            
        }.clipShape(RoundedRectangle(cornerRadius: 20.0)).padding(.horizontal).padding(.bottom).onAppear() {
            withAnimation {
                percentState = CGFloat(percent)
                textsState = texts
                typosState = typos
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    AiProofreadingSuccessView(percent: 1.0, texts: 23, typos: 0, namespaceAnimation: namespace)
}
