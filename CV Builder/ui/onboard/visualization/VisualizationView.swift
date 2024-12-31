//
//  VisualizationView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct VisualizationView: View {
    
    @Binding var isGenerating: Bool
    @Binding var item: CVEntityWrapper?
    var clickHandler: (_ page: Int) -> Void
    
    var body: some View {
        VStack (spacing: 0) {
            
            ZStack {
                
                if let item {
                    ZStack (alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))
                        
                        CVMakerPreviewView(cv: item, isLoading: .constant(false), pageUpdateHandler: {
                            
                            savePagesUpdated()
                            
                        }, tapHandler: { page, _ in
                            
                            clickHandler(page)
                            
                        }, doubleTapHandler: { page, _ in
                            
                            clickHandler(page)
                            
                        }).padding(.horizontal)
                        
                        Button (action: {
                            clickHandler(0)
                        }) {
                            ZStack {
                                
                                Image(systemName: "plus.magnifyingglass").font(.headline).foregroundStyle(.white)
                                
                            }.frame(width: 48, height: 48).background() {
                                Circle().fill(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            }.padding()
                        }
                    }
                    
                } else if isGenerating {
                    RoundedRectangle(cornerRadius: 12.0).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.backgroundDark), shape: .rounded(.radius(12.0, style: .circular)))
                } else {
                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo)
                }
                
            }.padding(8)
            
            if let item {
                VStack {
                    
                    Text(NSLocalizedString(item.wrapperName, comment: "")).font(.headline).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).lineLimit(2)
                    
                }.padding([.leading, .bottom, .trailing], 8)
            }
            
        }.background() {
            
            RoundedRectangle(cornerRadius: 20.0).fill(Color.window).borderLoadingAnimation(isAnimating: $isGenerating, cornersRadius: 20.0)
            
        }
    }
    
    private func savePagesUpdated () {
        self.item = self.item
    }
}

#Preview {
    @Previewable @State var item: CVEntityWrapper? = CVEntityWrapper.getDefault()
    @Previewable @State var isGenerating = true
    VisualizationView(isGenerating: $isGenerating, item: $item, clickHandler: { i in })
}
