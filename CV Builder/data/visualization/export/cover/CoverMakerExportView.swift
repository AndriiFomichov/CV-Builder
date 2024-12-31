//
//  CoverMakerExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct CoverMakerExportView: View {
    
    let cv: CVEntityWrapper
    let addWatermark: Bool
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        if cv.coverLetter != nil {
            switch cv.style {
            case 0:
                StyleOneCoverExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            case 1:
                StyleTwoCoverExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            case 2:
                StyleThreeCoverExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            case 3:
                StyleFourCoverExportView(cv: cv, addWatermark: addWatermark, width: width, height: height)
            default:
                VStack {}
            }
        }
    }
}

#Preview {
    CoverMakerExportView(cv: CVEntityWrapper.getDefault(), addWatermark: true)
}
