//
//  EditorCoverView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorCoverView: View {
    
    @Binding var wrapper: CVEntityWrapper?
    @Binding var isLoading: Bool
    @Binding var isGenerating: Bool
    let generateClickHandler: () -> Void
    let textChangeHandler: (_ text: String) -> Void
    let doubleTapHandler: (_ page: Int, _ isCv: Bool) -> Void
    
    var body: some View {
        VStack {
            if let wrapper, wrapper.coverLetter != nil {
                CoverMakerPreviewView(cv: wrapper, isLoading: $isLoading, textChangeHandler: textChangeHandler).onTapGesture(count: 2) {
                    doubleTapHandler(0, false)
                }
            } else {
                EmptyCoverView(isGenerating: $isGenerating, generateClickHandler: generateClickHandler)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EmptyCoverView: View {
    
    @Binding var isGenerating: Bool
    let generateClickHandler: () -> Void
    
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            ColoredBackgroundLargeView()
            
            VStack {
                
                if isLoading {
                    ProgressAnimationView(isLoading: $isLoading, initialIcon: "wand.and.sparkles").frame(width: 96, height: 96)
                } else {
                    VStack (spacing: 8) {
                        
                        ZStack {
                            
                            Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 28, height: 28)
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }
                        
                        Text(NSLocalizedString("cover_letter_header", comment: "")).font(.largeTitle).bold().foregroundStyle(Color.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                        
                        Text(NSLocalizedString("cover_letter_description", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal)
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("generate", comment: ""), icon: "sparkle_colored_icon", isIconSystem: false, clickHandler: generateClickHandler).padding(.vertical)
                }
                
            }.onChange(of: isGenerating) {
                withAnimation {
                    isLoading = isGenerating
                }
            }
            
        }.borderLoadingAnimation(isAnimating: $isLoading, cornersRadius: 16.0).clipShape(RoundedRectangle(cornerRadius: 16.0)).aspectRatio(0.707070707, contentMode: .fit).padding(.vertical)
    }
}

#Preview {
    EditorCoverView(wrapper: .constant(nil), isLoading: .constant(false), isGenerating: .constant(false), generateClickHandler: {}, textChangeHandler: { t in }, doubleTapHandler: { i, b in })
}
