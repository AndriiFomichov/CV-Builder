//
//  PhotoSelectionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI
import PhotosUI

struct PhotoSelectionView: View {
    
    let initialId: Int
    let selectionHandler: (_ id: Int) -> Void
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PhotoSelectionViewModel()
    
    @State var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("photo_selection_header", comment: "")), description: .constant(""), isCollapsed: .constant(false), icon: "photo", iconPlusAdded: true, maxHeight: 170)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            LazyVStack {
                                
                                Text(NSLocalizedString("photo_selection_description", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                if viewModel.tipsList.count > 0 {
                                    VStack {
                                        ForEach(viewModel.tipsList.indices, id: \.self) { index in
                                            PhotoTipView(tip: viewModel.tipsList[index])
                                        }
                                    }.padding(.bottom)
                                }
                                
                                Text(NSLocalizedString("common_mistakes", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                if viewModel.mistakesList.count > 0 {
                                    ForEach(viewModel.mistakesList.indices, id: \.self) { index in
                                        PhotoTipView(tip: viewModel.mistakesList[index])
                                    }
                                }
                                
                            }.padding()
                            
                        }.alert(NSLocalizedString("default_error", comment: ""), isPresented: $viewModel.errorDialogShown) {
                            Button(NSLocalizedString("continue", comment: "")) {}
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                    }.padding(.top, -24)
                    
                    PhotosPicker(selection: $viewModel.selectedPhotos, maxSelectionCount: 1, matching: .images) {

                        HStack {
                            Text(NSLocalizedString("open_gallery", comment: "")).font(.headline).bold().foregroundStyle(Color.white)

                            if isLoading {
                                ProgressView().tint(Color.white).padding(.leading, 4)
                            }
                            
                        }.frame(maxWidth: .infinity).padding().background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(LinearGradient(colors: !isLoading ? [ Color.accentLight, Color.accent ] : [Color.accentLightest], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                        
                    }.onChange(of: viewModel.selectedPhotos) { _, _ in
                        viewModel.handleImageSelection()
                    }.padding()
                }
                
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(initial: initialId)
            }.onChange(of: viewModel.isLoading) {
                withAnimation {
                    self.isLoading = viewModel.isLoading
                }
            }.onChange(of: viewModel.dismissed) {
                selectionHandler(viewModel.selectedImage)
                dismiss()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    PhotoSelectionView(initialId: -1, selectionHandler: { id in })
}
