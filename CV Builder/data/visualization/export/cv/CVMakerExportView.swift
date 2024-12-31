//
//  CVMakerExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

struct CVMakerExportView: View {
    
    let cv: CVEntityWrapper
    let page: Int
    let addWatermark: Bool
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    init(cv: CVEntityWrapper, page: Int, addWatermark: Bool) {
        self.cv = CVDefaultsWrapper().fullfill(wrapper: cv)
        self.page = page
        self.addWatermark = addWatermark
    }
    
    var body: some View {
        switch cv.style {
        case 0:
            if page == 0 {
                StyleOnePageOneExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            } else {
                StyleOnePageTwoExportView(cv: cv, page: page, width: width, height: height)
            }
        case 1:
            if page == 0 {
                StyleTwoPageOneExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            } else {
                StyleTwoPageTwoExportView(cv: cv, page: page, width: width, height: height)
            }
        case 2:
            if page == 0 {
                StyleThreePageOneExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            } else {
                StyleThreePageTwoExportView(cv: cv, page: page, width: width, height: height)
            }
        case 3:
            if page == 0 {
                StyleFourPageOneExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            } else {
                StyleFourPageTwoExportView(cv: cv, page: page, width: width, height: height)
            }
        default:
            VStack {}
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    CVMakerExportView(cv: wrapper, page: 1, addWatermark: true)
}
