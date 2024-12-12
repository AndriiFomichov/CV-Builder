//
//  ArrayExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import Foundation

extension Array where Element == Character {
  func index(of character: Character, greaterThan index: Int) -> Int? {
    for i in index..<self.count where self[i] == character {
      return i
    }
    return nil
  }
}
