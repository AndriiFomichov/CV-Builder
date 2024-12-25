//
//  EditorZoomablePreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 04.12.2024.
//

import SwiftUI

struct EditorZoomablePreviewView: View {
    
    var page: Int
    let isCv: Bool
    @Binding var wrapper: CVEntityWrapper?
    
    @State var scale: CGFloat = 1.0
    @Environment(\.dismiss) var dismiss
    
    @State var pageState = 0
    @State var btnPagesAvailable = false
    @State var btnPreviousEnabled = false
    @State var btnNextEnabled = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    HStack {}.frame(height: 70).frame(maxWidth: .infinity).background() {
                        ColorBackgroundView().ignoresSafeArea()
                    }
                    
                    VStack (spacing: 8) {
                        
                        HStack (spacing: 4) {
                            Image(systemName: "hand.pinch.fill").font(.subheadline).foregroundStyle(.text)
                            
                            Text(NSLocalizedString("pinch_to_zoom", comment: "")).font(.subheadline).foregroundStyle(.text).multilineTextAlignment(.center)
                            
                        }.padding(.top).padding(.horizontal)
                        
                        ZStack {
                            Color.backgroundDark
                            
                            ZoomableScrollView(scale: $scale) {
                                ZStack {
                                    
                                    if let wrapper {
                                        if isCv {
                                            CVMakerPreviewPageView(cv: wrapper, page: pageState, isLoading: .constant(false), blockOneHeight: .constant(0.0), blockTwoHeight: .constant(0.0), blockThreeHeight: .constant(0.0), blockFourHeight: .constant(0.0), blockFiveHeight: .constant(0.0), blockSixHeight: .constant(0.0), blockSevenHeight: .constant(0.0), blockEightHeight: .constant(0.0), blockNineHeight: .constant(0.0), blockTenHeight: .constant(0.0), blockElevenHeight: .constant(0.0), blockAdditionalOneHeight: .constant(0.0), blockAdditionalTwoHeight: .constant(0.0), blockAdditionalThreeHeight: .constant(0.0), blockAdditionalFourHeight: .constant(0.0), blockAdditionalFiveHeight: .constant(0.0), blockAdditionalSixHeight: .constant(0.0), blockAdditionalSevenHeight: .constant(0.0), blockAdditionalEightHeight: .constant(0.0), blockAdditionalNineHeight: .constant(0.0), blockAdditionalTenHeight: .constant(0.0), blockAdditionalElevenHeight: .constant(0.0), mainColumnHeight: .constant(0.0), additionalColumnHeight: .constant(0.0), mainColumnNextPagesHeight: .constant(0.0), additionalColumnNextPagesHeight: .constant(0.0), doubleTapHandler: { i, b in })
                                        } else {
                                            CoverMakerPreviewView(cv: wrapper, isLoading: .constant(false), textChangeHandler: { text in }, isDisabled: true)
                                        }
                                    }

                                }.padding()
                            }
                            
                        }.clipShape(RoundedRectangle(cornerRadius: 16.0)).padding(.horizontal)
                        
                        if btnPagesAvailable {
                            HStack (spacing: 8) {
                                Button (action: {
                                    if btnPreviousEnabled {
                                        withAnimation {
                                            updatePage(page: pageState - 1)
                                        }
                                    }
                                }) {
                                    HStack (spacing: 0) {
                                        
                                        ZStack {
                                            
                                            Image(systemName: "chevron.left").font(.headline).foregroundStyle(btnPreviousEnabled ? .text : .textAdditional)
                                            
                                        }.clipShape(RoundedRectangle(cornerRadius: 32.0)).frame(width: 42, height: 42).background() {
                                            RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                                        }.padding(8)
                                        
                                        Text(NSLocalizedString("previous_page", comment: "")).font(.subheadline).foregroundStyle(btnPreviousEnabled ? .text : .textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4).lineLimit(2)
                                        
                                    }.frame(maxWidth: .infinity).background() {
                                        RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
                                    }
                                }
                                
                                Button (action: {
                                    if btnNextEnabled {
                                        withAnimation {
                                            updatePage(page: pageState + 1)
                                        }
                                    }
                                }) {
                                    HStack (spacing: 0) {
                                        
                                        Text(NSLocalizedString("next_page", comment: "")).font(.subheadline).foregroundStyle(btnNextEnabled ? .text : .textAdditional).frame(maxWidth: .infinity, alignment: .trailing).multilineTextAlignment(.trailing).padding(.leading, 4).padding(.vertical, 4).lineLimit(2)
                                        
                                        ZStack {
                                            
                                            Image(systemName: "chevron.right").font(.headline).foregroundStyle(btnNextEnabled ? .text : .textAdditional)
                                            
                                        }.clipShape(RoundedRectangle(cornerRadius: 32.0)).frame(width: 42, height: 42).background() {
                                            RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                                        }.padding(8)
                                        
                                    }.frame(maxWidth: .infinity).background() {
                                        RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
                                    }
                                }
                                
                            }.padding(.horizontal)
                        }
                        
                    }.background() {
                        
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                        
                    }.padding(.top, -48)
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("end_preview", comment: ""), clickHandler: {
                        dismiss()
                    }).padding(.vertical)
                }
                
            }.navigationTitle(NSLocalizedString("preview", comment: "")).navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                withAnimation {
                    updatePage(page: page)
                }
            }
        }.tint(Color.accent)
    }
    
    private func updatePage (page: Int) {
        self.pageState = page
        
        if let wrapper {
            let pages = CVVisualizationBuilder.getWrapperPagesCount(wrapper: wrapper)
            btnPagesAvailable = pages > 1
            btnPreviousEnabled = page > 0
            btnNextEnabled = page < pages - 1
        }
    }
}

#Preview {
    EditorZoomablePreviewView(page: 0, isCv: true, wrapper: .constant(CVEntityWrapper.getDefault()))
}
