//
//  CustomAIActionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.12.2024.
//

import SwiftUI

struct CustomAIActionView: View {
    
    let initialText: String
    let actionHandler: (_ action: String) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    @State var action = ""
    @State var prompt = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ColoredBackgroundLargeView().ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    VStack (spacing: 8) {
                        
                        TextInputView(text: $action, icon: "wand.and.sparkles", hint: NSLocalizedString("enter_command", comment: ""), limit: 75)
                        
                        Text(prompt).font(.subheadline).foregroundStyle(Color.accentLight).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(5)
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal)
                    
                    VStack (spacing: 8) {
                        
                        MainButtonView(isSelected: .constant(true), text: NSLocalizedString("apply", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                            actionHandler(action)
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
                prompt = updatePrompt()
            }.onChange(of: action) {
                prompt = updatePrompt()
            }
            
        }.tint(.accent)
    }
    
    private func updatePrompt () -> String {
        return action.isEmpty ? initialText : action + ":\n" + initialText
    }
}

#Preview {
    CustomAIActionView(initialText: "Profile description", actionHandler: { a in })
}
