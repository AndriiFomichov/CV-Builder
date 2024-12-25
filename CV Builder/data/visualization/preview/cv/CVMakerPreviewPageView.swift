//
//  CVMakerPreviewPageView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 04.12.2024.
//

import SwiftUI

struct CVMakerPreviewPageView: View {
    
    var cv: CVEntityWrapper
    var page: Int
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    @Binding var isLoading: Bool
 
    @Binding var blockOneHeight: CGFloat
    @Binding var blockTwoHeight: CGFloat
    @Binding var blockThreeHeight: CGFloat
    @Binding var blockFourHeight: CGFloat
    @Binding var blockFiveHeight: CGFloat
    @Binding var blockSixHeight: CGFloat
    @Binding var blockSevenHeight: CGFloat
    @Binding var blockEightHeight: CGFloat
    @Binding var blockNineHeight: CGFloat
    @Binding var blockTenHeight: CGFloat
    @Binding var blockElevenHeight: CGFloat
    
    @Binding var blockAdditionalOneHeight: CGFloat
    @Binding var blockAdditionalTwoHeight: CGFloat
    @Binding var blockAdditionalThreeHeight: CGFloat
    @Binding var blockAdditionalFourHeight: CGFloat
    @Binding var blockAdditionalFiveHeight: CGFloat
    @Binding var blockAdditionalSixHeight: CGFloat
    @Binding var blockAdditionalSevenHeight: CGFloat
    @Binding var blockAdditionalEightHeight: CGFloat
    @Binding var blockAdditionalNineHeight: CGFloat
    @Binding var blockAdditionalTenHeight: CGFloat
    @Binding var blockAdditionalElevenHeight: CGFloat
    
    @Binding var mainColumnHeight: CGFloat
    @Binding var additionalColumnHeight: CGFloat
    
    @Binding var mainColumnNextPagesHeight: CGFloat
    @Binding var additionalColumnNextPagesHeight: CGFloat
    
    let doubleTapHandler: (_ page: Int, _ isCv: Bool) -> Void
    
    @State var loading = false
    
    var body: some View {
        GeometryReader { geoInner in
            
            let pageHeight = EditorPreviewSizeManager.getFinalHeight(geoWidth: geoInner.size.width, geoHeight: geoInner.size.height)
            let pageWidth = EditorPreviewSizeManager.getFinalWidth(geoWidth: geoInner.size.width, geoHeight: geoInner.size.height)
            
            
            VStack {
                
                switch cv.style {
                case 0:
                    if page == 0 {
                        StyleOnePageOnePreviewView(cv: cv, width: width, height: height, blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, blockAdditionalOneHeight: $blockAdditionalOneHeight, blockAdditionalTwoHeight: $blockAdditionalTwoHeight, blockAdditionalThreeHeight: $blockAdditionalThreeHeight, blockAdditionalFourHeight: $blockAdditionalFourHeight, blockAdditionalFiveHeight: $blockAdditionalFiveHeight, blockAdditionalSixHeight: $blockAdditionalSixHeight, blockAdditionalSevenHeight: $blockAdditionalSevenHeight, blockAdditionalEightHeight: $blockAdditionalEightHeight, blockAdditionalNineHeight: $blockAdditionalNineHeight, blockAdditionalTenHeight: $blockAdditionalTenHeight, blockAdditionalElevenHeight: $blockAdditionalElevenHeight, mainColumnHeight: $mainColumnHeight, additionalColumnHeight: $additionalColumnHeight)
                    } else {
                        StyleOnePageTwoPreviewView(cv: cv, page: page, width: width, height: height, blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, blockAdditionalOneHeight: $blockAdditionalOneHeight, blockAdditionalTwoHeight: $blockAdditionalTwoHeight, blockAdditionalThreeHeight: $blockAdditionalThreeHeight, blockAdditionalFourHeight: $blockAdditionalFourHeight, blockAdditionalFiveHeight: $blockAdditionalFiveHeight, blockAdditionalSixHeight: $blockAdditionalSixHeight, blockAdditionalSevenHeight: $blockAdditionalSevenHeight, blockAdditionalEightHeight: $blockAdditionalEightHeight, blockAdditionalNineHeight: $blockAdditionalNineHeight, blockAdditionalTenHeight: $blockAdditionalTenHeight, blockAdditionalElevenHeight: $blockAdditionalElevenHeight, mainColumnHeight: $mainColumnNextPagesHeight, additionalColumnHeight: $additionalColumnNextPagesHeight)
                    }
                case 1:
                    if page == 0 {
                        StyleTwoPageOnePreviewView(cv: cv, width: width, height: height, blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, blockAdditionalOneHeight: $blockAdditionalOneHeight, blockAdditionalTwoHeight: $blockAdditionalTwoHeight, blockAdditionalThreeHeight: $blockAdditionalThreeHeight, blockAdditionalFourHeight: $blockAdditionalFourHeight, blockAdditionalFiveHeight: $blockAdditionalFiveHeight, blockAdditionalSixHeight: $blockAdditionalSixHeight, blockAdditionalSevenHeight: $blockAdditionalSevenHeight, blockAdditionalEightHeight: $blockAdditionalEightHeight, blockAdditionalNineHeight: $blockAdditionalNineHeight, blockAdditionalTenHeight: $blockAdditionalTenHeight, blockAdditionalElevenHeight: $blockAdditionalElevenHeight, mainColumnHeight: $mainColumnHeight, additionalColumnHeight: $additionalColumnHeight)
                    } else {
                        StyleTwoPageTwoPreviewView(cv: cv, page: page, width: width, height: height, blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, blockAdditionalOneHeight: $blockAdditionalOneHeight, blockAdditionalTwoHeight: $blockAdditionalTwoHeight, blockAdditionalThreeHeight: $blockAdditionalThreeHeight, blockAdditionalFourHeight: $blockAdditionalFourHeight, blockAdditionalFiveHeight: $blockAdditionalFiveHeight, blockAdditionalSixHeight: $blockAdditionalSixHeight, blockAdditionalSevenHeight: $blockAdditionalSevenHeight, blockAdditionalEightHeight: $blockAdditionalEightHeight, blockAdditionalNineHeight: $blockAdditionalNineHeight, blockAdditionalTenHeight: $blockAdditionalTenHeight, blockAdditionalElevenHeight: $blockAdditionalElevenHeight, mainColumnHeight: $mainColumnNextPagesHeight, additionalColumnHeight: $additionalColumnNextPagesHeight)
                    }
                    
                default:
                    VStack {}.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
            }.scaleEffect(pageHeight / height).frame(width: pageWidth, height: pageHeight).clipShape(RoundedRectangle(cornerRadius: 16.0))
                .opacity(isLoading ? 0.6 : 1.0)
                .borderLoadingAnimation(isAnimating: $loading, cornersRadius: 16.0)
                .onTapGesture(count: 2) {
                doubleTapHandler(page, true)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.onChange(of: isLoading) {
            withAnimation {
                loading = isLoading
            }
        }
    }
}

#Preview {
    CVMakerPreviewPageView(cv: CVEntityWrapper.getDefault(), page: 0, isLoading: .constant(false), blockOneHeight: .constant(0.0), blockTwoHeight: .constant(0.0), blockThreeHeight: .constant(0.0), blockFourHeight: .constant(0.0), blockFiveHeight: .constant(0.0), blockSixHeight: .constant(0.0), blockSevenHeight: .constant(0.0), blockEightHeight: .constant(0.0), blockNineHeight: .constant(0.0), blockTenHeight: .constant(0.0), blockElevenHeight: .constant(0.0), blockAdditionalOneHeight: .constant(0.0), blockAdditionalTwoHeight: .constant(0.0), blockAdditionalThreeHeight: .constant(0.0), blockAdditionalFourHeight: .constant(0.0), blockAdditionalFiveHeight: .constant(0.0), blockAdditionalSixHeight: .constant(0.0), blockAdditionalSevenHeight: .constant(0.0), blockAdditionalEightHeight: .constant(0.0), blockAdditionalNineHeight: .constant(0.0), blockAdditionalTenHeight: .constant(0.0), blockAdditionalElevenHeight: .constant(0.0), mainColumnHeight: .constant(0.0), additionalColumnHeight: .constant(0.0), mainColumnNextPagesHeight: .constant(0.0), additionalColumnNextPagesHeight: .constant(0.0), doubleTapHandler: { i, b in })
}
