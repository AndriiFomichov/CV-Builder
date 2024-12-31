//
//  StyleFourPageOneExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleFourPageOneExportView: View {
    
    var cv: CVEntityWrapper
    var addWatermark: Bool
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        HStack (spacing: 0) {
            
            VStack (spacing: -1) {
                
                StyleFourGeneralBlockPreviewView(cv: cv, width: width, height: height)
                
                ColumnExportView(page: 0, isMainBlock: false, cv: cv, addDivider: false, addBlockPadding: true, addBottomPadding: false, headerTextColor: "#FFFFFF", mainTextColor: "#FFFFFF", blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).padding(.horizontal, CGFloat(cv.marginsSize)).background() {
                    Color(hex: cv.mainColor)
                }
                
            }.frame(width: width * 0.38)
            
            ColumnExportView(page: 0, isMainBlock: true, cv: cv, addDivider: true, addBlockPadding: true, addBottomPadding: false, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColors: ["","","","","","","","","","",""], blockStrokeColors: ["","","","","","","","","","",""]).frame(width: width * 0.62).overlay {
                WatermarkView(added: addWatermark)
            }
            
        }.contentShape(Rectangle()).frame(width: width, height: height).background() {
            Color(hex: "#EDEDEF")
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    
    StyleFourPageOneExportView(cv: wrapper, addWatermark: true)
}
