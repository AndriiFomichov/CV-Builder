//
//  StyleOneGeneralBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.12.2024.
//

import SwiftUI

struct StyleOneGeneralBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if let generalBlock = cv.generalBlock {
            VStack (spacing: 0) {
                ZStack {
                    Color(hex: "#CFCFCF")
                    ImagePreviewView(imageId: generalBlock.photoId, imageName: "profile_photo_two_illustration", cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width: width * 0.38, height: height * 0.4, zoom: CGFloat(generalBlock.stylePhotoZoom), filterEnabled: generalBlock.stylePhotoFilterEnabled, filterColor: "#000000", strokeWidth: 0, strokeColor: "")
                }.frame(height: height * 0.4)
                
                VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                    
                    if !generalBlock.name.isEmpty {
                        TextPreviewView(text: generalBlock.name, font: getFontByStyle(cv.headersFont), color: "#FFFFFF", gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                    }
                    
                    if !generalBlock.jobTitle.isEmpty {
                        TextPreviewView(text: generalBlock.jobTitle, font: getFontByStyle(cv.textFont), color: "#FFFFFF", gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased).opacity(0.8)
                    }
                    
                    if !generalBlock.location.isEmpty {
                        TextPreviewView(text: generalBlock.location, font: getFontByStyle(cv.textFont), color: "#FFFFFF", gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                    }
                    
                }.padding(CGFloat(cv.marginsSize)).background() {
                    Color(hex: "#1D1D1D")
                }
            }
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

#Preview {
    StyleOneGeneralBlockPreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
