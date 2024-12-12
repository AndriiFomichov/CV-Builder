//
//  AnimationExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 02.12.2024.
//

import SwiftUI

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
