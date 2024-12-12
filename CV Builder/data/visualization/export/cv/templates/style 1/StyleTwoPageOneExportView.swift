//
//  StyleTwoPageOneExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct StyleTwoPageOneExportView: View {
    
    var cv: CVEntityWrapper
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        HStack (spacing: CGFloat(cv.marginsSize * 2)) {
            
            VStack (spacing: 0) {
                
                StyleTwoGeneralBlockLeftPreviewView(cv: cv, width: width, height: height).padding(.bottom, CGFloat(cv.marginsSize * 2))
                
                ColumnExportView(page: 0, isMainBlock: true, cv: cv, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""])
                
            }.frame(width: (width - CGFloat(cv.marginsSize * 6)) * 0.6).padding(.vertical, CGFloat(cv.marginsSize * 2))
            
            VStack (spacing: 0) {
                
                StyleTwoGeneralBlockRightPreviewView(cv: cv, width: width, height: height).padding(.bottom, CGFloat(cv.marginsSize * 2))
                
                ColumnExportView(page: 0, isMainBlock: false, cv: cv, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""])
                
            }.frame(width: (width - CGFloat(cv.marginsSize * 6)) * 0.4).padding(.vertical, CGFloat(cv.marginsSize * 2))
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: cv.mainColor)
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    StyleTwoPageOneExportView(cv: wrapper)
}
