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
    @Binding var targetDescription: String
    @Binding var btnMainSelected: Bool
    @Binding var errorAlertShown: Bool
    let mainClickHandler: () -> Void
    let textChangeHandler: () -> Void
    
    @State var keyboardVisible = false
    
    var namespaceAnimation: Namespace.ID
    
    var body: some View {
        VStack (spacing: 8) {
            
            VStack (spacing: 0) {
                
                ScrollView (showsIndicators: false) {
                    VStack {
                        
                        Text(NSLocalizedString("field_job_title", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                        
                        TextInputView(text: $targetJob, icon: "briefcase.fill", hint: NSLocalizedString("field_job_title_hint", comment: "")).padding(.bottom)
                        
                        Text(NSLocalizedString("field_company_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                        
                        TextInputView(text: $targetCompany, icon: "building.columns.fill", hint: NSLocalizedString("field_company_name_hint", comment: "")).padding(.bottom)
                        
                        Text(NSLocalizedString("field_job_description_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                        
                        TextInputView(text: $targetDescription, icon: "text.page.fill", hint: NSLocalizedString("field_job_description_name_hint", comment: "")).padding(.bottom)
                        
                        TargetJobTipView(backColor: .window)
                        
                    }.padding()
                    
                }.alert(NSLocalizedString("enter_target_alert", comment: ""), isPresented: $errorAlertShown) {
                    Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
                }
                
            }.background() {
                
                ColorBackgroundView(size: 180).matchedGeometryEffect(id: "Back", in: namespaceAnimation)
                
            }.clipShape(RoundedRectangle(cornerRadius: 20.0)).padding(.horizontal).padding(.bottom, 8)
            
            if keyboardVisible {
                KeyboardActionsView(clearHanlder: {
                    self.endEditing()
                }, doneHanlder: {
                    self.endEditing()
                })
            } else {
                MainButtonView(isSelected: $btnMainSelected, text: NSLocalizedString("optimize_your_cv", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                    mainClickHandler()
                }).padding(.bottom)
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
    @Previewable @Namespace var namespace
    AiOptimizingTargetView(targetJob: .constant(""), targetCompany: .constant(""), targetDescription: .constant(""), btnMainSelected: .constant(false), errorAlertShown: .constant(false), mainClickHandler: {}, textChangeHandler: {}, namespaceAnimation: namespace)
}
