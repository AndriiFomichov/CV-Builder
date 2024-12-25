//
//  SocialCategoryView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct SocialCategoryView: View {
    
    let profile: ProfileEntity?
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = SocialCategoryViewModel()
    
    @State private var actionsSheetShown = false
    
    @State var actionItemIndex = -1
    @State private var draggedItem: SocialMediaItem?
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                TopBarView(header: .constant(NSLocalizedString("social_media_input_header", comment: "")), description: .constant(NSLocalizedString("social_media_input_description", comment: "")), isCollapsed: .constant(false))

                VStack {
                    
                    if viewModel.mediaList.count == 0 {
                        
                        EmptyInputListView(icon: "link.circle.fill", header: NSLocalizedString("empty_social_media_header", comment: ""), description: NSLocalizedString("empty_social_media_description", comment: ""), buttonOneName: NSLocalizedString("add_social_media", comment: ""), buttonOneIcon: "plus", buttonOneHandler: {
                            withAnimation {
                                viewModel.showMediaAdding()
                            }
                        }).padding()
                        
                    } else {
                        
                        HStack {
                            
                            ActionButtonView(icon: "plus", text: NSLocalizedString("add_social_media", comment: ""), clickHandler: {
                                withAnimation {
                                    viewModel.showMediaAdding()
                                }
                            }, addArrow: true)
                            
                        }.padding([.leading, .top, .trailing])
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                ForEach(viewModel.mediaList.indices, id: \.self) { index in
                                    SocialMediaItemView(item: $viewModel.mediaList[index], actionsHandler: {
                                        actionsSheetShown = true
                                        actionItemIndex = index
                                    }, qrHandler: {
                                        viewModel.showQRCode(index: index)
                                    }).onDrag {
                                        self.draggedItem = viewModel.mediaList[index]
                                        return NSItemProvider()
                                    }.onDrop(of: [.text], delegate: SocialMediaDropDelegate(destinationItem: viewModel.mediaList[index], list: $viewModel.mediaList, draggedItem: $draggedItem, dropEndHandler: {
                                        viewModel.handleItemsMoved()
                                    }))
                                }
                                
                            }.padding()
                            
                        }.confirmationDialog(NSLocalizedString("edit", comment: ""), isPresented: $actionsSheetShown) {
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive) {
                                withAnimation {
                                    viewModel.deleteMedia(index: actionItemIndex)
                                }
                            }
                        }
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                }.padding(.top, -24)
                
                MainButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: {
                    presentationMode.wrappedValue.dismiss()
                }).padding(.vertical)
                
            }.sheet(isPresented: $viewModel.mediaAddingSheetShown, onDismiss: {
                withAnimation {
                    viewModel.handleMediaAddingFinished()
                }
            }) {
                SocialAddingView(profile: viewModel.profile).presentationDetents([.large])
            }.sheet(isPresented: $viewModel.qrCodeSheetShown) {
                if let media = viewModel.qrCodeEditedMedia {
                    QRCodeGeneratorView(link: media.link, initialId: media.qrCodeId, generationHandler: { id in
                        viewModel.handleQrCodeGenerator(id: id)
                    }).presentationDetents([.medium])
                }
            }
            
        }.navigationTitle("").navigationBarTitleDisplayMode(.inline).toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.showMediaAdding()
                    }
                }) {
                    Image(systemName: "plus").foregroundColor(Color.accent)
                }
            }
            
        }.onAppear() {
            viewModel.updateData(profile: profile)
        }
    }
}

#Preview {
    SocialCategoryView(profile: nil)
}
