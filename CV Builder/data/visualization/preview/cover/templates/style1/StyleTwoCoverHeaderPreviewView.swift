//
//  StyleTwoCoverHeaderPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.12.2024.
//

import SwiftUI

struct StyleTwoCoverHeaderPreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if let generalBlock = cv.generalBlock {
            VStack (spacing: CGFloat(cv.marginsSize)) {
                
                HStack (spacing: CGFloat(cv.marginsSize)) {
                    
                    if generalBlock.photoId != -1 {
                        ZStack {
                            Color(hex: cv.iconBackgroundColor)
                            ImagePreviewView(imageId: generalBlock.photoId, imageName: "profile_photo_two_illustration", cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width:  width * 0.2, height: height * 0.2, zoom: CGFloat(generalBlock.stylePhotoZoom), filterEnabled: generalBlock.stylePhotoFilterEnabled, filterColor: "#000000", strokeWidth: 0, strokeColor: "")
                        }.frame(width: width * 0.2, height: height * 0.2)
                    }
                    
                    VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                        if !generalBlock.name.isEmpty {
                            TextPreviewView(text: generalBlock.name, font: cv.nameFont, color: cv.headerTextColor, gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                        }
                        
                        if !generalBlock.jobTitle.isEmpty {
                            TextPreviewView(text: generalBlock.jobTitle, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased).opacity(0.8)
                        }
                        
                        if !generalBlock.location.isEmpty {
                            TextPreviewView(text: generalBlock.location, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                        }
                    }
                }
                
                LinePreviewView(color: cv.lineColor, width: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), orientation: 0, dotAdded: cv.lineCirclesAdded, dotBackColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded)
            }
        }
    }
}

#Preview {
    StyleTwoCoverHeaderPreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
