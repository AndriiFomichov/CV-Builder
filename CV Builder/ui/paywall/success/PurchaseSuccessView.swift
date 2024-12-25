//
//  PurchaseSuccessView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI
import ConfettiSwiftUI

struct PurchaseSuccessView: View {
    
    @Environment(\.dismiss) var dismiss

    @State var sensory = true
    @State var bounce = true
    @State var confettis = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ColoredBackgroundLargeView().ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    VStack (spacing: 8) {
                        
                        ZStack {
                            
                            Image(systemName: "checkmark.seal.fill").font(.title).foregroundStyle(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing)).contentTransition(.symbolEffect(.replace)).symbolEffect(.bounce, value: bounce)
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }
                        
                        Text(NSLocalizedString("premium_congratulation", comment: "")).font(.title2).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.horizontal)
                        
                        Text(NSLocalizedString("premium_congratulation_description", comment: "")).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.vertical, 8)
                    
                    VStack (spacing: 8) {
                        
                        MainButtonView(isSelected: .constant(true), text: NSLocalizedString("continue", comment: ""), clickHandler: {
                            dismiss()
                        })
                        
                    }.padding(.vertical).background() {
                        UnevenRoundedRectangle(topLeadingRadius: 24.0, topTrailingRadius: 24.0).fill(Color.windowColored).ignoresSafeArea()
                    }.padding(.horizontal, 8)
                    
                }.confettiCannon(counter: $confettis, num: 70, radius: 300)
                    .sensoryFeedback(.success, trigger: sensory)
                
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                withAnimation {
                    sensory.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        bounce.toggle()
                        confettis += 1
                    }
                }
            }
            
        }.tint(.accent)
    }
}

#Preview {
    PurchaseSuccessView()
}
