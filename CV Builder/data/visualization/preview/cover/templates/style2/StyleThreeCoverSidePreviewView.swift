//
//  StyleThreeCoverSidePreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.12.2024.
//

import SwiftUI

struct StyleThreeCoverSidePreviewView: View {
    
    var cv: CVEntityWrapper
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack (spacing: CGFloat(cv.marginsSize)) {
            
            if let generalBlock = cv.generalBlock {
                ZStack {
                    Color(hex: cv.iconBackgroundColor)
                    
                    ImagePreviewView(imageId: generalBlock.photoId, imageName: "profile_photo_two_illustration", cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width: width * 0.3, height: height * 0.36, zoom: CGFloat(generalBlock.stylePhotoZoom), filterEnabled: generalBlock.stylePhotoFilterEnabled, filterColor: "#000000", strokeWidth: 0, strokeColor: "")
                    
                }.frame(height: height * 0.36)
                
                VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                    
                    if !generalBlock.name.isEmpty {
                        TextPreviewView(text: generalBlock.name, font: cv.nameFont, color: cv.headerTextColor, gravity: .leading, size: cv.nameSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                    }
                    
                    if !generalBlock.jobTitle.isEmpty {
                        TextPreviewView(text: generalBlock.jobTitle, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased).opacity(0.8)
                    }
                    
                    if !generalBlock.location.isEmpty {
                        TextPreviewView(text: generalBlock.location, font: cv.textFont, color: cv.mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.6)
                    }
                    
                }.padding(CGFloat(cv.marginsSize)).background() {
                    Color(hex: "#EDF0F3")
                }
            }
            
            if let contactBlock = cv.contactBlock {
                ZStack (alignment: .top) {
                    Color.clear
                    VStack (spacing: CGFloat(cv.marginsSize / 3)) {
                        
                        if !contactBlock.email.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: contactBlock, text: contactBlock.email, icon: "envelope.fill", mainTextColor: cv.mainTextColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        }
                        
                        if !contactBlock.phone.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: contactBlock, text: contactBlock.phone, icon: "phone.fill", mainTextColor: cv.mainTextColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        }
                        
                        if !contactBlock.websiteLink.isEmpty {
                            ContactInfoItemPreviewView(cv: cv, block: contactBlock, text: contactBlock.websiteLink, icon: "globe", mainTextColor: cv.mainTextColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor)
                        }
                        
                    }.padding(CGFloat(cv.marginsSize)).background() {
                        Color(hex: "#EDF0F3")
                    }
//                    ContactInfoBlockPreviewView(cv: cv, headerTextColor: cv.headerTextColor, mainTextColor: cv.mainTextColor, blockBackgroundColor: "#EDF0F3", blockStrokeColor: "", lineColor: cv.lineColor, lineCirclesColor: cv.lineCirclesColor, dotColor: cv.dotColor, dotStrokeColor: cv.dotStrokeColor, iconColor: cv.iconColor, iconBackgroundColor: cv.iconBackgroundColor, iconStrokeColor: cv.iconStrokeColor, addBlockPadding: true, addBottomPadding: false)
                }
            }
        }
    }
}

#Preview {
    StyleThreeCoverSidePreviewView(cv: CVEntityWrapper.getDefault(), width: 600, height: 800)
}
