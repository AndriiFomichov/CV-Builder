//
//  StyleTwoPageTwoExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct StyleTwoPageTwoExportView: View {
    
    var cv: CVEntityWrapper
    var page: Int
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        HStack (spacing: CGFloat(cv.marginsSize * 2)) {
            
            ColumnExportView(page: page, isMainBlock: true, cv: cv, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: (width - CGFloat(cv.marginsSize * 6)) * 0.6).padding(.vertical, CGFloat(cv.marginsSize * 2))
            
            ColumnExportView(page: page, isMainBlock: false, cv: cv, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: (width - CGFloat(cv.marginsSize * 6)) * 0.4).padding(.vertical, CGFloat(cv.marginsSize * 2))
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: cv.mainColor)
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    StyleTwoPageTwoExportView(cv: wrapper, page: 1)
}
