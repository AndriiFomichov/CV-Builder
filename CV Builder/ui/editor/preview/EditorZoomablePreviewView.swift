//
//  EditorZoomablePreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 04.12.2024.
//

import SwiftUI

struct EditorZoomablePreviewView: View {
    
    let page: Int
    let isCv: Bool
    @Binding var wrapper: CVEntityWrapper?
    
    @State var scale: CGFloat = 1.0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.background.ignoresSafeArea()
                
                ZStack {
                    Color.backgroundDark
                    
                    ZoomableScrollView(scale: $scale) {
                        ZStack {
                            
                            if let wrapper {
                                if isCv {
                                    CVMakerPreviewPageView(cv: wrapper, page: page, isLoading: .constant(false), blockOneHeight: .constant(0.0), blockTwoHeight: .constant(0.0), blockThreeHeight: .constant(0.0), blockFourHeight: .constant(0.0), blockFiveHeight: .constant(0.0), blockSixHeight: .constant(0.0), blockSevenHeight: .constant(0.0), blockEightHeight: .constant(0.0), blockNineHeight: .constant(0.0), blockTenHeight: .constant(0.0), blockElevenHeight: .constant(0.0), blockAdditionalOneHeight: .constant(0.0), blockAdditionalTwoHeight: .constant(0.0), blockAdditionalThreeHeight: .constant(0.0), blockAdditionalFourHeight: .constant(0.0), blockAdditionalFiveHeight: .constant(0.0), blockAdditionalSixHeight: .constant(0.0), blockAdditionalSevenHeight: .constant(0.0), blockAdditionalEightHeight: .constant(0.0), blockAdditionalNineHeight: .constant(0.0), blockAdditionalTenHeight: .constant(0.0), blockAdditionalElevenHeight: .constant(0.0), mainColumnHeight: .constant(0.0), additionalColumnHeight: .constant(0.0), mainColumnNextPagesHeight: .constant(0.0), additionalColumnNextPagesHeight: .constant(0.0), doubleTapHandler: { i, b in })
                                } else {
                                    CoverMakerPreviewView(cv: wrapper, isLoading: .constant(false), textChangeHandler: { text in }, isDisabled: true)
                                }
                            }
                        }.padding()
                    }
                }.clipShape(RoundedRectangle(cornerRadius: 16.0)).clipped().padding(8)
                
            }.navigationTitle("").navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }
        }.tint(Color.accent)
    }
}

#Preview {
    EditorZoomablePreviewView(page: 0, isCv: true, wrapper: .constant(CVEntityWrapper.getDefault()))
}
