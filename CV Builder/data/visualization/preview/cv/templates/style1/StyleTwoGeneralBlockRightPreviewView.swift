//
//  StyleTwoGeneralBlockRightPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct StyleTwoGeneralBlockRightPreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Color(hex: cv.iconBackgroundColor)
            
            if let generalBlock = cv.generalBlock {
                ImagePreviewView(imageId: generalBlock.photoId, imageName: "profile_photo_two_illustration", cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width: (width - CGFloat(cv.marginsSize * 6)) * 0.4, height: height * 0.4, zoom: CGFloat(generalBlock.stylePhotoZoom), filterEnabled: generalBlock.stylePhotoFilterEnabled, filterColor: "#000000", strokeWidth: 0, strokeColor: "")
            }
            
        }.frame(height: height * 0.4)
    }
}

#Preview {
    StyleTwoGeneralBlockRightPreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
