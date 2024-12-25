//
//  StyleOnePageTwoPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct StyleOnePageTwoPreviewView: View {
    
    var cv: CVEntityWrapper
    var page: Int
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
//    @Binding var isUpdated: Bool
    
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
    
    var body: some View {
        HStack (spacing: 0) {
            
            ColumnPreviewView(page: page, isMainBlock: false, cv: cv, addBlockPadding: true, headerTextColor: "#FFFFFF", mainTextColor: "#FFFFFF", blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""], blockOneHeight: $blockAdditionalOneHeight, blockTwoHeight: $blockAdditionalTwoHeight, blockThreeHeight: $blockAdditionalThreeHeight, blockFourHeight: $blockAdditionalFourHeight, blockFiveHeight: $blockAdditionalFiveHeight, blockSixHeight: $blockAdditionalSixHeight, blockSevenHeight: $blockAdditionalSevenHeight, blockEightHeight: $blockAdditionalEightHeight, blockNineHeight: $blockAdditionalNineHeight, blockTenHeight: $blockAdditionalTenHeight, blockElevenHeight: $blockAdditionalElevenHeight, columnHeight: $additionalColumnHeight).frame(width: width * 0.38).background() {
                Color(hex: "#262626")
            }
            
            ColumnPreviewView(page: page, isMainBlock: true, cv: cv, addBlockPadding: true, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","#EBEBEB","","#EBEBEB","","#EBEBEB","","#EBEBEB","","#EBEBEB",""], blockStrokeColors: ["","","","","","","","","","",""], blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, columnHeight: $mainColumnHeight).frame(width: width * 0.62)
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#F5F5F5")
        }
    }
}

#Preview {
    @Previewable @State var isUpdated: Bool = false
    
    @Previewable @State var blockOneHeight: CGFloat = 0.0
    @Previewable @State var blockTwoHeight: CGFloat = 0.0
    @Previewable @State var blockThreeHeight: CGFloat = 0.0
    @Previewable @State var blockFourHeight: CGFloat = 0.0
    @Previewable @State var blockFiveHeight: CGFloat = 0.0
    @Previewable @State var blockSixHeight: CGFloat = 0.0
    @Previewable @State var blockSevenHeight: CGFloat = 0.0
    @Previewable @State var blockEightHeight: CGFloat = 0.0
    @Previewable @State var blockNineHeight: CGFloat = 0.0
    @Previewable @State var blockTenHeight: CGFloat = 0.0
    @Previewable @State var blockElevenHeight: CGFloat = 0.0
    
    @Previewable @State var blockAdditionalOneHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalTwoHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalThreeHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalFourHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalFiveHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalSixHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalSevenHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalEightHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalNineHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalTenHeight: CGFloat = 0.0
    @Previewable @State var blockAdditionalElevenHeight: CGFloat = 0.0
    
    @Previewable @State var mainColumnHeight: CGFloat = 0.0
    @Previewable @State var additionalColumnHeight: CGFloat = 0.0
    
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
//    @Previewable @State var wrapper = CVVisualizationBuilder().updatePositionsWrapperOne(style: Style.getDefault(), wrapper: CVEntityWrapper.getDefault())
    
    StyleOnePageTwoPreviewView(cv: wrapper, page: 1, blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, blockAdditionalOneHeight: $blockAdditionalOneHeight, blockAdditionalTwoHeight: $blockAdditionalTwoHeight, blockAdditionalThreeHeight: $blockAdditionalThreeHeight, blockAdditionalFourHeight: $blockAdditionalFourHeight, blockAdditionalFiveHeight: $blockAdditionalFiveHeight, blockAdditionalSixHeight: $blockAdditionalSixHeight, blockAdditionalSevenHeight: $blockAdditionalSevenHeight, blockAdditionalEightHeight: $blockAdditionalEightHeight, blockAdditionalNineHeight: $blockAdditionalNineHeight, blockAdditionalTenHeight: $blockAdditionalTenHeight, blockAdditionalElevenHeight: $blockAdditionalElevenHeight, mainColumnHeight: $mainColumnHeight, additionalColumnHeight: $additionalColumnHeight)
}
