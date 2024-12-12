//
//  LanguagesBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct LanguagesBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var headerTextColor: String
    var mainTextColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var progressForegroundColor: String
    var progressBackgroundColor: String
    
    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var addBlockPadding: Bool = false
    
    var body: some View {
        if let block = cv.languagesBlock {
            BlockContainerPreviewView(isMainBlock: block.isMainBlock, marginsSize: cv.marginsSize, text: block.textLanguages, font: getFontByStyle(cv.headersFont), textColor: headerTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: block.styleHeaderPosition, headerDotAdded: cv.headerDotAdded, headerLineAdded: cv.headerLineAdded, dotColor: dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, linePosition: cv.headerLinePosition, lineColor: lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addBlockPadding: addBlockPadding) {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: block.styleIsProgressAdded ? 240 : 120))], spacing: CGFloat(cv.marginsSize / 3)) {
                    ForEach(0..<block.list.count, id:\.self) { item in
                        LanguagesItemPreviewView(cv: cv, block: block, item: block.list[item], language: PreloadedDatabase.getLanguageById(id: block.list[item].langId), mainTextColor: mainTextColor, progressForegroundColor: progressForegroundColor, progressBackgroundColor: progressBackgroundColor, dotColor: dotColor, dotStrokeColor: dotStrokeColor)
                    }
                }
                
            }
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

struct LanguagesItemPreviewView: View {
    
    var cv: CVEntityWrapper
    var block: LanguagesBlockEntityWrapper
    var item: LanguageBlockItemEntityWrapper
    var language: Language?
    
    var mainTextColor: String
    
    var progressForegroundColor: String
    var progressBackgroundColor: String
    
    var dotColor: String
    var dotStrokeColor: String
    
    var body: some View {
        HStack (spacing: CGFloat(cv.marginsSize / 3)) {
            
            if block.styleIsBulletedList && !block.styleIsProgressAdded {
                DotPreviewView(color: dotColor, width: cv.dotSize, height: cv.dotSize, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, backAdded: cv.dotBackAdded, strokeAdded: cv.dotStrokeAdded)
            } else if let language, block.styleIconAdded {
                ImagePreviewView(imageId: -1, imageName: language.icon, cornerTL: 0.0, cornerTT: 0.0, cornerBL: 0.0, cornerBT: 0.0, width: CGFloat(cv.iconSize), height: CGFloat(cv.iconSize), zoom: 1.0, filterEnabled: false, filterColor: "", strokeWidth: 0, strokeColor: "")
            }
            
            TextPreviewView(text: item.name, font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isInfinite: false)
            
            Spacer()
            
            if block.styleIsProgressAdded {
                if cv.progressBarStyle == 0 || cv.progressBarStyle == 3 {
                    ProgressBarPreviewView(progress: item.level >= 0 ? item.level + 1 : 0, steps: 6, height: cv.textSize, style: cv.progressBarStyle, accentColor: progressForegroundColor, backgroundColor: progressBackgroundColor, cornersRadius: CGFloat(cv.cornersRadius))
                } else {
                    ProgressBarPreviewView(progress: item.level >= 0 ? item.level + 1 : 0, steps: 6, height: cv.textSize, style: cv.progressBarStyle, accentColor: progressForegroundColor, backgroundColor: progressBackgroundColor, cornersRadius: CGFloat(cv.cornersRadius)).frame(maxWidth: 170)
                }
                
                if cv.progressBarPercentAdded && item.level >= 0 {
                    TextPreviewView(text: String((item.level+1) * 100 / 6) + "%", font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isInfinite: false)
                }
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
    LanguagesBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "", progressForegroundColor: "", progressBackgroundColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "")
}
