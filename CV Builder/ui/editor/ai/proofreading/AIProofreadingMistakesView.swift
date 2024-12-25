//
//  AIProofreadingMistakesView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct AIProofreadingMistakesView: View {
   
    let percent: Float
    let texts: Int
    let typos: Int
    let mistakes: [Mistake]
    
    @State var percentState: CGFloat = 0.0
    @State var textsState = 0
    @State var typosState = 0
    
    var namespaceAnimation: Namespace.ID
    
    var body: some View {
        ZStack (alignment: .bottom) {
            
            ScrollView (showsIndicators: false) {
                VStack {
                    
                    VStack (spacing: 0) {
                        
                        HStack (spacing: 0) {
                            
                            VStack {
                                
                                Text(NSLocalizedString("complete", comment: "")).font(.title2).bold().foregroundStyle(Color.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).matchedGeometryEffect(id: "Header", in: namespaceAnimation)
                                
                                Text(NSLocalizedString("ai_proofread_error", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).matchedGeometryEffect(id: "Description", in: namespaceAnimation)
                                
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(4)
                            
                            CircleProgressView(progress: percentState, lineWidth: 6, backColor: .window, progressColor: .error, font: .subheadline).frame(maxHeight: 54)
                            
                        }.padding(.bottom, 8)
                        
                        HStack {
                            TextsAnalyzedView(icon: "text.viewfinder", text: NSLocalizedString("texts_analyzed", comment: ""), number: texts, color: .text)
                            TextsAnalyzedView(icon: "exclamationmark.triangle.fill", text: NSLocalizedString("typos_found", comment: ""), number: typos, color: .error)
                        }
                        
                    }.padding(8).background() {
                        ColorBackgroundView().matchedGeometryEffect(id: "Back", in: namespaceAnimation)
                    }.clipShape(RoundedRectangle(cornerRadius: 20.0))
                    
                    ForEach(mistakes.indices, id: \.self) { index in
                        MistakeView(mistake: mistakes[index])
                    }
                    
                }.padding(.horizontal).padding(.bottom)
                
            }
            
            LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 36)
            
        }.onAppear() {
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
    AIProofreadingMistakesView(percent: 0.75, texts: 20, typos: 5, mistakes: [ Mistake.getDefault(), Mistake.getDefault() ], namespaceAnimation: namespace)
}
