//
//  StyleOnePageTwoExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.11.2024.
//

import SwiftUI

struct StyleOnePageTwoExportView: View {
    
    var cv: CVEntityWrapper
    var page: Int
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        HStack (spacing: 0) {
            
            ColumnExportView(page: page, isMainBlock: false, cv: cv, addBlockPadding: true, headerTextColor: "#FFFFFF", mainTextColor: "#FFFFFF", blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: width * 0.38).background() {
                Color(hex: "#262626")
            }
            
            ColumnExportView(page: page, isMainBlock: true, cv: cv, addBlockPadding: true, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","#EBEBEB","","#EBEBEB","","#EBEBEB","","#EBEBEB","","#EBEBEB",""], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: width * 0.62)
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#F5F5F5")
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    StyleOnePageTwoExportView(cv: wrapper, page: 1)
}
