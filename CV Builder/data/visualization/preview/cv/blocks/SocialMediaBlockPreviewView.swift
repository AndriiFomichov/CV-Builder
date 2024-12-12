//
//  SocialMediaBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct SocialMediaBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var headerTextColor: String
    var mainTextColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var addBlockPadding: Bool = false
    
    var body: some View {
        if let block = cv.socialBlock {
            VStack (spacing: 0) {

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: CGFloat(cv.marginsSize / 3)) {
                    ForEach(0..<block.list.count, id:\.self) { index in
                        SocialMediaItemPreviewView(cv: cv, block: block, item: block.list[index], media: getMediaById(id: block.list[index].media), headerTextColor: headerTextColor, mainTextColor: mainTextColor)
                    }
                }
                
            }.padding(CGFloat(addBlockPadding ? cv.marginsSize : 0)).padding(.bottom, CGFloat(addBlockPadding ? 0 : cv.marginsSize)).background() {
                if !blockBackgroundColor.isEmpty {
                    RoundedRectangle(cornerRadius: CGFloat(0)).fill(Color(hex: blockBackgroundColor))
                }
            }.overlay {
                if !blockStrokeColor.isEmpty {
                    RoundedRectangle(cornerRadius: CGFloat(0)).fill(.clear).stroke(Color(hex: blockStrokeColor), style: StrokeStyle(lineWidth: CGFloat(cv.strokeWidth)))
                }
            }
        }
    }
    
    private func getMediaById (id: Int) -> SocialMedia {
        if let media = PreloadedDatabase.getSocialMediaById(id: id) {
            return media
        } else {
            return SocialMedia(id: -1, name: NSLocalizedString("social_media_sug_8", comment: ""), icon: "link.circle.fill", isSelected: false)
        }
    }
}

struct SocialMediaItemPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var block: SocialMediaBlockEntityWrapper
    var item: SocialMediaBlockItemEntityWrapper
    var media: SocialMedia
    
    var headerTextColor: String
    var mainTextColor: String
    
    var body: some View {
        HStack (spacing: 0) {
            if block.styleIconAdded {
                ImagePreviewView(imageId: -1, imageName: media.icon, cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width: CGFloat(cv.iconSize), height: CGFloat(cv.iconSize), zoom: 1.0, filterEnabled: false, filterColor: "", strokeWidth: 0, strokeColor: "").padding(.trailing, CGFloat(cv.marginsSize / 3))
            }
            
            VStack (spacing: 0) {
                
                if !block.styleIconAdded {
                    TextPreviewView(text: media.name, font: getFontByStyle(cv.textFont), color: headerTextColor, gravity: .leading, size: Int(Double(cv.headersSize) * 0.72), isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased).padding(.bottom, CGFloat(cv.marginsSize / 4))
                }
                
                TextPreviewView(text: item.link, font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
            }
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    SocialMediaBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "")
}