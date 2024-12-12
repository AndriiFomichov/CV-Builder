//
//  FontSelectionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 03.12.2024.
//

import SwiftUI

struct FontSelectionView: View {
    
    let initialFont: Int
    let finishHandler: (_ font: Int) -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = FontSelectionViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {

                    if viewModel.isLoading {
                        VStack {
                            ProgressView().tint(Color.accent)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else if viewModel.fontsList.count > 0 {
                        
                        ScrollView (showsIndicators: false) {
                            
                            LazyVStack {
                                
                                Text(NSLocalizedString("font_a_category", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal).padding(.top)
                                
                                ScrollView (.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.fontsList[0].indices, id: \.self) { index in
                                            FontView(font: $viewModel.fontsList[0][index], category: 0, index: index, clickHandler: {
                                                viewModel.handleFontClick(category: 0, index: index)
                                            })
                                        }
                                    }.frame(height: 132).padding(.horizontal).padding(.bottom)
                                }
                                
                                Text(NSLocalizedString("font_b_category", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                                
                                ScrollView (.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.fontsList[1].indices, id: \.self) { index in
                                            FontView(font: $viewModel.fontsList[1][index], category: 1, index: index, clickHandler: {
                                                viewModel.handleFontClick(category: 1, index: index)
                                            })
                                        }
                                    }.frame(height: 132).padding(.horizontal).padding(.bottom)
                                }
                                
                                Text(NSLocalizedString("font_c_category", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                                
                                ScrollView (.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.fontsList[2].indices, id: \.self) { index in
                                            FontView(font: $viewModel.fontsList[2][index], category: 2, index: index, clickHandler: {
                                                viewModel.handleFontClick(category: 2, index: index)
                                            })
                                        }
                                    }.frame(height: 132).padding(.horizontal).padding(.bottom)
                                }
                                
                                Text(NSLocalizedString("font_d_category", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                                
                                ScrollView (.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.fontsList[3].indices, id: \.self) { index in
                                            FontView(font: $viewModel.fontsList[3][index], category: 3, index: index, clickHandler: {
                                                viewModel.handleFontClick(category: 3, index: index)
                                            })
                                        }
                                    }.frame(height: 132).padding(.horizontal).padding(.bottom)
                                }
                                
                                Text(NSLocalizedString("font_e_category", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                                
                                ScrollView (.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.fontsList[4].indices, id: \.self) { index in
                                            FontView(font: $viewModel.fontsList[4][index], category: 4, index: index, clickHandler: {
                                                viewModel.handleFontClick(category: 4, index: index)
                                            })
                                        }
                                    }.frame(height: 132).padding(.horizontal).padding(.bottom)
                                }
                                
                            }
                        }
                    }
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("select_font", comment: ""), clickHandler: {
                        finish()
                    }).padding(.vertical)
                }
                
            }.navigationTitle(NSLocalizedString("select_font", comment: "")).navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        finish()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(initialFont: initialFont)
            }
            
        }.tint(Color.accent).interactiveDismissDisabled(true)
    }
    
    func finish () {
        finishHandler(viewModel.selectedFont)
        dismiss()
    }
}

#Preview {
    FontSelectionView(initialFont: -1, finishHandler: { i in })
}
