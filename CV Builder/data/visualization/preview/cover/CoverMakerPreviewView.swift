//
//  CoverMakerPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct CoverMakerPreviewView: View {
    
    var cv: CVEntityWrapper
    @Binding var isLoading: Bool
    let textChangeHandler: (_ text: String) -> Void
    var isDisabled: Bool = false
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    @State var loading = false
    
    var body: some View {
        GeometryReader { geo in
            
            let pageHeight = EditorPreviewSizeManager.getFinalHeight(geoWidth: geo.size.width, geoHeight: geo.size.height, margin: 32)
            let pageWidth = EditorPreviewSizeManager.getFinalWidth(geoWidth: geo.size.width, geoHeight: geo.size.height, margin: 32)
            
            VStack {
                switch cv.style {
                case 0:
                    StyleOneCoverPreviewView(cv: cv, textChangeHandler: textChangeHandler, isDisabled: isDisabled)
                case 1:
                    StyleTwoCoverPreviewView(cv: cv, textChangeHandler: textChangeHandler, isDisabled: isDisabled)
                default:
                    VStack {}
                }
                
            }.scaleEffect(pageHeight / height).frame(width: pageWidth, height: pageHeight).clipShape(RoundedRectangle(cornerRadius: 8.0)).borderLoadingAnimation(isAnimating: $loading, cornersRadius: 8.0).opacity(isLoading ? 0.6 : 1.0).frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.onChange(of: isLoading) {
            withAnimation {
                loading = isLoading
            }
        }
    }
}

#Preview {
    CoverMakerPreviewView(cv: CVEntityWrapper.getDefault(), isLoading: .constant(false), textChangeHandler: { t in })
}
