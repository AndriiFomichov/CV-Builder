//
//  EditorResumeView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorResumeView: View {
    
    @Binding var wrapper: CVEntityWrapper?
    @Binding var isLoading: Bool
    let pagesUpdateHandler: () -> Void
    let doubleTapHandler: (_ page: Int, _ isCv: Bool) -> Void
    
    var body: some View {
        VStack {
            if let wrapper {
                CVMakerPreviewView(cv: wrapper, isLoading: $isLoading, pageUpdateHandler: {
                    pagesUpdateHandler()
                }, doubleTapHandler: doubleTapHandler)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EditorResumeView(wrapper: .constant(CVEntityWrapper.getDefault()), isLoading: .constant(false), pagesUpdateHandler: {}, doubleTapHandler: { i, b in })
}