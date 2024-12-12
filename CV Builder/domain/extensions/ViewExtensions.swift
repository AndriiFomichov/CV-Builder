//
//  ViewExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.11.2024.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear.preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }).onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func borderLoadingAnimation(isAnimating: Binding<Bool>, cornersRadius: CGFloat = 16.0) -> some View {
        modifier(BorderLoadingAnimation(isAnimating: isAnimating, cornersRadius: cornersRadius))
    }
}
