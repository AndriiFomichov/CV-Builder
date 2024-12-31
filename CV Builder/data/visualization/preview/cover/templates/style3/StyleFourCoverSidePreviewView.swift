//
//  StyleFourCoverSidePreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 31.12.2024.
//

import SwiftUI

struct StyleFourCoverSidePreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack (spacing: 0) {
            
            if let generalBlock = cv.generalBlock {
                ZStack (alignment: .bottom) {
                    Color(hex: "#EDEDEF")
                    
                    ImagePreviewView(imageId: generalBlock.photoId, imageName: "profile_photo_two_illustration", cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width: width * 0.3, height: height * 0.4, zoom: CGFloat(generalBlock.stylePhotoZoom), filterEnabled: generalBlock.stylePhotoFilterEnabled, filterColor: "#000000", strokeWidth: 0, strokeColor: "")
                    
                    StyleFourPhotoOverlay().fill(Color(hex: cv.mainColor)).frame(height: 25)
                    
                }.frame(height: height * 0.4)
                
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
                    
                }.padding(CGFloat(cv.marginsSize)).padding(.horizontal, CGFloat(cv.marginsSize / 2)).background() {
                    Color(hex: cv.mainColor).scaleEffect(1.01)
                }
            }
            
            if let contactBlock = cv.contactBlock {
                ZStack (alignment: .bottom) {
                    Color(hex: cv.mainColor).scaleEffect(1.01)
                    
                    VStack (spacing: CGFloat(cv.marginsSize / 3)) {
                        
                        if !contactBlock.email.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: contactBlock, text: contactBlock.email, icon: "envelope.fill", mainTextColor: "#FFFFFF", iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        }
                        
                        if !contactBlock.phone.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: contactBlock, text: contactBlock.phone, icon: "phone.fill", mainTextColor: "#FFFFFF", iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        }
                        
                        if !contactBlock.websiteLink.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: contactBlock, text: contactBlock.websiteLink, icon: "globe", mainTextColor: "#FFFFFF", iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        }
                        
                    }.padding(CGFloat(cv.marginsSize)).padding(.horizontal, CGFloat(cv.marginsSize / 2))
                }
            }
            
        }.clipped()
    }
}

#Preview {
    StyleFourCoverSidePreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
