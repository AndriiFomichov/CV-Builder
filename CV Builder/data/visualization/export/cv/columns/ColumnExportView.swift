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
    
    var addDivider: Bool
    var addBlockPadding: Bool
    var addBottomPadding: Bool
    
    var headerTextColor: String
    var mainTextColor: String
    var blockBackgroundColors: [String]
    var blockStrokeColors: [String]
    
    var body: some View {
        GeometryReader { geo in
            VStack (spacing: 0) {
                ForEach(0..<11, id: \.self) { index in
                    
                    
                    BlockViewGetter.getBlockByPosition(cv: cv, position: index, page: page, isMainBlock: isMainBlock, headerTextColor: headerTextColor, mainTextColor: mainTextColor, blockBackgroundColor: blockBackgroundColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: index, page: page, isMainBlock: isMainBlock)], blockStrokeColor: blockStrokeColors[BlockViewGetter.getBackgroundIndexByPosition(cv: cv, position: index, page: page, isMainBlock: isMainBlock)], addDivider: addDivider, addBlockPadding: addBlockPadding, addBottomPadding: addBottomPadding)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var mainColumnHeight: CGFloat = 0.0
    
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    ColumnExportView(page: 0, isMainBlock: true, cv: wrapper, addDivider: true, addBlockPadding: true, addBottomPadding: true, headerTextColor: "#FFFFFF", mainTextColor: "#FFFFFF", blockBackgroundColors: ["#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF","#FFFFFF"], blockStrokeColors: ["","","","","","","","","",""])
}
