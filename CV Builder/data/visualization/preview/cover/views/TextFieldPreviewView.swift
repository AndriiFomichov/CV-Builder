//
//  TextFieldPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 03.12.2024.
//

import SwiftUI

struct TextFieldPreviewView: View {
    
    var initialText: String
    var font: Int
    var color: String
    var gravity: Alignment
    var size: Int
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool
    var isUppercased: Bool
    var isDisabled: Bool = false
    
    let textChangeHandler: (_ text: String) -> Void
    
    @State var text = ""
    
    var body: some View {
        VStack {
            
            TextField("", text: $text, prompt: Text("enter_text").foregroundStyle(Color(hex: color).opacity(0.7)), axis: .vertical).font(SwiftUI.Font.custom(NSLocalizedString(getFontByStyle(font), comment: ""), size: CGFloat(size))).frame(maxWidth: .infinity, alignment: .topLeading).multilineTextAlignment(getTextAlignment(gravity: gravity)).foregroundStyle(Color(hex: color)).bold(isBold).italic(isItalic).underline(isUnderline).lineLimit(1...1000).disabled(isDisabled)
            
        }.onAppear() {
            text = initialText
        }.onChange(of: initialText) {
            text = initialText
        }.onChange(of: text) {
            if text != initialText {
                textChangeHandler(text)
            }
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
    
    private func getFontByStyle (_ id: Int) -> String {
        return PreloadedDatabase.getFontId(id: id).name
    }
}

#Preview {
    TextFieldPreviewView(initialText: "My text own", font: 0, color: "#000CA0", gravity: .leading, size: 14, isBold: true, isItalic: false, isUnderline: true, isUppercased: true, textChangeHandler: { t in })
}
