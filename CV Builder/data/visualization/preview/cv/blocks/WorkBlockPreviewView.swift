//
//  WorkBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct WorkBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var headerTextColor: String
    var mainTextColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var addBlockPadding: Bool = false
    
    var body: some View {
        if let block = cv.workBlock {
            BlockContainerPreviewView(isMainBlock: block.isMainBlock, marginsSize: cv.marginsSize, text: block.workExperience, font: getFontByStyle(cv.headersFont), textColor: headerTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: block.styleHeaderPosition, headerDotAdded: cv.headerDotAdded, headerLineAdded: cv.headerLineAdded, dotColor: dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, linePosition: cv.headerLinePosition, lineColor: lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addBlockPadding: addBlockPadding) {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))], spacing: 0) {
                    ForEach(0..<block.list.count, id:\.self) { item in
                        WorkItemPreviewView(cv: cv, block: block, item: block.list[item], isLast: item == block.list.count - 1, headerTextColor: headerTextColor, mainTextColor: mainTextColor, lineColor: lineColor, dotColor: dotColor,  dotStrokeColor: dotStrokeColor)
                    }
                }
                
            }
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

struct WorkItemPreviewView: View {
    
    var cv: CVEntityWrapper
    var block: WorkBlockEntityWrapper
    var item: WorkBlockItemEntityWrapper
    var isLast: Bool
    
    var headerTextColor: String
    var mainTextColor: String
    
    var lineColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var body: some View {
        HStack (alignment: .top, spacing: 0) {
            
            if block.isMainBlock && block.styleDateSeparated && !block.styleDateWithHeader && (item.startDate != nil || item.endDate != nil) {
                VStack {
                    TextPreviewView(text: getDateText(), font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
                }.frame(width: 100).padding(.top, CGFloat(cv.marginsSize / 5)).padding(.trailing, CGFloat(cv.marginsSize))
            }
            
            if block.styleDotsAdded && block.isMainBlock {
                ZStack {
                    Spacer(minLength: CGFloat(cv.dotSize))
                }.overlay {
                    ZStack (alignment: .top) {
                        if !isLast {
                            LinePreviewView(color: lineColor, width: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), orientation: 1, dotAdded: false, dotBackColor: "", dotStrokeColor: "", dotBackAdded: false, dotStrokeAdded: false)
                        } else {
                            HStack {}.frame(maxHeight: .infinity)
                        }
                        DotPreviewView(color: dotColor, width: cv.dotSize, height: cv.dotSize, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, backAdded: cv.dotBackAdded, strokeAdded: cv.dotStrokeAdded)
                    }
                }.offset(y: 6)
            }
            
            VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                
                if (!block.isMainBlock || !block.styleDateSeparated) && (item.startDate != nil || item.endDate != nil) && !block.styleDateWithHeader {
                    TextPreviewView(text: getDateText(), font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                }
                
                if !getHeaderText().isEmpty {
                    HStack (spacing: CGFloat(cv.marginsSize / 4)) {
                        TextPreviewView(text: getHeaderText(), font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: Int(Double(cv.headersSize) * 0.72), isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                        
                        if item.iconId != -1 {
                            ImagePreviewView(imageId: item.iconId, cornerTL: CGFloat(cv.cornersRadius), cornerTT: CGFloat(cv.cornersRadius), cornerBL: CGFloat(cv.cornersRadius), cornerBT: CGFloat(cv.cornersRadius), width: CGFloat(cv.iconSize * 2), height: CGFloat(cv.iconSize * 2), zoom: 1.0, filterEnabled: false, filterColor: "", strokeWidth: cv.strokeWidth, strokeColor: "")
                        }
                    }
                }
                
                if !getCompanyText().isEmpty {
                    TextPreviewView(text: getCompanyText(), font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                }
                
                if !item.desc.isEmpty {
                    TextPreviewView(text: item.desc, font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).padding(.top, CGFloat(cv.marginsSize / 4))
                }
                
            }.padding(.vertical, CGFloat(cv.marginsSize / 2)).padding(.leading, block.styleDotsAdded && block.isMainBlock ? CGFloat(cv.marginsSize / 2) : 0)
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
    
    private func getDateText () -> String {
        var text = ""
        if block.styleDateInBrackets {
            text = text + "("
        }
        if let startDate = item.startDate {
            text = text + getDateMonthText(date: startDate)
        }
        if item.endDate != nil || item.isStillWorking {
            if item.isStillWorking {
                text = text + " - " + NSLocalizedString("present", comment: "")
            } else {
                if let endDate = item.endDate {
                    if !text.isEmpty {
                        text = text + " - "
                    }
                    text = text + getDateMonthText(date: endDate)
                }
            }
        }
        if block.styleDateInBrackets {
            text = text + ")"
        }
        return text
    }
    
    private func getDateMonthText (date: Date) -> String {
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        if block.styleMonthDisplayed {
            return NSLocalizedString("month_" + String(month-1), comment: "") + "'" + String(year)
        } else {
            return String(year)
        }
    }
    
    private func getHeaderText () -> String {
        let position = getPositionText()
        if block.styleDateWithHeader {
            let date = getDateText()
            if date.isEmpty {
                return position
            } else {
                if block.styleDateAfterHeader {
                    if block.styleDateInBrackets {
                        return position + " " + date
                    } else {
                        return position + " | " + date
                    }
                } else {
                    if block.styleDateInBrackets {
                        return date + " " + position
                    } else {
                        return date + " | " + position
                    }
                }
            }
        } else {
            return position
        }
    }
    
    private func getPositionText () -> String {
        if !item.jobTitle.isEmpty {
            return item.jobTitle
        }
        return ""
    }
    
    private func getCompanyText () -> String {
        return item.company
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    WorkBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "")
}