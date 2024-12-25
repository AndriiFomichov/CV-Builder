//
//  CheckConnectionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.12.2024.
//

import SwiftUI

struct CheckConnectionView: View {
    
    var allowOffline: Bool = true
    var type: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var monitor = NetworkMonitor()
    
    @State var text: String = NSLocalizedString("continue_offline", comment: "")
    @State var icon: String = "wifi.slash"
    @State var iconColor: Color = .error
    @State var bounce = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ColoredBackgroundLargeView(animating: true).ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    VStack (spacing: 8) {
                        
                        ZStack {
                            
                            Image(systemName: icon).font(.title2).foregroundStyle(iconColor).contentTransition(.symbolEffect(.replace)).symbolEffect(.bounce, value: bounce)
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }
                        
                        Text(NSLocalizedString("no_connection_header", comment: "")).font(.title).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.horizontal)
                        
                        Text(NSLocalizedString(type == 1 ? "no_connection_description_purchase" : (allowOffline ? "no_connection_description_offline" : "no_connection_description"), comment: "")).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack (spacing: 8) {
                        
                        MainButtonView(isSelected: .constant(true), text: text, clickHandler: {
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
                    updateViewStatus()
                }
                
            }.onChange(of: monitor.status) {
                
                withAnimation {
                    updateViewStatus()
                }
                
                if monitor.status == .connected {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        dismiss()
                    }
                }
                
            }.sensoryFeedback(monitor.status == .connected ? .success : .error, trigger: bounce)
            
        }.tint(.accent)
    }
    
    private func updateViewStatus () {
        bounce.toggle()
        if monitor.status == .disconnected {
            text = allowOffline ? NSLocalizedString("continue_offline", comment: "") : NSLocalizedString("continue", comment: "")
            icon = "wifi.slash"
            iconColor = .error
        } else if monitor.status == .connected {
            text = NSLocalizedString("continue", comment: "")
            icon = "wifi"
            iconColor = .accent
        }
    }
}

#Preview {
    CheckConnectionView()
}
