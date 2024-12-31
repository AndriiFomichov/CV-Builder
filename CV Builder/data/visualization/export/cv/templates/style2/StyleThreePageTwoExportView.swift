//
//  StyleThreePageTwoExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleThreePageTwoExportView: View {
    
    var cv: CVEntityWrapper
    var page: Int
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        HStack (spacing: CGFloat(cv.marginsSize)) {
            
            ColumnExportView(page: page, isMainBlock: true, cv: cv, addDivider: true, addBlockPadding: false, addBottomPadding: true, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: (width - CGFloat(cv.marginsSize * 5)) * 0.62).padding(.vertical, CGFloat(cv.marginsSize * 2))
            
            ColumnExportView(page: page, isMainBlock: false, cv: cv, addDivider: false, addBlockPadding: true, addBottomPadding: true, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3"], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: (width - CGFloat(cv.marginsSize * 5)) * 0.38).padding(.vertical, CGFloat(cv.marginsSize * 2))
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#F3F5F7")
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    StyleThreePageTwoExportView(cv: wrapper, page: 1)
}
