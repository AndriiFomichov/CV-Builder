//
//  StringExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.11.2024.
//

import Foundation
import SwiftUI

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

extension NSMutableAttributedString {
    func setCharacterColor(at location: Int, color: Color) {
    let range = NSRange(location: location, length: 1)
      self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
  }
}

extension String {
    func sizeUsingFont(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    func widthUsingFont(id: Int, size: Int) -> CGFloat {
        let fontName = PreloadedDatabase.getFontId(id: id).name
        if let font = UIFont(name: NSLocalizedString(fontName, comment: ""), size: CGFloat(size)) {
            let fontAttributes = [NSAttributedString.Key.font: font]
            return self.size(withAttributes: fontAttributes).width
        }
        return 0.0
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
