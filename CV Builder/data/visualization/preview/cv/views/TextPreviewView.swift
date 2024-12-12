//
//  TextPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct TextPreviewView: View {
    
    var text: String
    var font: String
    var color: String
    var gravity: Alignment
    var size: Int
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool
    var isUppercased: Bool
    var isInfinite: Bool = true
    
    var body: some View {
        if isInfinite {
            Text(getTextUppercased(text: text)).font(SwiftUI.Font.custom(NSLocalizedString(font, comment: ""), size: CGFloat(size))).frame(maxWidth: .infinity, alignment: gravity).multilineTextAlignment(getTextAlignment(gravity: gravity)).foregroundStyle(Color(hex: color)).bold(isBold).italic(isItalic).underline(isUnderline).fixedSize(horizontal: false, vertical: true)
        } else {
            Text(getTextUppercased(text: text)).font(SwiftUI.Font.custom(NSLocalizedString(font, comment: ""), size: CGFloat(size))).frame(alignment: gravity).multilineTextAlignment(getTextAlignment(gravity: gravity)).foregroundStyle(Color(hex: color)).bold(isBold).italic(isItalic).underline(isUnderline).fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private func getTextUppercased (text: String) -> String {
        var finalText = text
        if isUppercased {
            finalText = finalText.uppercased()
        }
        return finalText
    }
    
    private func getTextAlignment (gravity: Alignment) -> TextAlignment {
        switch gravity {
        case .leading:
            return TextAlignment.leading
        case .center:
            return TextAlignment.center
        case .trailing:
            return TextAlignment.trailing
        default:
            return TextAlignment.leading
        }
    }
    
    private func heightForFontSize(size: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        return font.capHeight
    }
}

#Preview {
    TextPreviewView(text: "My text own", font: "Roboto Mono", color: "#000CA0", gravity: .leading, size: 14, isBold: true, isItalic: false, isUnderline: true, isUppercased: true)
}
