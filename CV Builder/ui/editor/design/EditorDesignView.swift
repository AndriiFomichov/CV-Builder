//
//  EditorDesignView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorDesignView: View {
    
    @EnvironmentObject var parentViewModel: EditorViewModel
    @StateObject var viewModel = EditorDesignViewModel()
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                HStack {
                    
                    BackButtonView(clickHandler: {
                        viewModel.back()
                    }).offset(x: 8)
                    
                    Spacer()
                    
                    
                    
                }.padding()
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        
                        Text(NSLocalizedString("styles", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                
                                ForEach(viewModel.styles.indices, id: \.self) { index in
                                    StyleSmallView(style: $viewModel.styles[index], clickHandler: {
                                        viewModel.selectStyle(index: index)
                                    })
                                }
                                
                            }.frame(height: 196).padding(.horizontal)
                        }.padding(.bottom)
                        
                        Text(NSLocalizedString("main_color", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                
                                ForEach(viewModel.colors.indices, id: \.self) { index in
                                    ColorItemView(item: $viewModel.colors[index], clickHandler: {
                                        viewModel.selectColor(index: index)
                                    })
                                }
                                
                            }.frame(height: 64).padding(.horizontal)
                        }.padding(.bottom)
                        
                        Text(NSLocalizedString("fonts", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                        
                        HStack {
                            
                            FontItemView(font: $viewModel.fontHeaders, fontType: NSLocalizedString("headers", comment: ""), clickHandler: {
                                viewModel.showFontSheet(type: 0)
                            })
                            
                            FontItemView(font: $viewModel.fontText, fontType: NSLocalizedString("text", comment: ""), clickHandler: {
                                viewModel.showFontSheet(type: 1)
                            })
                            
                        }.padding(.horizontal)
                        
                        SliderButtonView(text: NSLocalizedString("headers_size", comment: ""), value: $viewModel.headersSize, sliderRange: 1...54).padding(.horizontal).onChange(of: viewModel.headersSize) {
                            viewModel.handleHeaderSizeChanged()
                        }
                       
                        SliderButtonView(text: NSLocalizedString("text_size", comment: ""), value: $viewModel.textSize, sliderRange: 1...30).padding(.horizontal).padding(.bottom).onChange(of: viewModel.textSize) {
                            viewModel.handleTextSizeChanged()
                        }
                        
                        Text(NSLocalizedString("margins", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                        
                        SliderButtonView(text: NSLocalizedString("margins_size", comment: ""), value: $viewModel.marginsSize, sliderRange: 1...30).padding(.horizontal).padding(.bottom).onChange(of: viewModel.marginsSize) {
                            viewModel.handleMarginsSizeChanged()
                        }
                        
                    }.padding(.bottom)
                }
            }.sheet(isPresented: $viewModel.fontSheetShown) {
                FontSelectionView(initialFont: viewModel.initialFontId, finishHandler: { id in
                    viewModel.handleFontSelection(id: id)
                }).presentationDetents([.large])
            }
            
            LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 36)
            
        }.onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }
    }
}

#Preview {
    EditorDesignView().environmentObject(EditorViewModel())
}
