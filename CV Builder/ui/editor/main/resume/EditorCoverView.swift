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
            Color.background
            
            Image("large_line_illustration").renderingMode(.template).centerCropped().foregroundStyle(Color.backgroundDark)
            
            VStack {
                
                VStack {
                    
                    Text(NSLocalizedString("cover_letter_header", comment: "")).font(.largeTitle).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 8)
                    
                    Text(NSLocalizedString("cover_letter_description", comment: "")).font(.subheadline).foregroundStyle(Color.textAdditional).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.horizontal)
                
                Button (action: generateClickHandler) {
                    HStack {
                        Text(NSLocalizedString("generate", comment: "")).font(.headline).bold().foregroundStyle(Color.white)
                        
                        Image("sparkle_colored_icon").renderingMode(.template).resizable().scaledToFit().foregroundStyle(Color.white).frame(width: 24, height: 24).padding(.leading, 2)
                        
                        if isLoading {
                            ProgressView().tint(Color.white).padding(.leading, 4)
                        }
                        
                    }.frame(maxWidth: .infinity).padding().background() {
                        RoundedRectangle(cornerRadius: 16.0).fill(isLoading ? LinearGradient(colors: [.accentLight, .accentLight], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [.accentDarker, .accent], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                }.padding()
                
            }.onChange(of: isGenerating) {
                withAnimation {
                    isLoading = isGenerating
                }
            }
            
        }.borderLoadingAnimation(isAnimating: $isLoading, cornersRadius: 12.0).clipShape(RoundedRectangle(cornerRadius: 12.0)).aspectRatio(0.707070707, contentMode: .fit).padding(.vertical, 16)
    }
}

#Preview {
    EditorCoverView(wrapper: .constant(CVEntityWrapper.getDefault()), isLoading: .constant(false), isGenerating: .constant(false), generateClickHandler: {}, textChangeHandler: { t in }, doubleTapHandler: { i, b in })
}
