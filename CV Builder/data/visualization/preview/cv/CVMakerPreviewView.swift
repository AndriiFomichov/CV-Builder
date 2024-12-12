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
    
    init(cv: CVEntityWrapper, isLoading: Binding<Bool>, pageUpdateHandler: @escaping () -> Void, doubleTapHandler: @escaping (_ page: Int, _ isCv: Bool) -> Void) {
        self._isLoading = isLoading
        let defaults = CVDefaultsWrapper()
//        self.cv = cv
        self.cv = defaults.fullfill(wrapper: cv)
//        self.style = PreloadedDatabase.getStyleId(id: wrapper.style)
        self.pageUpdateHandler = pageUpdateHandler
        self.doubleTapHandler = doubleTapHandler
        pages = CVVisualizationBuilder.getWrapperPagesCount(wrapper: cv)
    }
    
    var body: some View {
        GeometryReader { geo in
            
            Pager(page: page, data: Array(0..<pages), id: \.self, content: { index in
                
                CVMakerPreviewPageView(cv: cv, page: index, isLoading: $isLoading, blockOneHeight: $blockOneHeight, blockTwoHeight: $blockTwoHeight, blockThreeHeight: $blockThreeHeight, blockFourHeight: $blockFourHeight, blockFiveHeight: $blockFiveHeight, blockSixHeight: $blockSixHeight, blockSevenHeight: $blockSevenHeight, blockEightHeight: $blockEightHeight, blockNineHeight: $blockNineHeight, blockTenHeight: $blockTenHeight, blockElevenHeight: $blockElevenHeight, blockAdditionalOneHeight: $blockAdditionalOneHeight, blockAdditionalTwoHeight: $blockAdditionalTwoHeight, blockAdditionalThreeHeight: $blockAdditionalThreeHeight, blockAdditionalFourHeight: $blockAdditionalFourHeight, blockAdditionalFiveHeight: $blockAdditionalFiveHeight, blockAdditionalSixHeight: $blockAdditionalSixHeight, blockAdditionalSevenHeight: $blockAdditionalSevenHeight, blockAdditionalEightHeight: $blockAdditionalEightHeight, blockAdditionalNineHeight: $blockAdditionalNineHeight, blockAdditionalTenHeight: $blockAdditionalTenHeight, blockAdditionalElevenHeight: $blockAdditionalElevenHeight, mainColumnHeight: $mainColumnHeight, additionalColumnHeight: $additionalColumnHeight, mainColumnNextPagesHeight: $mainColumnNextPagesHeight, additionalColumnNextPagesHeight: $additionalColumnNextPagesHeight, doubleTapHandler: doubleTapHandler)
                
            }).preferredItemSize(CGSize(width: EditorPreviewSizeManager.getFinalWidth(geoWidth: geo.size.width, geoHeight: geo.size.height, margin: 32), height: EditorPreviewSizeManager.getFinalHeight(geoWidth: geo.size.width, geoHeight: geo.size.height, margin: 32))).itemSpacing(8).vertical()
            
        }.onChange(of: [ blockOneHeight, blockTwoHeight, blockThreeHeight, blockFourHeight, blockFiveHeight, blockSixHeight, blockSevenHeight, blockEightHeight, blockNineHeight, blockTenHeight, blockElevenHeight ]) {
            updateMainBlockPages()
        }.onChange(of: [ blockAdditionalOneHeight, blockAdditionalTwoHeight, blockAdditionalThreeHeight, blockAdditionalFourHeight, blockAdditionalFiveHeight, blockAdditionalSixHeight, blockAdditionalSevenHeight, blockAdditionalEightHeight, blockAdditionalNineHeight, blockAdditionalTenHeight, blockAdditionalElevenHeight ]) {
            updateAdditionalBlockPages()
        }
    }
    
    private func updateMainBlockPages () {
        var mainColumnNextPagesHeight = self.mainColumnNextPagesHeight
        if mainColumnNextPagesHeight == 0.0 {
            mainColumnNextPagesHeight = mainColumnHeight
        }
        
        let blockOnePage = getBlockPage(position: 0, isMainBlock: true)
        if blockOneHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockOnePage) {
            updateBlockPage(position: 0, page: blockOnePage + 1, isMainBlock: true)
            print("Updated 1")
        } else if blockOnePage > 0 && blockOneHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockOnePage - 1)  {
            updateBlockPage(position: 0, page: blockOnePage - 1, isMainBlock: true)
        }
        
        let blockTwoPage = getBlockPage(position: 1, isMainBlock: true)
        if blockOneHeight + blockTwoHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockTwoPage) {
            updateBlockPage(position: 1, page: blockTwoPage + 1, isMainBlock: true)
            print("Updated 2")
        } else if blockTwoPage > 0 && blockOneHeight + blockTwoHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockTwoPage - 1)  {
            updateBlockPage(position: 1, page: blockTwoPage - 1, isMainBlock: true)
        }
        
        let blockThreePage = getBlockPage(position: 2, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockThreePage) {
            updateBlockPage(position: 2, page: blockThreePage + 1, isMainBlock: true)
            print("Updated 3")
        } else if blockThreePage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockThreePage - 1)  {
            updateBlockPage(position: 2, page: blockThreePage - 1, isMainBlock: true)
        }
        
        let blockFourPage = getBlockPage(position: 3, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockFourPage) {
            updateBlockPage(position: 3, page: blockFourPage + 1, isMainBlock: true)
            print("Updated 4")
        } else if blockFourPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockFourPage - 1)  {
            updateBlockPage(position: 3, page: blockFourPage - 1, isMainBlock: true)
        }
        
        let blockFivePage = getBlockPage(position: 4, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockFivePage) {
            updateBlockPage(position: 4, page: blockFivePage + 1, isMainBlock: true)
            print("Updated 5")
        } else if blockFivePage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockFivePage - 1)  {
            updateBlockPage(position: 4, page: blockFivePage - 1, isMainBlock: true)
        }
        
        let blockSixPage = getBlockPage(position: 5, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockSixPage) {
            updateBlockPage(position: 5, page: blockSixPage + 1, isMainBlock: true)
            print("Updated 6")
        } else if blockSixPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockSixPage - 1)  {
            updateBlockPage(position: 5, page: blockSixPage - 1, isMainBlock: true)
        }
        
        let blockSevenPage = getBlockPage(position: 6, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockSevenPage) {
            updateBlockPage(position: 6, page: blockSevenPage + 1, isMainBlock: true)
            print("Updated 7")
        } else if blockSevenPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockSevenPage - 1)  {
            updateBlockPage(position: 6, page: blockSevenPage - 1, isMainBlock: true)
        }
        
        let blockEightPage = getBlockPage(position: 7, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockEightPage) {
            updateBlockPage(position: 7, page: blockEightPage + 1, isMainBlock: true)
            print("Updated 8")
        } else if blockEightPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockEightPage - 1)  {
            updateBlockPage(position: 7, page: blockEightPage - 1, isMainBlock: true)
        }
        
        let blockNinePage = getBlockPage(position: 8, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockNinePage) {
            updateBlockPage(position: 8, page: blockNinePage + 1, isMainBlock: true)
            print("Updated 9")
        } else if blockNinePage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockNinePage - 1)  {
            updateBlockPage(position: 8, page: blockNinePage - 1, isMainBlock: true)
        }
        
        let blockTenPage = getBlockPage(position: 9, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockTenPage) {
            updateBlockPage(position: 9, page: blockTenPage + 1, isMainBlock: true)
            print("Updated 10")
        } else if blockTenPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockTenPage - 1)  {
            updateBlockPage(position: 9, page: blockTenPage - 1, isMainBlock: true)
        }
        
        let blockElevenPage = getBlockPage(position: 10, isMainBlock: true)
        if blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight + blockElevenHeight > mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockElevenPage) {
            updateBlockPage(position: 10, page: blockElevenPage + 1, isMainBlock: true)
            print("Updated 11")
        } else if blockElevenPage > 0 && blockOneHeight + blockTwoHeight + blockThreeHeight + blockFourHeight + blockFiveHeight + blockSixHeight + blockSevenHeight + blockEightHeight + blockNineHeight + blockTenHeight + blockElevenHeight < mainColumnHeight + mainColumnNextPagesHeight * CGFloat(blockElevenPage - 1)  {
            updateBlockPage(position: 10, page: blockElevenPage - 1, isMainBlock: true)
        }
    }
    
    private func updateAdditionalBlockPages () {
        var additionalColumnNextPagesHeight = self.additionalColumnNextPagesHeight
        if additionalColumnNextPagesHeight == 0.0 {
            additionalColumnNextPagesHeight = additionalColumnHeight
        }
        
        let blockOnePage = getBlockPage(position: 0, isMainBlock: false)
        if blockAdditionalOneHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockOnePage) {
            updateBlockPage(position: 0, page: blockOnePage + 1, isMainBlock: false)
        } else if blockOnePage > 0 && blockAdditionalOneHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockOnePage - 1)  {
            updateBlockPage(position: 0, page: blockOnePage - 1, isMainBlock: false)
        }
        
        let blockTwoPage = getBlockPage(position: 1, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTwoPage) {
            updateBlockPage(position: 1, page: blockTwoPage + 1, isMainBlock: false)
        } else if blockTwoPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTwoPage - 1)  {
            updateBlockPage(position: 1, page: blockTwoPage - 1, isMainBlock: false)
        }
        
        let blockThreePage = getBlockPage(position: 2, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockThreePage) {
            updateBlockPage(position: 2, page: blockThreePage + 1, isMainBlock: false)
        } else if blockThreePage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockThreePage - 1)  {
            updateBlockPage(position: 2, page: blockThreePage - 1, isMainBlock: false)
        }
        
        let blockFourPage = getBlockPage(position: 3, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFourPage) {
            updateBlockPage(position: 3, page: blockFourPage + 1, isMainBlock: false)
        } else if blockFourPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFourPage - 1)  {
            updateBlockPage(position: 3, page: blockFourPage - 1, isMainBlock: false)
        }
        
        let blockFivePage = getBlockPage(position: 4, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFivePage) {
            updateBlockPage(position: 4, page: blockFivePage + 1, isMainBlock: false)
        } else if blockFivePage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockFivePage - 1)  {
            updateBlockPage(position: 4, page: blockFivePage - 1, isMainBlock: false)
        }
        
        let blockSixPage = getBlockPage(position: 5, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSixPage) {
            updateBlockPage(position: 5, page: blockSixPage + 1, isMainBlock: false)
        } else if blockSixPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSixPage - 1)  {
            updateBlockPage(position: 5, page: blockSixPage - 1, isMainBlock: false)
        }
        
        let blockSevenPage = getBlockPage(position: 6, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSevenPage) {
            updateBlockPage(position: 6, page: blockSevenPage + 1, isMainBlock: false)
        } else if blockSevenPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockSevenPage - 1)  {
            updateBlockPage(position: 6, page: blockSevenPage - 1, isMainBlock: false)
        }
        
        let blockEightPage = getBlockPage(position: 7, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockEightPage) {
            updateBlockPage(position: 7, page: blockEightPage + 1, isMainBlock: false)
        } else if blockEightPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockEightPage - 1)  {
            updateBlockPage(position: 7, page: blockEightPage - 1, isMainBlock: false)
        }
        
        let blockNinePage = getBlockPage(position: 8, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockNinePage) {
            updateBlockPage(position: 8, page: blockNinePage + 1, isMainBlock: false)
        } else if blockNinePage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockNinePage - 1)  {
            updateBlockPage(position: 8, page: blockNinePage - 1, isMainBlock: false)
        }
        
        let blockTenPage = getBlockPage(position: 9, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTenPage) {
            updateBlockPage(position: 9, page: blockTenPage + 1, isMainBlock: false)
        } else if blockTenPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockTenPage - 1)  {
            updateBlockPage(position: 9, page: blockTenPage - 1, isMainBlock: false)
        }
        
        let blockElevenPage = getBlockPage(position: 10, isMainBlock: false)
        if blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight + blockAdditionalElevenHeight > additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockElevenPage) {
            updateBlockPage(position: 10, page: blockElevenPage + 1, isMainBlock: false)
        } else if blockElevenPage > 0 && blockAdditionalOneHeight + blockAdditionalTwoHeight + blockAdditionalThreeHeight + blockAdditionalFourHeight + blockAdditionalFiveHeight + blockAdditionalSixHeight + blockAdditionalSevenHeight + blockAdditionalEightHeight + blockAdditionalNineHeight + blockAdditionalTenHeight + blockAdditionalElevenHeight < additionalColumnHeight + additionalColumnNextPagesHeight * CGFloat(blockElevenPage - 1)  {
            updateBlockPage(position: 10, page: blockElevenPage - 1, isMainBlock: false)
        }
    }
    
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
}

#Preview {
    @Previewable @State var wrapper = CVVisualizationBuilder().updatePositionsWrapperOne(style: Style.getDefault(), wrapper: CVEntityWrapper.getDefault())
//    let visualization = CVVisualizationBuilder()
//    let defaultWrapper = CVEntityWrapper.getDefault()
//    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    CVMakerPreviewView(cv: wrapper, isLoading: .constant(false), pageUpdateHandler: {}, doubleTapHandler: { i, b in })
}
