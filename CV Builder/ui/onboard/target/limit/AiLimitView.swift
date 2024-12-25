//
//  AiLimitView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct AiLimitView: View {
    
    let type: Int
    var addNumber = true
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AiLimitViewModel()
    
    @State var iconAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ColoredBackgroundLargeView(animating: true).ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    ZStack {
                        Color.clear
                        
                        VStack (spacing: 12) {
                            
                            Text(NSLocalizedString("ai_limit_header", comment: "")).font(.title).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                            
                            Text(viewModel.description).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.bottom, 8)
                            
                            if addNumber {
                                HStack (spacing: 8) {
                                    
                                    VStack (spacing: 8) {
                                        Text(viewModel.tipHeader).font(.title2).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                        
                                        Text(viewModel.tipDescription).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    }
                                    
                                    Image(systemName: "checkmark.seal.fill").font(.title2).foregroundStyle(.accent).symbolEffect(.bounce, value: iconAnimating).onAppear() {
                                        iconAnimating = true
                                    }
                                    
                                }.padding().background() {
                                    RoundedRectangle(cornerRadius: 20.0).fill(.window)
                                }
                            }
                            
                        }.padding().padding(.bottom, 24)
                    }
                    
                    ZStack (alignment: .top) {
                        
                        VStack (spacing: 12) {
                            
                            Text(NSLocalizedString("contact_us_for_attempts", comment: "")).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                            
                            ActionButtonView(icon: "paperplane.fill", text: NSLocalizedString("contact_us", comment: ""), clickHandler: {
                                let email = "enpowerapps.presentationmaker@gmail.com"
                                if let url = URL(string: "mailto:\(email)") {
                                    if #available(iOS 10.0, *) {
                                        UIApplication.shared.open(url)
                                    } else {
                                        UIApplication.shared.openURL(url)
                                    }
                                }
                            }, addArrow: true).padding(.horizontal)
                            
                            MainButtonView(isSelected: .constant(true), text: NSLocalizedString("continue", comment: ""), clickHandler: {
                                dismiss()
                            }).padding(.top)
                            
                        }.padding(.vertical).padding(.top).background() {
                            UnevenRoundedRectangle(topLeadingRadius: 24.0, topTrailingRadius: 24.0).fill(.windowColored).ignoresSafeArea()
                        }.padding(.horizontal, 8)
                        
                        ZStack {
                            
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 28, height: 28)
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }.offset(y: -32)
                        
                    }
                    
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
                viewModel.updateData(type: type)
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    AiLimitView(type: 0)
}
