//
//  TransitionExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}
