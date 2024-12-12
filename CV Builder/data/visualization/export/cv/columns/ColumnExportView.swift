//
//  ColumnExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 09.12.2024.
//

import SwiftUI

struct ColumnExportView: View {
    
    var page: Int
    var isMainBlock: Bool
    var cv: CVEntityWrapper
    
    var addBlockPadding: Bool = false
    
    var headerTextColor: String
    var mainTextColor: String
    var blockBackgroundColors: [String]
    var blockStrokeColors: [String]
    
    var body: some View {
        VStack (spacing: 0) {
            
            BlockViewGetter.getBlockByPosition(cv: cv, position: 0, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[0], blockStrokeColor: blockStrokeColors[0], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 1, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[1], blockStrokeColor: blockStrokeColors[1], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 2, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[2], blockStrokeColor: blockStrokeColors[2], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 3, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[3], blockStrokeColor: blockStrokeColors[3], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 4, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[4], blockStrokeColor: blockStrokeColors[4], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 5, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[5], blockStrokeColor: blockStrokeColors[5], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 6, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[6], blockStrokeColor: blockStrokeColors[6], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 7, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[7], blockStrokeColor: blockStrokeColors[7], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 8, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[8], blockStrokeColor: blockStrokeColors[8], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 9, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[9], blockStrokeColor: blockStrokeColors[9], addBlockPadding: addBlockPadding)
            BlockViewGetter.getBlockByPosition(cv: cv, position: 10, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[10], blockStrokeColor: blockStrokeColors[10], addBlockPadding: addBlockPadding)
            
            Spacer()
            
        }.frame(maxHeight: .infinity)
    }
}

#Preview {
    @Previewable @State var mainColumnHeight: CGFloat = 0.0
    
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    ColumnExportView(page: 0, isMainBlock: true, cv: wrapper, headerTextColor: "#FFFFFF", mainTextColor: "#FFFFFF", blockBackgroundColors: ["#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF"], blockStrokeColors: ["","","","","","","","","",""])
}
