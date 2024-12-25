//
//  AiTranslatingLanguagesView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 06.12.2024.
//

import SwiftUI

struct AiTranslatingLanguagesView: View {
    
    @Binding var languages: [Language]
    @Binding var btnMainSelected: Bool
    @Binding var errorAlertShown: Bool
    let mainClickHandler: () -> Void
    let selectHandler: (_ index: Int) -> Void
    
    var namespaceAnimation: Namespace.ID
    
    var body: some View {
        VStack (spacing: 8) {
            
            VStack (spacing: 0) {
                ScrollView (showsIndicators: false) {
                    VStack (spacing: 8) {
                        
                        Text(NSLocalizedString("select_language", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding([.leading, .top, .trailing])
                        
                        LazyVGrid(columns: [ GridItem(.adaptive(minimum: 120)) ]) {
                            
                            ForEach(languages.indices, id: \.self) { index in
                                LanguageView(item: $languages[index], clickHandler: {
                                    selectHandler(index)
                                })
                            }
                            
                        }.padding(.horizontal, 4).padding(.bottom)
                        
                    }
                    
                }.alert(NSLocalizedString("select_language_alert", comment: ""), isPresented: $errorAlertShown) {
                    Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
                }
                
            }.background() {
                
                ColorBackgroundView(size: 180).matchedGeometryEffect(id: "Back", in: namespaceAnimation)
                
            }.clipShape(RoundedRectangle(cornerRadius: 20.0)).padding(.horizontal).padding(.bottom, 8)
            
            MainButtonView(isSelected: $btnMainSelected, text: NSLocalizedString("optimize_your_cv", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                mainClickHandler()
            }).padding(.bottom)
            
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    AiTranslatingLanguagesView(languages: .constant([]), btnMainSelected: .constant(false), errorAlertShown: .constant(false), mainClickHandler: {}, selectHandler: { i in }, namespaceAnimation: namespace)
}
