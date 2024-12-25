//
//  ProfileFillAlertView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 24.12.2024.
//

import SwiftUI

struct ProfileFillAlertView: View {
    
    @Environment(\.dismiss) var dismiss

    @State var bounce = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ColoredBackgroundLargeView().ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    VStack (spacing: 8) {
                        
                        ZStack {
                            
                            Image(systemName: "person.crop.circle.badge.exclamationmark").font(.title2).foregroundStyle(.accent).contentTransition(.symbolEffect(.replace)).symbolEffect(.bounce, value: bounce)
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }
                        
                        Text(NSLocalizedString("profile_fill_alert_header", comment: "")).font(.title).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.horizontal)
                        
                        Text(NSLocalizedString("profile_fill_alert_description", comment: "")).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    
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
    ProfileFillAlertView()
}
