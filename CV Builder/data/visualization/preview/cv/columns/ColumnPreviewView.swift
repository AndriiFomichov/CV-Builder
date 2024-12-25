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
                
                ForEach(0..<11, id: \.self) { index in
                    BlockViewGetter.getBlockByPosition(cv: cv, position: index, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: index, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: index, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
                        updateHeight(position: index, height: size.height)
                    })
                }
                
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 0, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 0, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 0, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockOneHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 1, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 1, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 1, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockTwoHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 2, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 2, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 2, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockThreeHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 3, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 3, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 3, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockFourHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 4, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 4, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 4, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockFiveHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 5, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 5, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 5, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockSixHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 6, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 6, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 6, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockSevenHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 7, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 7, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 7, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockEightHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 8, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 8, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 8, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockNineHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 9, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 9, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 9, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockTenHeight = size.height
//                })
//                BlockViewGetter.getBlockByPosition(cv: cv, position: 10, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 10, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: 10, page: page, isMainBlock: isMainBlock)], addBlockPadding: addBlockPadding).readSize(onChange: { size in
//                    blockElevenHeight = size.height
//                })
                
//                Spacer()
                
            }.onAppear() {
                if page == 0 || page == 1 {
                    columnHeight = geo.size.height
                }
            }
        }
    }
    
    private func updateHeight (position: Int, height: CGFloat) {
        switch position {
        case 0:
            blockOneHeight = height
        case 1:
            blockTwoHeight = height
        case 2:
            blockThreeHeight = height
        case 3:
            blockFourHeight = height
        case 4:
            blockFiveHeight = height
        case 5:
            blockSixHeight = height
        case 6:
            blockSevenHeight = height
        case 7:
            blockEightHeight = height
        case 8:
            blockNineHeight = height
        case 9:
            blockTenHeight = height
        case 10:
            blockElevenHeight = height
        default:
            break
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
