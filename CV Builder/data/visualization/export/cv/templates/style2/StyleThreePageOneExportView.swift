//
//  StyleThreePageOneExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleThreePageOneExportView: View {
    
    var cv: CVEntityWrapper
    var addWatermark: Bool
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        VStack (spacing: CGFloat(cv.marginsSize * 2)) {
            
            HStack (spacing: CGFloat(cv.marginsSize)) {
                
                VStack (spacing: CGFloat(cv.marginsSize * 2)) {
                    
                    StyleThreeGeneralBlockLeftPreviewView(cv: cv, width: width, height: height)
                    
                    ColumnExportView(page: 0, isMainBlock: true, cv: cv, addDivider: true, addBlockPadding: false, addBottomPadding: true, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""])
                    
                }.frame(width: (width - CGFloat(cv.marginsSize * 5)) * 0.62)
                
                VStack (spacing: CGFloat(cv.marginsSize)) {
                    
                    StyleThreeGeneralBlockRightPreviewView(cv: cv, width: width, height: height)
                    
                    ColumnExportView(page: 0, isMainBlock: false, cv: cv, addDivider: false, addBlockPadding: true, addBottomPadding: true, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3","#EDF0F3"], blockStrokeColors: ["","","","","","","","","","",""])
                    
                }.frame(width: (width - CGFloat(cv.marginsSize * 5)) * 0.38)
                
            }
            
            StyleThreeBottomPreviewView(cv: cv, width: width, height: height).frame(width: (width - CGFloat(cv.marginsSize * 4)))
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#F3F5F7")
        }.overlay {
            WatermarkView(added: addWatermark)
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    StyleThreePageOneExportView(cv: wrapper, addWatermark: true)
}
