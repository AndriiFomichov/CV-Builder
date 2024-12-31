//
//  StyleFourGeneralBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleFourGeneralBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if let generalBlock = cv.generalBlock {
            VStack (spacing: 0) {
                ZStack (alignment: .bottom) {
                    Color(hex: "#EDEDEF")
                    
                    ImagePreviewView(imageId: generalBlock.photoId, imageName: "profile_photo_two_illustration", cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width: width * 0.38, height: height * 0.5, zoom: CGFloat(generalBlock.stylePhotoZoom), filterEnabled: generalBlock.stylePhotoFilterEnabled, filterColor: "#000000", strokeWidth: 0, strokeColor: "")
                    
                    StyleFourPhotoOverlay().fill(Color(hex: cv.mainColor)).frame(height: 25).offset(y: 1)
                    
                }.frame(height: height * 0.5).clipped()
                
                VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                    
                    if !generalBlock.name.isEmpty {
                        TextPreviewView(text: generalBlock.name, font: cv.nameFont, color: "#FFFFFF", gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                    }
                    
                    if !generalBlock.jobTitle.isEmpty {
                        TextPreviewView(text: generalBlock.jobTitle, font: cv.textFont, color: "#FFFFFF", gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased).opacity(0.8)
                    }
                    
                    if !generalBlock.location.isEmpty {
                        TextPreviewView(text: generalBlock.location, font: cv.textFont, color: "#FFFFFF", gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                    }
                    
                }.padding([.leading, .trailing, .bottom], CGFloat(cv.marginsSize)).padding(.horizontal, CGFloat(cv.marginsSize)).background() {
                    Color(hex: cv.mainColor)
                }
            }
        }
    }
}

struct StyleFourPhotoOverlay: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX - 20, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

        return path
    }
}

#Preview {
    StyleFourGeneralBlockPreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
