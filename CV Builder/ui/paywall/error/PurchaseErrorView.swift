//
//  PurchaseErrorView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct PurchaseErrorView: View {
    
    @Environment(\.dismiss) var dismiss

    @State var bounce = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ColoredBackgroundLargeView().ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    VStack (spacing: 8) {
                        
                        ZStack {
                            
                            Image(systemName: "exclamationmark.circle.fill").font(.title2).foregroundStyle(.error).contentTransition(.symbolEffect(.replace)).symbolEffect(.bounce, value: bounce)
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }
                        
                        Text(NSLocalizedString("premium_error", comment: "")).font(.title3).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.horizontal)
                        
                        Text(NSLocalizedString("premium_error_description", comment: "")).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                        
                        ActionButtonView(icon: "paperplane.fill", text: NSLocalizedString("contact_us", comment: ""), clickHandler: {
                            let email = "enpowerapps.presentationmaker@gmail.com"
                            if let url = URL(string: "mailto:\(email)") {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url)
                                } else {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        }, addArrow: true).padding(.horizontal).padding(.top)
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.vertical, 8)
                    
                    VStack (spacing: 8) {
                        
                        MainButtonView(isSelected: .constant(true), text: NSLocalizedString("continue", comment: ""), clickHandler: {
                            dismiss()
                        })
                        
                    }.padding(.vertical).background() {
                        UnevenRoundedRectangle(topLeadingRadius: 24.0, topTrailingRadius: 24.0).fill(Color.windowColored).ignoresSafeArea()
                    }.padding(.horizontal, 8)
                }
                
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
                    bounce.toggle()
                }
            }.sensoryFeedback(.error, trigger: bounce)
            
        }.tint(.accent)
    }
}

#Preview {
    PurchaseErrorView()
}
