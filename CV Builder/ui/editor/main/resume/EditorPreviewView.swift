//
//  EditorPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 04.12.2024.
//

import SwiftUI
import SwiftUIPager

struct EditorPreviewView: View {
    
    @Binding var wrapper: CVEntityWrapper?
    @Binding var isLoading: Bool
    @Binding var isCoverLetterGenerating: Bool
    @Binding var pageModel: Int
    let pageChangeHandler: () -> Void
    let pagesUpdateHandler: () -> Void
    let generateClickHandler: () -> Void
    let textChangeHandler: (_ text: String) -> Void
    let doubleTapHandler: (_ page: Int, _ isCv: Bool) -> Void
    
    @StateObject var page: Page = .first()
    
    var body: some View {
        GeometryReader { geo in
            
            Pager(page: page, data: Array(0..<2), id: \.self, content: { index in
                if index == 0 {
                    EditorResumeView(wrapper: $wrapper, isLoading: $isLoading, pagesUpdateHandler: pagesUpdateHandler, doubleTapHandler: doubleTapHandler).clipped()
                } else {
                    EditorCoverView(wrapper: $wrapper, isLoading: $isLoading, isGenerating: $isCoverLetterGenerating, generateClickHandler: generateClickHandler, textChangeHandler: textChangeHandler, doubleTapHandler: doubleTapHandler).clipped()
                }
            }).preferredItemSize(CGSize(width: geo.size.width * 0.8, height: geo.size.height)).itemSpacing(18).interactive(opacity: 0.5)
            
        }.onChange(of: pageModel) {
            self.endEditing()
            withAnimation {
                page.update(.new(index: pageModel))
                pageChangeHandler()
            }
        }.onChange(of: page.index) {
            pageModel = page.index
        }
    }
}

#Preview {
    EditorPreviewView(wrapper: .constant(CVEntityWrapper.getDefault()), isLoading: .constant(false), isCoverLetterGenerating: .constant(false), pageModel: .constant(0), pageChangeHandler: {}, pagesUpdateHandler: {}, generateClickHandler: {}, textChangeHandler: { t in }, doubleTapHandler: { i, b in })
}
