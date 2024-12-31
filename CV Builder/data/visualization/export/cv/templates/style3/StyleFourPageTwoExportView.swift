//
//  StyleFourPageTwoExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleFourPageTwoExportView: View {
    
    var cv: CVEntityWrapper
    var page: Int
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        HStack (spacing: 0) {
            
            ColumnExportView(page: page, isMainBlock: false, cv: cv, addDivider: false, addBlockPadding: true, addBottomPadding: false, headerTextColor: "#FFFFFF", mainTextColor: "#FFFFFF", blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).padding(.horizontal, CGFloat(cv.marginsSize)).background() {
                Color(hex: cv.mainColor)
            }.frame(width: width * 0.38)
            
            ColumnExportView(page: page, isMainBlock: true, cv: cv, addDivider: true, addBlockPadding: true, addBottomPadding: false, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: width * 0.62)
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#EDEDEF")
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    StyleFourPageTwoExportView(cv: wrapper, page: 1)
}
