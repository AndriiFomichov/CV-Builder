//
//  SubscriptionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct SubscriptionView: View {
    
    @Binding var subscription: Subscription
    var clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            ZStack (alignment: .topTrailing) {
                
                HStack (spacing: 0) {
                    
                    SelectedIndicatorView(isSelected: $isSelected, type: 1).padding(12)
                    
                    VStack {
                        
                        if let trialText = subscription.freeTrial {
                            Text(trialText).font(.subheadline).foregroundColor(isSelected ? .text : .textAdditional).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        }
                        
                        Text(subscription.price).font(.title3).bold().foregroundColor(.accent).foregroundLinearGradient(colors: isSelected ? [ .accentLight, .accent ] : [ .text ], startPoint: .topLeading, endPoint: .bottomTrailing).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).scaleEffect(isSelected ? 1.02 : 1.0)
                        
                    }.padding(.vertical, 8)
                    
                    Text(subscription.period).font(.subheadline).foregroundColor(isSelected ? .accent : .textAdditional).multilineTextAlignment(.trailing).padding(12)
                    
                }.background() {
                    RoundedRectangle(cornerRadius: 24.0).fill(Color.window)
                }.overlay {
                    RoundedRectangle(cornerRadius: 24.0).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
                }.padding(.bottom, 8)
                
                if let amount = subscription.saveAmount {
                    Text(amount).font(.subheadline).bold().foregroundColor(.white).multilineTextAlignment(.center).padding(6).background() {
                        RoundedRectangle(cornerRadius: 32.0).fill(.accent)
                    }.padding(.top, -16).padding(.trailing)
                }
                
            }.scaleEffect(isSelected ? 1.02 : 1.0)
            
        }.onAppear() {
            withAnimation {
                isSelected = subscription.isSelected
            }
        }.onChange(of: subscription.isSelected) {
            withAnimation {
                isSelected = subscription.isSelected
            }
        }
    }
}

#Preview {
    SubscriptionView(subscription: .constant(Subscription.getDefault()), clickHandler: {})
}
