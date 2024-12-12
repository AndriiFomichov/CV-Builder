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
    
    var body: some View {
        VStack (spacing: 0) {
            ScrollView (showsIndicators: false) {
                LazyVGrid(columns: [ GridItem(.adaptive(minimum: 120)) ]) {
                    
                    ForEach(languages.indices, id: \.self) { index in
                        LanguageView(item: $languages[index], clickHandler: {
                            selectHandler(index)
                        })
                    }
                    
                }.padding()
                
            }.alert(NSLocalizedString("select_language_alert", comment: ""), isPresented: $errorAlertShown) {
                Button(NSLocalizedString("continue", comment: ""), role: .cancel, action: {})
            }
            
            MainButtonView(isSelected: $btnMainSelected, text: NSLocalizedString("optimize_your_cv", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: {
                mainClickHandler()
            }).padding(.vertical)
            
        }
    }
}

#Preview {
    AiTranslatingLanguagesView(languages: .constant([]), btnMainSelected: .constant(false), errorAlertShown: .constant(false), mainClickHandler: {}, selectHandler: { i in })
}
