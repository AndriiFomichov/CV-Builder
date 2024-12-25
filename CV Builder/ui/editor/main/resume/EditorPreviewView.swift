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
    let pagesSelectHandler: (_ page: Int) -> Void
    let generateClickHandler: () -> Void
    let textChangeHandler: (_ text: String) -> Void
    let doubleTapHandler: (_ page: Int, _ isCv: Bool) -> Void
    
    @State var selectedPage = 0
    @StateObject var page: Page = .first()
    
    var body: some View {
        ZStack (alignment: .center) {
            
            GeometryReader { geo in
                
                Pager(page: page, data: Array(0..<2), id: \.self, content: { index in
                    if index == 0 {
                        EditorResumeView(wrapper: $wrapper, isLoading: $isLoading, pagesUpdateHandler: pagesUpdateHandler, doubleTapHandler: doubleTapHandler).shadow(color: .black.opacity(0.12), radius: selectedPage == 0 ? 20 : 5).scaleEffect(selectedPage == 0 ? 1.0 : 0.98)
                    } else {
                        EditorCoverView(wrapper: $wrapper, isLoading: $isLoading, isGenerating: $isCoverLetterGenerating, generateClickHandler: generateClickHandler, textChangeHandler: textChangeHandler, doubleTapHandler: doubleTapHandler).shadow(color: .black.opacity(0.12), radius: selectedPage == 1 ? 20 : 5).scaleEffect(selectedPage == 1 ? 1.0 : 0.98)
                    }
                }).preferredItemSize(CGSize(width: geo.size.width * 0.8, height: geo.size.height)).itemSpacing(18).interactive(opacity: 0.5)
                
            }
            
            HStack {
                if selectedPage == 1 {
                    SideButtonView(text: NSLocalizedString("resume", comment: ""), icon: "text.page.fill", angle: 90, clickHandler: {
                        pagesSelectHandler(0)
                    })
                }
                Spacer()
                if selectedPage == 0 {
                    SideButtonView(text: NSLocalizedString("cover_letter", comment: ""), icon: "text.document.fill", angle: -90, clickHandler: {
                        pagesSelectHandler(1)
                    })
                }
            }
            
        }.onChange(of: pageModel) {
            self.endEditing()
            withAnimation {
                page.update(.new(index: pageModel))
                selectedPage = pageModel
                pageChangeHandler()
            }
        }.onChange(of: page.index) {
            pageModel = page.index
            withAnimation {
                selectedPage = page.index
            }
        }
    }
}

#Preview {
    EditorPreviewView(wrapper: .constant(CVEntityWrapper.getDefault()), isLoading: .constant(false), isCoverLetterGenerating: .constant(false), pageModel: .constant(0), pageChangeHandler: {}, pagesUpdateHandler: {}, pagesSelectHandler: { p in }, generateClickHandler: {}, textChangeHandler: { t in }, doubleTapHandler: { i, b in })
}
