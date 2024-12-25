//
//  ButtonExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 20.12.2024.
//

import SwiftUI

struct ScalingButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
    }
}
