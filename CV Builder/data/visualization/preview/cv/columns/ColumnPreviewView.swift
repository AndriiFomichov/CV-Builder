//
//  ColumnPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.11.2024.
//

import SwiftUI

struct ColumnPreviewView: View {
    
    var page: Int
    var isMainBlock: Bool
    var cv: CVEntityWrapper
    
    var addBlockPadding: Bool = false
    
    var headerTextColor: String
    var mainTextColor: String
    var blockBackgroundColors: [String]
    var blockStrokeColors: [String]
    
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
    
    @Binding var columnHeight: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            
            VStack (spacing: 0) {
                
                BlockViewGetter.getBlockByPosition(cv: cv, position: 0, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[0], blockStrokeColor: blockStrokeColors[0], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockOneHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 1, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[1], blockStrokeColor: blockStrokeColors[1], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockTwoHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 2, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[2], blockStrokeColor: blockStrokeColors[2], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockThreeHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 3, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[3], blockStrokeColor: blockStrokeColors[3], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockFourHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 4, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[4], blockStrokeColor: blockStrokeColors[4], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockFiveHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 5, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[5], blockStrokeColor: blockStrokeColors[5], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockSixHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 6, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[6], blockStrokeColor: blockStrokeColors[6], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockSevenHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 7, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[7], blockStrokeColor: blockStrokeColors[7], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockEightHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 8, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[8], blockStrokeColor: blockStrokeColors[8], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockNineHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 9, page: page, isMainBlock: true, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[9], blockStrokeColor: blockStrokeColors[9], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockTenHeight = size.height
                })
                BlockViewGetter.getBlockByPosition(cv: cv, position: 10, page: page, isMainBlock: true, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[10], blockStrokeColor: blockStrokeColors[10], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                    blockElevenHeight = size.height
                })
                
                Spacer()
                
            }.frame(maxHeight: .infinity).onAppear() {
                columnHeight = geo.size.height
            }
        }
    }
}

#Preview {
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
    
    @Previewable @State var mainColumnHeight: CGFloat = 0.0
    
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    ColumnPreviewView(page: 0, isMainBlock: false, cv: wrapper, headerTextColor: "#FFFFFF", mainTextColor: "#FFFFFF", blockBackgroundColors: ["#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF"], blockStrokeColors: ["","","","","","","","","","",""], blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, columnHeight: $mainColumnHeight)
}
