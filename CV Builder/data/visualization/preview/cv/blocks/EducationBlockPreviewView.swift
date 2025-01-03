//
//  EducationBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct EducationBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    var headerTextColor: String
    var mainTextColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var lineColor: String
    var lineCirclesColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var addDivider: Bool = false
    var addBlockPadding: Bool = false
    var addBottomPadding: Bool = false
    
    var body: some View {
        if let block = cv.educationBlock {
            BlockContainerPreviewView(isMainBlock: block.isMainBlock, marginsSize: cv.marginsSize, text: block.textEducation, font: cv.headersFont, textColor: headerTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: block.styleHeaderPosition, headerDotAdded: cv.headerDotAdded, headerLineAdded: cv.headerLineAdded, dotColor: dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, linePosition: cv.headerLinePosition, lineColor: lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addDivider: addDivider, addBlockPadding: addBlockPadding, addBottomPadding: addBottomPadding) {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 240))], spacing: 0) {
                    let list = block.list.sorted { $0.position < $1.position }
                    ForEach(0..<list.count, id:\.self) { item in
                        EducationItemPreviewView(cv: cv, block: block, item: list[item], isLast: item == list.count - 1, headerTextColor: headerTextColor, mainTextColor: mainTextColor, lineColor: lineColor, dotColor: dotColor, dotStrokeColor: dotStrokeColor)
                    }
                }
                
            }
        }
    }
}

struct EducationItemPreviewView: View {
    
    var cv: CVEntityWrapper
    var block: EducationBlockEntityWrapper
    var item: EducationBlockItemEntityWrapper
    var isLast: Bool
    
    var headerTextColor: String
    var mainTextColor: String
    
    var lineColor: String
    var dotColor: String
    var dotStrokeColor: String
    
    var body: some View {
        HStack (alignment: .top, spacing: CGFloat(cv.marginsSize)) {
            
            if block.isMainBlock && block.styleDateSeparated && !block.styleDateWithHeader && (item.startDate != nil || item.endDate != nil) {
                VStack {
                    TextPreviewView(text: getDateText(item: item), font: cv.textFont, color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false)
                }.frame(width: setLongestDateTextWidth(block: block, id: cv.textFont, size: cv.textSize)).padding(.top, CGFloat(cv.marginsSize / 5))
            }
            
            if block.styleDotsAdded && block.isMainBlock {
                ZStack {
                    Spacer(minLength: CGFloat(cv.dotSize))
                }.overlay {
                    ZStack (alignment: .top) {
                        if !isLast {
                            LinePreviewView(color: dotStrokeColor, width: cv.lineWidth / 2, cornersRadius: CGFloat(cv.cornersRadius), orientation: 1, dotAdded: false, dotBackColor: "", dotStrokeColor: "", dotBackAdded: false, dotStrokeAdded: false).offset(y: CGFloat(cv.dotSize / 2))
                        } else {
                            HStack {}.frame(maxHeight: .infinity)
                        }
                        DotPreviewView(color: dotColor, width: cv.dotSize, height: cv.dotSize, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, backAdded: cv.dotBackAdded, strokeAdded: cv.dotStrokeAdded)
                    }
                }.offset(y: 5)
            }
            
            VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                
                HStack (alignment: .top, spacing: CGFloat(cv.marginsSize / 3)) {
                    
                    if item.logoId != -1 {
                        ImagePreviewView(imageId: item.logoId, cornerTL: CGFloat(cv.cornersRadius), cornerTT: CGFloat(cv.cornersRadius), cornerBL: CGFloat(cv.cornersRadius), cornerBT: CGFloat(cv.cornersRadius), width: CGFloat(cv.iconSize) * 1.5, height: CGFloat(cv.iconSize) * 1.5, zoom: 1.0, filterEnabled: false, filterColor: "", strokeWidth: cv.strokeWidth, strokeColor: "", isCenterCropped: false)
                    }
                    
                    VStack (spacing: CGFloat(cv.marginsSize / 4)) {
                        if (!block.isMainBlock || !block.styleDateSeparated) && (item.startDate != nil || item.endDate != nil) && !block.styleDateWithHeader {
                            TextPreviewView(text: getDateText(item: item), font: cv.textFont, color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                        }
                        
                        if !getHeaderText().isEmpty {
                            TextPreviewView(text: getHeaderText(), font: cv.textFont, color: mainTextColor, gravity: .leading, size: Int(Double(cv.headersSize) * 0.72), isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased)
                        }
                        
                        if !getCompanyText().isEmpty {
                            TextPreviewView(text: getCompanyText(), font: cv.textFont, color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).opacity(0.5)
                        }
                    }.frame(maxWidth: .infinity)
                    
                }
                
                if !item.desc.isEmpty {
                    TextPreviewView(text: item.desc, font: cv.textFont, color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false).padding(.top, CGFloat(cv.marginsSize / 4))
                }
                
            }.padding(.bottom, CGFloat(cv.marginsSize))
        }
    }
    
    private func getDateText (item: EducationBlockItemEntityWrapper) -> String {
        var text = ""
        if block.styleDateInBrackets {
            text = text + "("
        }
        if let startDate = item.startDate {
            text = text + getDateMonthText(date: startDate)
        }
        if item.endDate != nil || item.isStillLearning {
            if item.isStillLearning {
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
        let degree = getDegreeText()
        if block.styleDateWithHeader {
            let date = getDateText(item: item)
            if date.isEmpty {
                return degree
            } else {
                if block.styleDateAfterHeader {
                    if block.styleDateInBrackets {
                        return degree + " " + date
                    } else {
                        return degree + " | " + date
                    }
                } else {
                    if block.styleDateInBrackets {
                        return date + " " + degree
                    } else {
                        return date + " | " + degree
                    }
                }
            }
        } else {
            return degree
        }
    }
    
    private func getDegreeText () -> String {
        if !item.degree.isEmpty {
            return item.degree
        } else if !item.level.isEmpty && !item.fieldOfStudy.isEmpty {
            return item.level + ", " + item.fieldOfStudy
        } else if !item.fieldOfStudy.isEmpty {
            return item.fieldOfStudy
        } else if !item.level.isEmpty {
            return item.level
        }
        return ""
    }
    
    private func getCompanyText () -> String {
        return item.institution
    }
    
    private func setLongestDateTextWidth (block: EducationBlockEntityWrapper, id: Int, size: Int) -> CGFloat {
        var longestText = ""
        
        for item in block.list {
            let date = getDateText(item: item)
            if date.count > longestText.count {
                longestText = date
            }
        }
        
        let width = longestText.widthUsingFont(id: id, size: size)
        if width > 60 {
            return 60
        } else {
            return width
        }
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    EducationBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "")
}
