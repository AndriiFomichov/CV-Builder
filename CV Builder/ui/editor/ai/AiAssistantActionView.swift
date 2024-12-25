//
//  AiAssistantActionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct AiAssistantActionView: View {
    
    let action: AiAssistantAction
    var namespaceAnimation: Namespace.ID
    var ifHorizontal: Bool = false
    
    @State var animating = false
    
    var body: some View {
        Button (action: action.clickHandler) {
            VStack (spacing: 8) {
                if ifHorizontal {
                    HStack (spacing: 0) {
                        
                        ZStack {
                            
                            Image(systemName: action.icon).font(.headline).foregroundStyle(.accent).symbolEffect(.bounce, value: animating).matchedGeometryEffect(id: "Icon", in: namespaceAnimation)
                            
                        }.frame(width: 42, height: 42).background() {
                            RoundedRectangle(cornerRadius: 32.0).foregroundStyle(Color.window)
                        }.padding(8)
                        
                        VStack (spacing: 4) {
                            
                            Text(action.header).font(.title3).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2).matchedGeometryEffect(id: "Header", in: namespaceAnimation)
                            
                            Text(action.description).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3)
                            
                        }.padding(.trailing, 8).padding(.vertical)
                        
                        HStack (spacing: 4) {
                            
                            Text(NSLocalizedString("perform", comment: "")).font(.headline).bold().foregroundStyle(.white).multilineTextAlignment(.center).fixedSize()
                            
                            Image("sparkle_colored_icon").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.white).frame(width: 24, height: 24)
                            
                        }.padding(8).padding(.horizontal, 4).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }.padding(.trailing, 8)
                    }
                } else {
                    VStack (spacing: 0) {
                        
                        HStack (spacing: 0) {
                            ZStack {
                                
                                Image(systemName: action.icon).font(.headline).foregroundStyle(.accent).symbolEffect(.bounce, value: animating).matchedGeometryEffect(id: "Icon", in: namespaceAnimation)
                                
                            }.frame(width: 42, height: 42).background() {
                                RoundedRectangle(cornerRadius: 32.0).foregroundStyle(Color.window)
                            }.padding(8)
                            
                            Text(action.header).font(.title3).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2).matchedGeometryEffect(id: "Header", in: namespaceAnimation)
                        }.padding(.bottom, 4)
                        
                        Text(action.description).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3).padding(.horizontal, 8).padding(.bottom, 4)

                        HStack (spacing: 4) {
                            
                            Text(NSLocalizedString("perform", comment: "")).font(.headline).bold().foregroundStyle(.white).multilineTextAlignment(.center).fixedSize()
                            
                            Image("sparkle_colored_icon").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.white).frame(width: 24, height: 24)
                            
                        }.frame(maxWidth: .infinity).padding(8).padding(.horizontal, 4).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }.padding(8)
                    }
                }
            }.background() {
                
                ColorBackgroundView().matchedGeometryEffect(id: "Back", in: namespaceAnimation)
                
            }.clipShape(RoundedRectangle(cornerRadius: 20.0))
            
        }.onAppear() {
            withAnimation {
                animating = true
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    AiAssistantActionView(action: AiAssistantAction.getDefault(), namespaceAnimation: namespace)
}
