//
//  TextExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

extension Text {
    
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {

            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self

            )
        }
    }
}
