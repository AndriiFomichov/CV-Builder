//
//  CVMakerPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI
import SwiftUIPager

struct CVMakerPreviewView: View {
    
    var cv: CVEntityWrapper
    
    let pageUpdateHandler: () -> Void
    let tapHandler: (_ page: Int, _ isCv: Bool) -> Void
    let doubleTapHandler: (_ page: Int, _ isCv: Bool) -> Void
    
    let pages: Int
    
    @Binding var isLoading: Bool
    
    @State var blockOneHeight: CGFloat = 0.0
    @State var blockTwoHeight: CGFloat = 0.0
    @State var blockThreeHeight: CGFloat = 0.0
    @State var blockFourHeight: CGFloat = 0.0
    @State var blockFiveHeight: CGFloat = 0.0
    @State var blockSixHeight: CGFloat = 0.0
    @State var blockSevenHeight: CGFloat = 0.0
    @State var blockEightHeight: CGFloat = 0.0
    @State var blockNineHeight: CGFloat = 0.0
    @State var blockTenHeight: CGFloat = 0.0
    @State var blockElevenHeight: CGFloat = 0.0
    
    @State var blockAdditionalOneHeight: CGFloat = 0.0
    @State var blockAdditionalTwoHeight: CGFloat = 0.0
    @State var blockAdditionalThreeHeight: CGFloat = 0.0
    @State var blockAdditionalFourHeight: CGFloat = 0.0
    @State var blockAdditionalFiveHeight: CGFloat = 0.0
    @State var blockAdditionalSixHeight: CGFloat = 0.0
    @State var blockAdditionalSevenHeight: CGFloat = 0.0
    @State var blockAdditionalEightHeight: CGFloat = 0.0
    @State var blockAdditionalNineHeight: CGFloat = 0.0
    @State var blockAdditionalTenHeight: CGFloat = 0.0
    @State var blockAdditionalElevenHeight: CGFloat = 0.0
    
    @State var mainColumnHeight: CGFloat = 0.0
    @State var additionalColumnHeight: CGFloat = 0.0
    
    @State var mainColumnNextPagesHeight: CGFloat = 0.0
    @State var additionalColumnNextPagesHeight: CGFloat = 0.0
    
//    @State private var scrollContentHeight: CGFloat = 0.0
//    @State private var position = ScrollPosition(edge: .top)
    
    @StateObject var page: Page = .first()
    
    init(cv: CVEntityWrapper, isLoading: Binding<Bool>, pageUpdateHandler: @escaping () -> Void, tapHandler: @escaping (_ page: Int, _ isCv: Bool) -> Void, doubleTapHandler: @escaping (_ page: Int, _ isCv: Bool) -> Void) {
        self._isLoading = isLoading
        let defaults = CVDefaultsWrapper()
//        self.cv = cv
        self.cv = defaults.fullfill(wrapper: cv)
//        self.style = PreloadedDatabase.getStyleId(id: wrapper.style)
        self.pageUpdateHandler = pageUpdateHandler
        self.tapHandler = tapHandler
        self.doubleTapHandler = doubleTapHandler
        pages = CVVisualizationBuilder.getWrapperPagesCount(wrapper: cv)
    }
    
    var body: some View {
        GeometryReader { geo in
            
            Pager(page: page, data: Array(0..<pages), id: \.self, content: { index in
                
                CVMakerPreviewPageView(cv: cv, page: index, isLoading: $isLoading, blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, blockAdditionalOneHeight: $blockAdditionalOneHeight, blockAdditionalTwoHeight: $blockAdditionalTwoHeight, blockAdditionalThreeHeight: $blockAdditionalThreeHeight, blockAdditionalFourHeight: $blockAdditionalFourHeight, blockAdditionalFiveHeight: $blockAdditionalFiveHeight, blockAdditionalSixHeight: $blockAdditionalSixHeight, blockAdditionalSevenHeight: $blockAdditionalSevenHeight, blockAdditionalEightHeight: $blockAdditionalEightHeight, blockAdditionalNineHeight: $blockAdditionalNineHeight, blockAdditionalTenHeight: $blockAdditionalTenHeight, blockAdditionalElevenHeight: $blockAdditionalElevenHeight, mainColumnHeight: $mainColumnHeight, additionalColumnHeight: $additionalColumnHeight, mainColumnNextPagesHeight: $mainColumnNextPagesHeight, additionalColumnNextPagesHeight: $additionalColumnNextPagesHeight, tapHandler: tapHandler, doubleTapHandler: doubleTapHandler)
                
            }).preferredItemSize(CGSize(width: EditorPreviewSizeManager.getFinalWidth(geoWidth: geo.size.width, geoHeight: geo.size.height, margin: 24), height: EditorPreviewSizeManager.getFinalHeight(geoWidth: geo.size.width, geoHeight: geo.size.height, margin: 24))).itemSpacing(8).vertical()
            
        }.onChange(of: [ blockOneHeight, blockTwoHeight, blockThreeHeight, blockFourHeight, blockFiveHeight, blockSixHeight, blockSevenHeight, blockEightHeight, blockNineHeight, blockTenHeight, blockElevenHeight ]) {
            updateBlockPages(isMainBlock: true, columnHeight: mainColumnHeight, nextColumnHeight: mainColumnNextPagesHeight, blockOneHeight: blockOneHeight, blockTwoHeight: blockTwoHeight, blockThreeHeight: blockThreeHeight, blockFourHeight: blockFourHeight, blockFiveHeight: blockFiveHeight, blockSixHeight: blockSixHeight, blockSevenHeight: blockSevenHeight, blockEightHeight: blockEightHeight, blockNineHeight: blockNineHeight, blockTenHeight: blockTenHeight, blockElevenHeight: blockElevenHeight)
        }.onChange(of: [ blockAdditionalOneHeight, blockAdditionalTwoHeight, blockAdditionalThreeHeight, blockAdditionalFourHeight, blockAdditionalFiveHeight, blockAdditionalSixHeight, blockAdditionalSevenHeight, blockAdditionalEightHeight, blockAdditionalNineHeight, blockAdditionalTenHeight, blockAdditionalElevenHeight ]) {
            updateBlockPages(isMainBlock: false, columnHeight: additionalColumnHeight, nextColumnHeight: additionalColumnNextPagesHeight, blockOneHeight: blockAdditionalOneHeight, blockTwoHeight: blockAdditionalTwoHeight, blockThreeHeight: blockAdditionalThreeHeight, blockFourHeight: blockAdditionalFourHeight, blockFiveHeight: blockAdditionalFiveHeight, blockSixHeight: blockAdditionalSixHeight, blockSevenHeight: blockAdditionalSevenHeight, blockEightHeight: blockAdditionalEightHeight, blockNineHeight: blockAdditionalNineHeight, blockTenHeight: blockAdditionalTenHeight, blockElevenHeight: blockAdditionalElevenHeight)
        }
    }
    
    private func updateBlockPages (isMainBlock: Bool, columnHeight: CGFloat, nextColumnHeight: CGFloat, blockOneHeight: CGFloat, blockTwoHeight: CGFloat, blockThreeHeight: CGFloat, blockFourHeight: CGFloat, blockFiveHeight: CGFloat, blockSixHeight: CGFloat, blockSevenHeight: CGFloat, blockEightHeight: CGFloat, blockNineHeight: CGFloat, blockTenHeight: CGFloat, blockElevenHeight: CGFloat) {
        var mainColumnNextPagesHeight = nextColumnHeight
        if mainColumnNextPagesHeight == 0.0 {
            mainColumnNextPagesHeight = columnHeight
        }
        
        let heights = [ blockOneHeight, blockTwoHeight, blockThreeHeight, blockFourHeight, blockFiveHeight, blockSixHeight, blockSevenHeight, blockEightHeight, blockNineHeight, blockTenHeight, blockElevenHeight ]
        
        var calculatedPage = 0
        var heightSum: CGFloat = 0.0
        for i in 0..<11 {
            var blockHeight = heights[i]
            if !getIsBlockAdded(position: i, isMainBlock: isMainBlock) {
                blockHeight = 0.0
            }
            if heightSum + blockHeight <= columnHeight + mainColumnNextPagesHeight * CGFloat(calculatedPage) {
                heightSum += blockHeight
            } else {
                heightSum += (columnHeight + mainColumnNextPagesHeight * CGFloat(calculatedPage)) - heightSum
                heightSum += blockHeight
                calculatedPage += 1
            }
            
            let currentPage = getBlockPage(position: i, isMainBlock: isMainBlock)
            if currentPage != calculatedPage {
                updateBlockPage(position: i, page: calculatedPage, isMainBlock: isMainBlock)
            }
            print("Block" + String(i) + " page: " + String(Float(calculatedPage)))
        }
        
        
        
        
//        for i in 0..<11 {
//            updateBlockPageByPosition(position: i, isMainBlock: isMainBlock, columnHeight: columnHeight, mainColumnNextPagesHeight: mainColumnNextPagesHeight, blockOneHeight: blockOneHeight, blockTwoHeight: blockTwoHeight, blockThreeHeight: blockThreeHeight, blockFourHeight: blockFourHeight, blockFiveHeight: blockFiveHeight, blockSixHeight: blockSixHeight, blockSevenHeight: blockSevenHeight, blockEightHeight: blockEightHeight, blockNineHeight: blockNineHeight, blockTenHeight: blockTenHeight, blockElevenHeight: blockElevenHeight)
//        }
        
//        var blockOnePage = getBlockPage(position: 0, isMainBlock: isMainBlock)
//        if blockOneHeight > (blockOnePage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 0, page: 1, isMainBlock: isMainBlock)
//            blockOnePage = 1
//        } else if blockOnePage > 0 && blockOneHeight < (blockOnePage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 0, page: 0, isMainBlock: isMainBlock)
//            blockOnePage = 0
//        }
//        
//        var blockTwoPage = getBlockPage(position: 1, isMainBlock: isMainBlock)
//        if (blockTwoPage == blockOnePage ? blockOneHeight : 0.0) + blockTwoHeight > (blockTwoPage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 1, page: blockOnePage + 1, isMainBlock: isMainBlock)
//            blockTwoPage = blockOnePage + 1
//        } else if blockTwoPage > 0 && (blockTwoPage - blockOnePage == 1 ? blockOneHeight : 0.0) + blockTwoHeight < (blockTwoPage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 1, page: blockTwoPage - 1, isMainBlock: isMainBlock)
//            blockTwoPage = blockTwoPage - 1
//        }
//        
//        var blockThreePage = getBlockPage(position: 2, isMainBlock: isMainBlock)
//        if (blockThreePage == blockOnePage ? blockOneHeight : 0.0) + (blockThreePage == blockTwoPage ? blockTwoHeight : 0.0) + blockThreeHeight > (blockThreePage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 2, page: blockTwoPage + 1, isMainBlock: isMainBlock)
//            blockThreePage = blockTwoPage + 1
//        } else if blockThreePage > 0 && (blockThreePage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockThreePage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + blockThreeHeight < (blockThreePage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 2, page: blockThreePage - 1, isMainBlock: isMainBlock)
//            blockThreePage = blockThreePage - 1
//        }
//        
//        var blockFourPage = getBlockPage(position: 3, isMainBlock: isMainBlock)
//        if (blockFourPage == blockOnePage ? blockOneHeight : 0.0) + (blockFourPage == blockTwoPage ? blockTwoHeight : 0.0) + (blockFourPage == blockThreePage ? blockThreeHeight : 0.0) + blockFourHeight > (blockFourPage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 3, page: blockThreePage + 1, isMainBlock: isMainBlock)
//            blockFourPage = blockThreePage + 1
//        } else if blockFourPage > 0 && (blockFourPage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockFourPage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockFourPage - blockThreePage == 1 ? blockThreeHeight : 0.0) + blockFourHeight < (blockFourPage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 3, page: blockFourPage - 1, isMainBlock: isMainBlock)
//            blockFourPage = blockFourPage - 1
//        }
//        
//        var blockFivePage = getBlockPage(position: 4, isMainBlock: isMainBlock)
//        if (blockFivePage == blockOnePage ? blockOneHeight : 0.0) + (blockFivePage == blockTwoPage ? blockTwoHeight : 0.0) + (blockFivePage == blockThreePage ? blockThreeHeight : 0.0) + (blockFivePage == blockFourPage ? blockFourHeight : 0.0) + blockFiveHeight > (blockFivePage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 4, page: blockFourPage + 1, isMainBlock: isMainBlock)
//            blockFivePage = blockFourPage + 1
//        } else if blockFivePage > 0 && (blockFivePage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockFivePage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockFivePage - blockThreePage == 1 ? blockThreeHeight : 0.0) + (blockFivePage - blockFourPage == 1 ? blockFourHeight : 0.0) + blockFiveHeight < (blockFivePage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 4, page: blockFivePage - 1, isMainBlock: isMainBlock)
//            blockFivePage = blockFivePage - 1
//        }
//        
//        var blockSixPage = getBlockPage(position: 5, isMainBlock: isMainBlock)
//        if (blockSixPage == blockOnePage ? blockOneHeight : 0.0) + (blockSixPage == blockTwoPage ? blockTwoHeight : 0.0) + (blockSixPage == blockThreePage ? blockThreeHeight : 0.0) + (blockSixPage == blockFourPage ? blockFourHeight : 0.0) + (blockSixPage == blockFivePage ? blockFiveHeight : 0.0) + blockSixHeight > (blockSixPage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 5, page: blockFivePage + 1, isMainBlock: isMainBlock)
//            blockSixPage = blockFivePage + 1
//        } else if blockSixPage > 0 && (blockSixPage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockSixPage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockSixPage - blockThreePage == 1 ? blockThreeHeight : 0.0) + (blockSixPage - blockFourPage == 1 ? blockFourHeight : 0.0) + (blockSixPage - blockFivePage == 1 ? blockFiveHeight : 0.0) + blockSixHeight < (blockSixPage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 5, page: blockSixPage - 1, isMainBlock: isMainBlock)
//            blockSixPage = blockSixPage - 1
//        }
//        
//        var blockSevenPage = getBlockPage(position: 6, isMainBlock: isMainBlock)
//        if (blockSevenPage == blockOnePage ? blockOneHeight : 0.0) + (blockSevenPage == blockTwoPage ? blockTwoHeight : 0.0) + (blockSevenPage == blockThreePage ? blockThreeHeight : 0.0) + (blockSevenPage == blockFourPage ? blockFourHeight : 0.0) + (blockSevenPage == blockFivePage ? blockFiveHeight : 0.0) + (blockSevenPage == blockSixPage ? blockSixHeight : 0.0) + blockSevenHeight > (blockSevenPage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 6, page: blockSixPage + 1, isMainBlock: isMainBlock)
//            blockSevenPage = blockSixPage + 1
//        } else if blockSevenPage > 0 && (blockSevenPage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockSevenPage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockSevenPage - blockThreePage == 1 ? blockThreeHeight : 0.0) + (blockSevenPage - blockFourPage == 1 ? blockFourHeight : 0.0) + (blockSevenPage - blockFivePage == 1 ? blockFiveHeight : 0.0) + (blockSevenPage - blockSixPage == 1 ? blockSixHeight : 0.0) + blockSevenHeight < (blockSevenPage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 6, page: blockSevenPage - 1, isMainBlock: isMainBlock)
//            blockSevenPage = blockSevenPage - 1
//        }
//        
//        var blockEightPage = getBlockPage(position: 7, isMainBlock: isMainBlock)
//        if (blockEightPage == blockOnePage ? blockOneHeight : 0.0) + (blockEightPage == blockTwoPage ? blockTwoHeight : 0.0) + (blockEightPage == blockThreePage ? blockThreeHeight : 0.0) + (blockEightPage == blockFourPage ? blockFourHeight : 0.0) + (blockEightPage == blockFivePage ? blockFiveHeight : 0.0) + (blockEightPage == blockSixPage ? blockSixHeight : 0.0) + (blockEightPage == blockSevenPage ? blockSevenHeight : 0.0) + blockEightHeight > (blockEightPage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 7, page: blockSevenPage + 1, isMainBlock: isMainBlock)
//            blockEightPage = blockSevenPage + 1
//        } else if blockEightPage > 0 && (blockEightPage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockEightPage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockEightPage - blockThreePage == 1 ? blockThreeHeight : 0.0) + (blockEightPage - blockFourPage == 1 ? blockFourHeight : 0.0) + (blockEightPage - blockFivePage == 1 ? blockFiveHeight : 0.0) + (blockEightPage - blockSixPage == 1 ? blockSixHeight : 0.0) + (blockEightPage - blockSevenPage == 1 ? blockSevenHeight : 0.0) + blockEightHeight < (blockEightPage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 7, page: blockEightPage - 1, isMainBlock: isMainBlock)
//            blockEightPage = blockEightPage - 1
//        }
//        
//        var blockNinePage = getBlockPage(position: 8, isMainBlock: isMainBlock)
//        if (blockNinePage == blockOnePage ? blockOneHeight : 0.0) + (blockNinePage == blockTwoPage ? blockTwoHeight : 0.0) + (blockNinePage == blockThreePage ? blockThreeHeight : 0.0) + (blockNinePage == blockFourPage ? blockFourHeight : 0.0) + (blockNinePage == blockFivePage ? blockFiveHeight : 0.0) + (blockNinePage == blockSixPage ? blockSixHeight : 0.0) + (blockNinePage == blockSevenPage ? blockSevenHeight : 0.0) + (blockNinePage == blockEightPage ? blockEightHeight : 0.0) + blockNineHeight > (blockNinePage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 8, page: blockEightPage + 1, isMainBlock: isMainBlock)
//            blockNinePage = blockEightPage + 1
//        } else if blockNinePage > 0 && (blockNinePage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockNinePage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockNinePage - blockThreePage == 1 ? blockThreeHeight : 0.0) + (blockNinePage - blockFourPage == 1 ? blockFourHeight : 0.0) + (blockNinePage - blockFivePage == 1 ? blockFiveHeight : 0.0) + (blockNinePage - blockSixPage == 1 ? blockSixHeight : 0.0) + (blockNinePage - blockSevenPage == 1 ? blockSevenHeight : 0.0) + (blockNinePage - blockEightPage == 1 ? blockEightHeight : 0.0) + blockNineHeight < (blockNinePage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 8, page: blockNinePage - 1, isMainBlock: isMainBlock)
//            blockNinePage = blockNinePage - 1
//        }
//        
//        var blockTenPage = getBlockPage(position: 9, isMainBlock: isMainBlock)
//        if (blockTenPage == blockOnePage ? blockOneHeight : 0.0) + (blockTenPage == blockTwoPage ? blockTwoHeight : 0.0) + (blockTenPage == blockThreePage ? blockThreeHeight : 0.0) + (blockTenPage == blockFourPage ? blockFourHeight : 0.0) + (blockTenPage == blockFivePage ? blockFiveHeight : 0.0) + (blockTenPage == blockSixPage ? blockSixHeight : 0.0) + (blockTenPage == blockSevenPage ? blockSevenHeight : 0.0) + (blockTenPage == blockEightPage ? blockEightHeight : 0.0) + (blockTenPage == blockNinePage ? blockNineHeight : 0.0) + blockTenHeight > (blockTenPage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 9, page: blockNinePage + 1, isMainBlock: isMainBlock)
//            blockTenPage = blockNinePage + 1
//        } else if blockTenPage > 0 && (blockTenPage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockTenPage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockTenPage - blockThreePage == 1 ? blockThreeHeight : 0.0) + (blockTenPage - blockFourPage == 1 ? blockFourHeight : 0.0) + (blockTenPage - blockFivePage == 1 ? blockFiveHeight : 0.0) + (blockTenPage - blockSixPage == 1 ? blockSixHeight : 0.0) + (blockTenPage - blockSevenPage == 1 ? blockSevenHeight : 0.0) + (blockTenPage - blockEightPage == 1 ? blockEightHeight : 0.0) + (blockTenPage - blockNinePage == 1 ? blockNineHeight : 0.0) + blockTenHeight < (blockTenPage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 9, page: blockTenPage - 1, isMainBlock: isMainBlock)
//            blockTenPage = blockTenPage - 1
//        }
//        
//        var blockElevenPage = getBlockPage(position: 10, isMainBlock: isMainBlock)
//        if (blockElevenPage == blockOnePage ? blockOneHeight : 0.0) + (blockElevenPage == blockTwoPage ? blockTwoHeight : 0.0) + (blockElevenPage == blockThreePage ? blockThreeHeight : 0.0) + (blockElevenPage == blockFourPage ? blockFourHeight : 0.0) + (blockElevenPage == blockFivePage ? blockFiveHeight : 0.0) + (blockElevenPage == blockSixPage ? blockSixHeight : 0.0) + (blockElevenPage == blockSevenPage ? blockSevenHeight : 0.0) + (blockElevenPage == blockEightPage ? blockEightHeight : 0.0) + (blockElevenPage == blockNinePage ? blockNineHeight : 0.0) + (blockElevenPage == blockTenPage ? blockTenHeight : 0.0) + blockElevenHeight > (blockElevenPage == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 10, page: blockTenPage + 1, isMainBlock: isMainBlock)
//            blockElevenPage = blockTenPage + 1
//        } else if blockElevenPage > 0 && (blockElevenPage - blockOnePage == 1 ? blockOneHeight : 0.0) + (blockElevenPage - blockTwoPage == 1 ? blockTwoHeight : 0.0) + (blockElevenPage - blockThreePage == 1 ? blockThreeHeight : 0.0) + (blockElevenPage - blockFourPage == 1 ? blockFourHeight : 0.0) + (blockElevenPage - blockFivePage == 1 ? blockFiveHeight : 0.0) + (blockElevenPage - blockSixPage == 1 ? blockSixHeight : 0.0) + (blockElevenPage - blockSevenPage == 1 ? blockSevenHeight : 0.0) + (blockElevenPage - blockEightPage == 1 ? blockEightHeight : 0.0) + (blockElevenPage - blockNinePage == 1 ? blockNineHeight : 0.0) + (blockElevenPage - blockTenPage == 1 ? blockTenHeight : 0.0) + blockElevenHeight < (blockElevenPage - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            updateBlockPage(position: 10, page: blockElevenPage - 1, isMainBlock: isMainBlock)
//            blockElevenPage = blockElevenPage - 1
//        }
//        
        print("Height 1: " + String(Float(blockOneHeight)))
        print("Height 2: " + String(Float(blockTwoHeight)))
        print("Height 3: " + String(Float(blockThreeHeight)))
        print("Height 4: " + String(Float(blockFourHeight)))
        print("Height 5: " + String(Float(blockFiveHeight)))
        print("Height 6: " + String(Float(blockSixHeight)))
        print("Height 7: " + String(Float(blockSevenHeight)))
        print("Height 8: " + String(Float(blockEightHeight)))
        print("Height 9: " + String(Float(blockNineHeight)))
        print("Height 10: " + String(Float(blockTenHeight)))
        print("Height 11: " + String(Float(blockElevenHeight)))
        
        print("Column main height: " + String(Float(columnHeight)) + ", next page: " + String(Float(mainColumnNextPagesHeight)))
    }
    
    private func updateBlockPageByPosition (position: Int, isMainBlock: Bool, columnHeight: CGFloat, mainColumnNextPagesHeight: CGFloat, blockOneHeight: CGFloat, blockTwoHeight: CGFloat, blockThreeHeight: CGFloat, blockFourHeight: CGFloat, blockFiveHeight: CGFloat, blockSixHeight: CGFloat, blockSevenHeight: CGFloat, blockEightHeight: CGFloat, blockNineHeight: CGFloat, blockTenHeight: CGFloat, blockElevenHeight: CGFloat) {
        
        
        var blocksPages: [Int] = []
        for i in 0..<11 {
            blocksPages.append(getBlockPage(position: i, isMainBlock: isMainBlock))
        }
        
        var currentColumnHeight: CGFloat = 0.0
        for i in 0..<11 {
            if blocksPages[position] == blocksPages[i] && position >= i {
                switch i {
                case 0:
                    currentColumnHeight += blockOneHeight
                case 1:
                    currentColumnHeight += blockTwoHeight
                case 2:
                    currentColumnHeight += blockThreeHeight
                case 3:
                    currentColumnHeight += blockFourHeight
                case 4:
                    currentColumnHeight += blockFiveHeight
                case 5:
                    currentColumnHeight += blockSixHeight
                case 6:
                    currentColumnHeight += blockSevenHeight
                case 7:
                    currentColumnHeight += blockEightHeight
                case 8:
                    currentColumnHeight += blockNineHeight
                case 9:
                    currentColumnHeight += blockTenHeight
                case 10:
                    currentColumnHeight += blockElevenHeight
                default:
                    break
                }
            }
        }
        
        var previousPageColumnHeight: CGFloat = 0.0
        for i in 0..<11 {
            if blocksPages[position] - blocksPages[i] == 1 {
                switch i {
                case 0:
                    previousPageColumnHeight += blockOneHeight
                case 1:
                    previousPageColumnHeight += blockTwoHeight
                case 2:
                    previousPageColumnHeight += blockThreeHeight
                case 3:
                    previousPageColumnHeight += blockFourHeight
                case 4:
                    previousPageColumnHeight += blockFiveHeight
                case 5:
                    previousPageColumnHeight += blockSixHeight
                case 6:
                    previousPageColumnHeight += blockSevenHeight
                case 7:
                    previousPageColumnHeight += blockEightHeight
                case 8:
                    previousPageColumnHeight += blockNineHeight
                case 9:
                    previousPageColumnHeight += blockTenHeight
                case 10:
                    previousPageColumnHeight += blockElevenHeight
                default:
                    break
                }
            }
        }
        
        if currentColumnHeight > (blocksPages[position] == 0 ? columnHeight : mainColumnNextPagesHeight) {
            
            for i in position..<11 {
                updateBlockPage(position: position, page: blocksPages[position] + 1, isMainBlock: isMainBlock)
            }
            
        } else if blocksPages[position] > 0 && previousPageColumnHeight < (blocksPages[position] - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
            
            updateBlockPage(position: position, page: blocksPages[position] - 1, isMainBlock: isMainBlock)
        }
        
//        var blockElevenPage = getBlockPage(position: 10, isMainBlock: isMainBlock)
//        if (blocksPages[position] == blocksPages[0] && position >= 0 ? blockOneHeight : 0.0) + (blocksPages[position] == blocksPages[1] && position >= 1 ? blockTwoHeight : 0.0) + (blocksPages[position] == blocksPages[2] && position >= 2 ? blockThreeHeight : 0.0) + (blocksPages[position] == blocksPages[3] && position >= 3 ? blockFourHeight : 0.0) + (blocksPages[position] == blocksPages[4] && position >= 4 ? blockFiveHeight : 0.0) + (blocksPages[position] == blocksPages[5] && position >= 5 ? blockSixHeight : 0.0) + (blocksPages[position] == blocksPages[6] && position >= 6 ? blockSevenHeight : 0.0) + (blocksPages[position] == blocksPages[7] && position >= 7 ? blockEightHeight : 0.0) + (blocksPages[position] == blocksPages[8] && position >= 8 ? blockNineHeight : 0.0) + (blocksPages[position] == blocksPages[9] && position >= 9 ? blockTenHeight : 0.0) + (blocksPages[position] == blocksPages[10] && position >= 10 ? blockElevenHeight : 0.0) > (blocksPages[position] == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            
//            updateBlockPage(position: position, page: blocksPages[position] + 1, isMainBlock: isMainBlock)
//            
////            blockElevenPage = blockTenPage + 1
//        } else if blocksPages[position] > 0 && (blocksPages[position] - blocksPages[0] == 1 ? blockOneHeight : 0.0) + (blocksPages[position] - blocksPages[1] == 1 ? blockTwoHeight : 0.0) + (blocksPages[position] - blocksPages[2] == 1 ? blockThreeHeight : 0.0) + (blocksPages[position] - blocksPages[3] == 1 ? blockFourHeight : 0.0) + (blocksPages[position] - blocksPages[4] == 1 ? blockFiveHeight : 0.0) + (blocksPages[position] - blocksPages[5] == 1 ? blockSixHeight : 0.0) + (blocksPages[position] - blocksPages[6] == 1 ? blockSevenHeight : 0.0) + (blocksPages[position] - blocksPages[7] == 1 ? blockEightHeight : 0.0) + (blocksPages[position] - blocksPages[8] == 1 ? blockNineHeight : 0.0) + (blocksPages[position] - blocksPages[9] == 1 ? blockTenHeight : 0.0) + (blocksPages[position] - blocksPages[10] == 1 ? blockElevenHeight : 0.0) < (blocksPages[position] - 1 == 0 ? columnHeight : mainColumnNextPagesHeight) {
//            
//            updateBlockPage(position: position, page: blocksPages[position] - 1, isMainBlock: isMainBlock)
////            blockElevenPage = blockElevenPage - 1
//        }
    }
    
    
    
//    private func updateAdditionalBlockPages () {
//        var additionalColumnNextPagesHeight = self.additionalColumnNextPagesHeight
//        if additionalColumnNextPagesHeight == 0.0 {
//            additionalColumnNextPagesHeight = additionalColumnHeight
//        }
//        
//        let blockOnePage = getBlockPage(position: 0, isMainBlock: false)
//        if blockAdditionalOneHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockOnePage) {
//            updateBlockPage(position: 0, page: blockOnePage + 1, isMainBlock: false)
//        } else if blockOnePage > 0 && blockAdditionalOneHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockOnePage - 1)  {
//            updateBlockPage(position: 0, page: blockOnePage - 1, isMainBlock: false)
//        }
//        
//        let blockTwoPage = getBlockPage(position: 1, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTwoPage) {
//            updateBlockPage(position: 1, page: blockTwoPage + 1, isMainBlock: false)
//        } else if blockTwoPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTwoPage - 1)  {
//            updateBlockPage(position: 1, page: blockTwoPage - 1, isMainBlock: false)
//        }
//        
//        let blockThreePage = getBlockPage(position: 2, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockThreePage) {
//            updateBlockPage(position: 2, page: blockThreePage + 1, isMainBlock: false)
//        } else if blockThreePage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockThreePage - 1)  {
//            updateBlockPage(position: 2, page: blockThreePage - 1, isMainBlock: false)
//        }
//        
//        let blockFourPage = getBlockPage(position: 3, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFourPage) {
//            updateBlockPage(position: 3, page: blockFourPage + 1, isMainBlock: false)
//        } else if blockFourPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFourPage - 1)  {
//            updateBlockPage(position: 3, page: blockFourPage - 1, isMainBlock: false)
//        }
//        
//        let blockFivePage = getBlockPage(position: 4, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFivePage) {
//            updateBlockPage(position: 4, page: blockFivePage + 1, isMainBlock: false)
//        } else if blockFivePage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFivePage - 1)  {
//            updateBlockPage(position: 4, page: blockFivePage - 1, isMainBlock: false)
//        }
//        
//        let blockSixPage = getBlockPage(position: 5, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSixPage) {
//            updateBlockPage(position: 5, page: blockSixPage + 1, isMainBlock: false)
//        } else if blockSixPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSixPage - 1)  {
//            updateBlockPage(position: 5, page: blockSixPage - 1, isMainBlock: false)
//        }
//        
//        let blockSevenPage = getBlockPage(position: 6, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSevenPage) {
//            updateBlockPage(position: 6, page: blockSevenPage + 1, isMainBlock: false)
//        } else if blockSevenPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSevenPage - 1)  {
//            updateBlockPage(position: 6, page: blockSevenPage - 1, isMainBlock: false)
//        }
//        
//        let blockEightPage = getBlockPage(position: 7, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockEightPage) {
//            updateBlockPage(position: 7, page: blockEightPage + 1, isMainBlock: false)
//        } else if blockEightPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockEightPage - 1)  {
//            updateBlockPage(position: 7, page: blockEightPage - 1, isMainBlock: false)
//        }
//        
//        let blockNinePage = getBlockPage(position: 8, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockNinePage) {
//            updateBlockPage(position: 8, page: blockNinePage + 1, isMainBlock: false)
//        } else if blockNinePage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockNinePage - 1)  {
//            updateBlockPage(position: 8, page: blockNinePage - 1, isMainBlock: false)
//        }
//        
//        let blockTenPage = getBlockPage(position: 9, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTenPage) {
//            updateBlockPage(position: 9, page: blockTenPage + 1, isMainBlock: false)
//        } else if blockTenPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTenPage - 1)  {
//            updateBlockPage(position: 9, page: blockTenPage - 1, isMainBlock: false)
//        }
//        
//        let blockElevenPage = getBlockPage(position: 10, isMainBlock: false)
//        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight + blockAdditionalElevenHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockElevenPage) {
//            updateBlockPage(position: 10, page: blockElevenPage + 1, isMainBlock: false)
//        } else if blockElevenPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight + blockAdditionalElevenHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockElevenPage - 1)  {
//            updateBlockPage(position: 10, page: blockElevenPage - 1, isMainBlock: false)
//        }
//    }
    
//    private func updateBlockPages (isMainBlock: Bool, columnHeight: CGFloat, nextColumnHeight: CGFloat, blockOneHeight: CGFloat, blockTwoHeight: CGFloat, blockThreeHeight: CGFloat, blockFourHeight: CGFloat, blockFiveHeight: CGFloat, blockSixHeight: CGFloat, blockSevenHeight: CGFloat, blockEightHeight: CGFloat, blockNineHeight: CGFloat, blockTenHeight: CGFloat, blockElevenHeight: CGFloat) {
//        var additionalColumnNextPagesHeight = nextColumnHeight
//        if additionalColumnNextPagesHeight == 0.0 {
//            additionalColumnNextPagesHeight = columnHeight
//        }
//        
//        let blockOnePage = getBlockPage(position: 0, isMainBlock: isMainBlock)
//        if blockOneHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockOnePage) {
//            updateBlockPage(position: 0, page: blockOnePage + 1, isMainBlock: isMainBlock)
//        } else if blockOnePage > 0 && blockOneHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockOnePage - 1)  {
//            updateBlockPage(position: 0, page: blockOnePage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockTwoPage = getBlockPage(position: 1, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockTwoPage) {
//            updateBlockPage(position: 1, page: blockTwoPage + 1, isMainBlock: isMainBlock)
//        } else if blockTwoPage > 0 && blockOneHeight + blockTwoHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockTwoPage - 1)  {
//            updateBlockPage(position: 1, page: blockTwoPage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockThreePage = getBlockPage(position: 2, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockThreePage) {
//            updateBlockPage(position: 2, page: blockThreePage + 1, isMainBlock: isMainBlock)
//        } else if blockThreePage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockThreePage - 1)  {
//            updateBlockPage(position: 2, page: blockThreePage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockFourPage = getBlockPage(position: 3, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockFourPage) {
//            updateBlockPage(position: 3, page: blockFourPage + 1, isMainBlock: isMainBlock)
//        } else if blockFourPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockFourPage - 1)  {
//            updateBlockPage(position: 3, page: blockFourPage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockFivePage = getBlockPage(position: 4, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockFivePage) {
//            updateBlockPage(position: 4, page: blockFivePage + 1, isMainBlock: isMainBlock)
//        } else if blockFivePage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockFivePage - 1)  {
//            updateBlockPage(position: 4, page: blockFivePage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockSixPage = getBlockPage(position: 5, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockSixPage) {
//            updateBlockPage(position: 5, page: blockSixPage + 1, isMainBlock: isMainBlock)
//        } else if blockSixPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockSixPage - 1)  {
//            updateBlockPage(position: 5, page: blockSixPage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockSevenPage = getBlockPage(position: 6, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockSevenPage) {
//            updateBlockPage(position: 6, page: blockSevenPage + 1, isMainBlock: isMainBlock)
//        } else if blockSevenPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockSevenPage - 1)  {
//            updateBlockPage(position: 6, page: blockSevenPage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockEightPage = getBlockPage(position: 7, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockEightPage) {
//            updateBlockPage(position: 7, page: blockEightPage + 1, isMainBlock: isMainBlock)
//        } else if blockEightPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockEightPage - 1)  {
//            updateBlockPage(position: 7, page: blockEightPage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockNinePage = getBlockPage(position: 8, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockNinePage) {
//            updateBlockPage(position: 8, page: blockNinePage + 1, isMainBlock: isMainBlock)
//        } else if blockNinePage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockNinePage - 1)  {
//            updateBlockPage(position: 8, page: blockNinePage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockTenPage = getBlockPage(position: 9, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockTenPage) {
//            updateBlockPage(position: 9, page: blockTenPage + 1, isMainBlock: isMainBlock)
//        } else if blockTenPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockTenPage - 1)  {
//            updateBlockPage(position: 9, page: blockTenPage - 1, isMainBlock: isMainBlock)
//        }
//        
//        let blockElevenPage = getBlockPage(position: 10, isMainBlock: isMainBlock)
//        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight + blockElevenHeight > columnHeight + additionalColumnNextPagesHeight * CGFloat(blockElevenPage) {
//            updateBlockPage(position: 10, page: blockElevenPage + 1, isMainBlock: isMainBlock)
//        } else if blockElevenPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight + blockElevenHeight < columnHeight + additionalColumnNextPagesHeight * CGFloat(blockElevenPage - 1)  {
//            updateBlockPage(position: 10, page: blockElevenPage - 1, isMainBlock: isMainBlock)
//        }
//    }
    
    private func updateBlockPage (position: Int, page: Int, isMainBlock: Bool) {
        if let profileDescBlock = cv.profileDescBlock, profileDescBlock.isMainBlock == isMainBlock, profileDescBlock.position == position {
            profileDescBlock.page = page
            cv.profileDescBlock = profileDescBlock
        }
        if let contactBlock = cv.contactBlock, contactBlock.isMainBlock == isMainBlock, contactBlock.position == position {
            contactBlock.page = page
            cv.contactBlock = contactBlock
        }
        if let socialBlock = cv.socialBlock, socialBlock.isMainBlock == isMainBlock, socialBlock.position == position {
            socialBlock.page = page
            cv.socialBlock = socialBlock
        }
        if let qrCodesBlock = cv.qrCodesBlock, qrCodesBlock.isMainBlock == isMainBlock, qrCodesBlock.position == position {
            qrCodesBlock.page = page
            cv.qrCodesBlock = qrCodesBlock
        }
        if let educationBlock = cv.educationBlock, educationBlock.isMainBlock == isMainBlock, educationBlock.position == position {
            educationBlock.page = page
            cv.educationBlock = educationBlock
        }
        if let workBlock = cv.workBlock, workBlock.isMainBlock == isMainBlock, workBlock.position == position {
            workBlock.page = page
            cv.workBlock = workBlock
        }
        if let languagesBlock = cv.languagesBlock, languagesBlock.isMainBlock == isMainBlock, languagesBlock.position == position {
            languagesBlock.page = page
            cv.languagesBlock = languagesBlock
        }
        if let skillsBlock = cv.skillsBlock, skillsBlock.isMainBlock == isMainBlock, skillsBlock.position == position {
            skillsBlock.page = page
            cv.skillsBlock = skillsBlock
        }
        if let interestsBlock = cv.interestsBlock, interestsBlock.isMainBlock == isMainBlock, interestsBlock.position == position {
            interestsBlock.page = page
            cv.interestsBlock = interestsBlock
        }
        if let certificatesBlock = cv.certificatesBlock, certificatesBlock.isMainBlock == isMainBlock, certificatesBlock.position == position {
            certificatesBlock.page = page
            cv.certificatesBlock = certificatesBlock
        }
        if let referencesBlock = cv.referencesBlock, referencesBlock.isMainBlock == isMainBlock, referencesBlock.position == position {
            referencesBlock.page = page
            cv.referencesBlock = referencesBlock
            print("References page " + String(cv.referencesBlock!.page))
        }
        pageUpdateHandler()
    }
    
    private func getBlockPage (position: Int, isMainBlock: Bool) -> Int {
        if let profileDescBlock = cv.profileDescBlock, profileDescBlock.isMainBlock == isMainBlock, profileDescBlock.position == position {
            return profileDescBlock.page
        }
        if let contactBlock = cv.contactBlock, contactBlock.isMainBlock == isMainBlock, contactBlock.position == position {
            return contactBlock.page
        }
        if let socialBlock = cv.socialBlock, socialBlock.isMainBlock == isMainBlock, socialBlock.position == position {
            return socialBlock.page
        }
        if let qrCodesBlock = cv.qrCodesBlock, qrCodesBlock.isMainBlock == isMainBlock, qrCodesBlock.position == position {
            return qrCodesBlock.page
        }
        if let educationBlock = cv.educationBlock, educationBlock.isMainBlock == isMainBlock, educationBlock.position == position {
            return educationBlock.page
        }
        if let workBlock = cv.workBlock, workBlock.isMainBlock == isMainBlock, workBlock.position == position {
            return workBlock.page
        }
        if let languagesBlock = cv.languagesBlock, languagesBlock.isMainBlock == isMainBlock, languagesBlock.position == position {
            return languagesBlock.page
        }
        if let skillsBlock = cv.skillsBlock, skillsBlock.isMainBlock == isMainBlock, skillsBlock.position == position {
            return skillsBlock.page
        }
        if let interestsBlock = cv.interestsBlock, interestsBlock.isMainBlock == isMainBlock, interestsBlock.position == position {
            return interestsBlock.page
        }
        if let certificatesBlock = cv.certificatesBlock, certificatesBlock.isMainBlock == isMainBlock, certificatesBlock.position == position {
            return certificatesBlock.page
        }
        if let referencesBlock = cv.referencesBlock, referencesBlock.isMainBlock == isMainBlock, referencesBlock.position == position {
            return referencesBlock.page
        }
        return 0
    }
    
    private func getIsBlockAdded (position: Int, isMainBlock: Bool) -> Bool {
        if let profileDescBlock = cv.profileDescBlock, profileDescBlock.isMainBlock == isMainBlock, profileDescBlock.position == position {
            return profileDescBlock.isAdded
        }
        if let contactBlock = cv.contactBlock, contactBlock.isMainBlock == isMainBlock, contactBlock.position == position {
            return contactBlock.isAdded
        }
        if let socialBlock = cv.socialBlock, socialBlock.isMainBlock == isMainBlock, socialBlock.position == position {
            return socialBlock.isAdded
        }
        if let qrCodesBlock = cv.qrCodesBlock, qrCodesBlock.isMainBlock == isMainBlock, qrCodesBlock.position == position {
            return qrCodesBlock.isAdded
        }
        if let educationBlock = cv.educationBlock, educationBlock.isMainBlock == isMainBlock, educationBlock.position == position {
            return educationBlock.isAdded
        }
        if let workBlock = cv.workBlock, workBlock.isMainBlock == isMainBlock, workBlock.position == position {
            return workBlock.isAdded
        }
        if let languagesBlock = cv.languagesBlock, languagesBlock.isMainBlock == isMainBlock, languagesBlock.position == position {
            return languagesBlock.isAdded
        }
        if let skillsBlock = cv.skillsBlock, skillsBlock.isMainBlock == isMainBlock, skillsBlock.position == position {
            return skillsBlock.isAdded
        }
        if let interestsBlock = cv.interestsBlock, interestsBlock.isMainBlock == isMainBlock, interestsBlock.position == position {
            return interestsBlock.isAdded
        }
        if let certificatesBlock = cv.certificatesBlock, certificatesBlock.isMainBlock == isMainBlock, certificatesBlock.position == position {
            return certificatesBlock.isAdded
        }
        if let referencesBlock = cv.referencesBlock, referencesBlock.isMainBlock == isMainBlock, referencesBlock.position == position {
            return referencesBlock.isAdded
        }
        return false
    }
}

#Preview {
    @Previewable @State var wrapper = CVVisualizationBuilder().updatePositionsWrapperOne(style: Style.getDefault(), wrapper: CVEntityWrapper.getDefault())
//    let visualization = CVVisualizationBuilder()
//    let defaultWrapper = CVEntityWrapper.getDefault()
//    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    CVMakerPreviewView(cv: wrapper, isLoading: .constant(false), pageUpdateHandler: {}, tapHandler: { i, b in }, doubleTapHandler: { i, b in })
}
