//
//  SkillsBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct SkillsBlockPreviewView: View {
    
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
    
    var chipBackgroundColor: String
    var chipStrokeColor: String
    
    var addBlockPadding: Bool = false
    
    var body: some View {
        if let block = cv.skillsBlock {
            BlockContainerPreviewView(isMainBlock: block.isMainBlock, marginsSize: cv.marginsSize, text: block.textSkills, font: getFontByStyle(cv.headersFont), textColor: headerTextColor, gravity: .leading, size: cv.headersSize, isBold: cv.isHeadersBold, isItalic: cv.isHeadersItalic, isUnderline: false, isUppercased: cv.isHeadersUppercased, headerPosition: block.styleHeaderPosition, headerDotAdded: cv.headerDotAdded, headerLineAdded: cv.headerLineAdded, dotColor: dotColor, dotSize: cv.dotSize, dotBackAdded: cv.dotBackAdded, dotStrokeAdded: cv.dotStrokeAdded, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, linePosition: cv.headerLinePosition, lineColor: lineColor, lineCirclesAdded: cv.lineCirclesAdded, lineCirclesColor: lineCirclesColor, lienWidth: cv.lineWidth, cornersRadius: CGFloat(cv.cornersRadius), blockBackgroundColor: blockBackgroundColor, blockStrokeColor: blockStrokeColor, addBlockPadding: addBlockPadding) {
                
                ZStack (alignment: .leading) {
                    if block.styleIsChips {
                        ChipsLayout(alignment: .leading, spacing: CGFloat(cv.marginsSize / 3)) {
                            ForEach(0..<block.list.count, id:\.self) { item in
                                SkillsChipPreviewView(cv: cv, block: block, item: block.list[item], mainTextColor: mainTextColor, chipBackgroundColor: chipBackgroundColor, chipStrokeColor: chipStrokeColor)
                            }
                        }
                    } else {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: block.styleIsProgressAdded ? 240 : 90))], spacing: CGFloat(cv.marginsSize / 3)) {
                            ForEach(0..<block.list.count, id:\.self) { item in
                                SkillsItemPreviewView(cv: cv, block: block, item: block.list[item], mainTextColor: mainTextColor, progressForegroundColor: progressForegroundColor, progressBackgroundColor: progressBackgroundColor, dotColor: dotColor, dotStrokeColor: dotStrokeColor)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

struct SkillsItemPreviewView: View {
    
    var cv: CVEntityWrapper
    var block: SkillsBlockEntityWrapper
    var item: SkillBlockItemEntityWrapper
    
    var mainTextColor: String
    
    var progressForegroundColor: String
    var progressBackgroundColor: String
    
    var dotColor: String
    var dotStrokeColor: String
    
    var body: some View {
        HStack (spacing: CGFloat(cv.marginsSize / 3)) {
            if block.styleIsBulletedList && !block.styleIsProgressAdded {
                DotPreviewView(color: dotColor, width: cv.dotSize, height: cv.dotSize, strokeWidth: cv.strokeWidth, strokeColor: dotStrokeColor, backAdded: cv.dotBackAdded, strokeAdded: cv.dotStrokeAdded)
            }
            
            TextPreviewView(text: item.name, font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isInfinite: false)
            
            Spacer()
            
            if block.styleIsProgressAdded {
                if cv.progressBarStyle == 0 || cv.progressBarStyle == 3 {
                    ProgressBarPreviewView(progress: item.level >= 0 ? item.level + 1 : 0, steps: 5, height: cv.textSize, style: cv.progressBarStyle, accentColor: progressForegroundColor, backgroundColor: progressBackgroundColor, cornersRadius: CGFloat(cv.cornersRadius))
                } else {
                    ProgressBarPreviewView(progress: item.level >= 0 ? item.level + 1 : 0, steps: 5, height: cv.textSize, style: cv.progressBarStyle, accentColor: progressForegroundColor, backgroundColor: progressBackgroundColor, cornersRadius: CGFloat(cv.cornersRadius)).frame(maxWidth: 170)
                }
                
                if cv.progressBarPercentAdded && item.level >= 0 {
                    TextPreviewView(text: String((item.level+1) * 100 / 5) + "%", font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, isInfinite: false)
                }
            }
        }
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

struct SkillsChipPreviewView: View {
    
    var cv: CVEntityWrapper
    var block: SkillsBlockEntityWrapper
    var item: SkillBlockItemEntityWrapper
    
    var mainTextColor: String
    
    var chipBackgroundColor: String
    var chipStrokeColor: String
    
    var body: some View {
        ChipPreviewView(text: item.name, font: getFontByStyle(cv.textFont), color: mainTextColor, gravity: .leading, size: cv.textSize, isBold: false, isItalic: false, isUnderline: false, isUppercased: false, marginsSize: cv.marginsSize, cornersRadius: cv.cornersRadius, backColor: chipBackgroundColor, backAdded: cv.chipBackAdded, strokeWidth: cv.strokeWidth, strokeColor: chipStrokeColor, strokeAdded: cv.chipStrokeAdded)
    }
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

struct ChipsLayout: Layout {
  var alignment: Alignment = .center
  var spacing: CGFloat?

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
    let result = FlowResult(
      in: proposal.replacingUnspecifiedDimensions().width,
      subviews: subviews,
      alignment: alignment,
      spacing: spacing
    )
    return result.bounds
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
    let result = FlowResult(
      in: proposal.replacingUnspecifiedDimensions().width,
      subviews: subviews,
      alignment: alignment,
      spacing: spacing
    )
    for row in result.rows {
      let rowXOffset = (bounds.width - row.frame.width) * alignment.horizontal.percent
      for index in row.range {
        let xPos = rowXOffset + row.frame.minX + row.xOffsets[index - row.range.lowerBound] + bounds.minX
        let rowYAlignment = (row.frame.height - subviews[index].sizeThatFits(.unspecified).height) *
        alignment.vertical.percent
        let yPos = row.frame.minY + rowYAlignment + bounds.minY
        subviews[index].place(at: CGPoint(x: xPos, y: yPos), anchor: .topLeading, proposal: .unspecified)
      }
    }
  }

  struct FlowResult {
    var bounds = CGSize.zero
    var rows = [Row]()

    struct Row {
      var range: Range<Int>
      var xOffsets: [Double]
      var frame: CGRect
    }

    init(in maxPossibleWidth: Double, subviews: Subviews, alignment: Alignment, spacing: CGFloat?) {
      var itemsInRow = 0
      var remainingWidth = maxPossibleWidth.isFinite ? maxPossibleWidth : .greatestFiniteMagnitude
      var rowMinY = 0.0
      var rowHeight = 0.0
      var xOffsets: [Double] = []
      for (index, subview) in zip(subviews.indices, subviews) {
        let idealSize = subview.sizeThatFits(.unspecified)
        if index != 0 && widthInRow(index: index, idealWidth: idealSize.width) > remainingWidth {
          // Finish the current row without this subview.
          finalizeRow(index: max(index - 1, 0), idealSize: idealSize)
        }
        addToRow(index: index, idealSize: idealSize)

        if index == subviews.count - 1 {
          // Finish this row; it's either full or we're on the last view anyway.
          finalizeRow(index: index, idealSize: idealSize)
        }
      }

      func spacingBefore(index: Int) -> Double {
        guard itemsInRow > 0 else { return 0 }
        return spacing ?? subviews[index - 1].spacing.distance(to: subviews[index].spacing, along: .horizontal)
      }

      func widthInRow(index: Int, idealWidth: Double) -> Double {
        idealWidth + spacingBefore(index: index)
      }

      func addToRow(index: Int, idealSize: CGSize) {
        let width = widthInRow(index: index, idealWidth: idealSize.width)

        xOffsets.append(maxPossibleWidth - remainingWidth + spacingBefore(index: index))
        // Allocate width to this item (and spacing).
        remainingWidth -= width
        // Ensure the row height is as tall as the tallest item.
        rowHeight = max(rowHeight, idealSize.height)
        // Can fit in this row, add it.
        itemsInRow += 1
      }

      func finalizeRow(index: Int, idealSize: CGSize) {
        let rowWidth = maxPossibleWidth/* - remainingWidth*/
        rows.append(
          Row(
            range: index - max(itemsInRow - 1, 0) ..< index + 1,
            xOffsets: xOffsets,
            frame: CGRect(x: 0, y: rowMinY, width: rowWidth, height: rowHeight)
          )
        )
        bounds.width = max(bounds.width, rowWidth)
        let ySpacing = spacing ?? ViewSpacing().distance(to: ViewSpacing(), along: .vertical)
        bounds.height += rowHeight + (rows.count > 1 ? ySpacing : 0)
        rowMinY += rowHeight + ySpacing
        itemsInRow = 0
        rowHeight = 0
        xOffsets.removeAll()
        remainingWidth = maxPossibleWidth
      }
    }
  }
}

private extension HorizontalAlignment {
  var percent: Double {
    switch self {
      case .leading: return 0
      case .trailing: return 1
      default: return 0.5
    }
  }
}

private extension VerticalAlignment {
  var percent: Double {
    switch self {
      case .top: return 0
      case .bottom: return 1
      default: return 0.5
    }
  }
}

#Preview {
        let visualization = CVVisualizationBuilder()
        let defaultWrapper = CVEntityWrapper.getDefault()
        let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
        
//        @Previewable @State var wrapper = CVVisualizationBuilder().updatePositionsWrapperOne(style: Style.getDefault(), wrapper: CVEntityWrapper.getDefault())
    SkillsBlockPreviewView(cv: wrapper, headerTextColor: "#000000", mainTextColor: "#000000", blockBackgroundColor: "", blockStrokeColor: "", progressForegroundColor: "", progressBackgroundColor: "", lineColor: "", lineCirclesColor: "", dotColor: "", dotStrokeColor: "", chipBackgroundColor: "", chipStrokeColor: "")
}
