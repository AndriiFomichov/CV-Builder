//
//  CoverMakerExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct CoverMakerExportView: View {
    
    let cv: CVEntityWrapper
    
    var width: CGFloat = 595.11
    var height: CGFloat = 841.66
    
    var body: some View {
        if let coverLetter = cv.coverLetter {
            switch cv.style {
            case 0:
                StyleOneCoverExportView(cv: cv, width: width, height: height)
            case 1:
                StyleTwoCoverExportView(cv: cv, width: width, height: height)
            default:
                VStack {}
            }
        }
    }
}

#Preview {
    CoverMakerExportView(cv: CVEntityWrapper.getDefault())
}
