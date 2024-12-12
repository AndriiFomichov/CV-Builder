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
            
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                ZStack {
                    Color.backgroundDark.ignoresSafeArea()
                    
                    Image("large_line_illustration").renderingMode(.template).centerCropped().foregroundStyle(.backgroundDarker)
                    
                    VStack {
                        
                        ProgressAnimationView(isLoading: $isLoading, initialIcon: "square.and.arrow.up.fill").frame(width: 96, height: 96).padding(.bottom)
                        
                        Text(viewModel.header).font(.title).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
                        
                        Text(NSLocalizedString("couple_minutes_save_hours", comment: "")).foregroundStyle(Color.text).multilineTextAlignment(.center)
                        
                    }.padding().padding(.bottom, 24)
                }
                
                VStack {
                    
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
                    }
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("finish", comment: ""), clickHandler: {
                        viewModel.nextStep()
                    }).padding(.vertical)
                    
                }.background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24).alert(NSLocalizedString("default_error", comment: ""), isPresented: $viewModel.errorUnknownDialogShown) {
                    Button(NSLocalizedString("c_continue", comment: "")) {}
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
