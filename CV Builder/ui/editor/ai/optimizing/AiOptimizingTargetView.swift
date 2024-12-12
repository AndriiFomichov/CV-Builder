//
//  AiOptimizingTargetView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 06.12.2024.
//

import SwiftUI

struct AiOptimizingTargetView: View, KeyboardReadable {
    
    @Binding var targetJob: String
    @Binding var targetCompany: String
    @Binding var btnMainSelected: Bool
    @Binding var errorAlertShown: Bool
    let mainClickHandler: () -> Void
    let textChangeHandler: () -> Void
    
    @State var keyboardVisible = false
    
    var body: some View {
        VStack (spacing: 0) {
            ScrollView (showsIndicators: false) {
                VStack {
                    
                    Text(NSLocalizedString("field_job_title", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    TextInputView(text: $targetJob, icon: "briefcase.fill", hint: NSLocalizedString("field_job_title_hint", comment: "")).padding(.bottom)
                    
                    Text(NSLocalizedString("field_company_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    TextInputView(text: $targetCompany, icon: "building.columns.fill", hint: NSLocalizedString("field_company_name_hint", comment: "")).padding(.bottom)
                    
                }.padding()
                
            }.alert(NSLocalizedString("enter_target_alert", comment: ""), isPresented: $errorAlertShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
            }
            
            if keyboardVisible {
                KeyboardActionsView(clearHanlder: {
                    self.endEditing()
                }, doneHanlder: {
                    self.endEditing()
                })
            } else {
                MainButtonView(isSelected: $btnMainSelected, text: NSLocalizedString("optimize_your_cv", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                    mainClickHandler()
                }).padding(.vertical)
            }
            
        }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                keyboardVisible = newIsKeyboardVisible
            }
        }.onChange(of: [ targetJob, targetCompany ]) {
            textChangeHandler()
        }
    }
}

#Preview {
    AiOptimizingTargetView(targetJob: .constant(""), targetCompany: .constant(""), btnMainSelected: .constant(false), errorAlertShown: .constant(false), mainClickHandler: {}, textChangeHandler: {})
}
