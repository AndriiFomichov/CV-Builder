//
//  ShareExportView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct ShareExportView: View {
    
    @EnvironmentObject var parentViewModel: ShareViewModel
    @StateObject var viewModel = ShareExportViewModel()
    
    @State var isLoading = false
    @State var filesListVisible = false
    @State private var scrollViewContentSize: CGSize = .zero
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        ZStack {
            
            ColoredBackgroundLargeView(animating: true).ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                ZStack {
                    Color.clear
                    
                    VStack {
                        
                        ProgressAnimationView(isLoading: $isLoading, initialIcon: "square.and.arrow.up.fill", lineWidth: 8).frame(width: 146, height: 146).padding(.bottom)
                        
                        
                        
                    }.padding().padding(.bottom, 24)
                }
                
                ZStack (alignment: .top) {
                    
                    VStack (spacing: 8) {
                        if filesListVisible {
                            
                            if viewModel.exportedFiles.count < 4 {
                                VStack {
                                    
                                    ForEach(viewModel.exportedFiles.indices, id: \.self) { index in
                                        ExportedFileView(file: viewModel.exportedFiles[index])
                                    }
                                    
                                }.padding([.top, .horizontal])
                            } else {
                                ScrollView (showsIndicators: false) {
                                    VStack {
                                        
                                        ForEach(viewModel.exportedFiles.indices, id: \.self) { index in
                                            ExportedFileView(file: viewModel.exportedFiles[index])
                                        }
                                        
                                    }.padding([.top, .horizontal])
                                }.frame(height: 270)
                            }
                            
                        } else {
                            
                            Text(viewModel.header).font(.title).bold().foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.horizontal)
                            
                            Text(NSLocalizedString("couple_minutes_save_hours", comment: "")).foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.horizontal)
                        }
                        
                        MainButtonView(isSelected: $viewModel.btnMainSelected, text: NSLocalizedString("finish", comment: ""), clickHandler: {
                            viewModel.nextStep()
                        }).padding(.top)
                        
                    }.padding(.vertical).padding(.top).background() {
                        UnevenRoundedRectangle(topLeadingRadius: 24.0, topTrailingRadius: 24.0).fill(Color.windowColored).ignoresSafeArea()
                    }.padding(.horizontal, 8)
                    
                    ZStack {
                        
                        Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 28, height: 28)
                        
                    }.frame(width: 54, height: 54).background() {
                        RoundedRectangle(cornerRadius: 32.0).fill(.window)
                    }.offset(y: -32)
                    
                }.alert(NSLocalizedString("default_error", comment: ""), isPresented: $viewModel.errorUnknownDialogShown) {
                    Button(NSLocalizedString("continue", comment: "")) {}
                }
                
            }.onChange(of: viewModel.reviewAsked) {
                requestReview()
            }.onChange(of: viewModel.isLoading) {
                withAnimation {
                    self.isLoading = viewModel.isLoading
                }
            }.onChange(of: viewModel.btnMainSelected) {
                withAnimation {
                    self.filesListVisible = viewModel.btnMainSelected
                }
            }
            
        }.navigationBarTitleDisplayMode(.inline).onAppear() {
            viewModel.updateData(parentViewModel: parentViewModel)
        }
    }
}

#Preview {
    ShareExportView().environmentObject(ShareViewModel())
}
