//
//  ProfileView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ProfileViewModel()
    
    @State var currentPreview: UIImage?
    @State var backgroundRemoveAvailable = false
    
//    var size: CGSize
//    var safeArea: EdgeInsets
    @State private var offsetY: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                
                ZStack (alignment: .bottom) {
                    Color.background.ignoresSafeArea()
                    
                    ScrollViewReader { proxy in
                        
                        ScrollView(showsIndicators: false) {
                            
                            VStack {
                                createHeaderView(size: geo.size, safeArea: geo.safeAreaInsets).zIndex(1)
                                createMainContent()
                            }
                            .id("mainScrollView")
                            .background {
                                ScrollDetector { offset in
                                    offsetY = -offset
                                } onDraggingEnd: { offset, velocity in
//                                    if needToScroll(size: geo.size, safeArea: geo.safeAreaInsets, offset: offset, velocity: velocity) {
//                                        withAnimation(.default) {
//                                            proxy.scrollTo("mainScrollView", anchor: .top)
//                                        }
//                                    }
                                }
                            }
                        }
                    }
                    
                    LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 90).offset(y: geo.safeAreaInsets.bottom)
                    
                }.navigationTitle(NSLocalizedString("profile", comment: "")).navigationBarTitleDisplayMode(.inline).toolbar {
                    
                    if viewModel.guideSheetAvailable {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                viewModel.showGuide()
                            }) {
                                Image(systemName: "info.circle").foregroundColor(Color.accent)
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                        }
                    }
                    
                }.onAppear() {
                    viewModel.updateData()
                    currentPreview = viewModel.photo
                    backgroundRemoveAvailable = viewModel.backRemoveAvailable
                }.navigationDestination(isPresented: $viewModel.nextStepPresented) {
                    switch viewModel.nextStepView {
                    case 0:
                        GeneralCategoryView(profile: viewModel.profile)
                    case 1:
                        EducationCategoryView(profile: viewModel.profile)
                    case 2:
                        WorkCategoryView(profile: viewModel.profile)
                    case 3:
                        SkillsCategoryView(profile: viewModel.profile)
                    case 4:
                        LanguagesCategoryView(profile: viewModel.profile)
                    case 5:
                        InterestsCategoryView(profile: viewModel.profile)
                    case 6:
                        ContactCategoryView(profile: viewModel.profile)
                    case 7:
                        SocialCategoryView(profile: viewModel.profile)
                    case 8:
                        CertificatesCategoryView(profile: viewModel.profile)
                    case 9:
                        ReferencesCategoryView(profile: viewModel.profile)
                    default:
                        GeneralCategoryView(profile: viewModel.profile)
                    }
                }.onChange(of: viewModel.nextStepPresented) {
                    if !viewModel.nextStepPresented {
                        viewModel.handleCategoryFinished()
                    }
                }.onChange(of: viewModel.dismissed) {
                    dismiss()
                }.onChange(of: viewModel.photo) {
                    withAnimation {
                        currentPreview = viewModel.photo
                    }
                }.onChange(of: viewModel.backRemoveAvailable) {
                    withAnimation {
                        backgroundRemoveAvailable = viewModel.backRemoveAvailable
                    }
                }.ignoresSafeArea(.all, edges: .top).toolbarBackground(.hidden, for: .navigationBar)
                
            }.tint(.accent).interactiveDismissDisabled(true)
        }
    }
    
    private func needToScroll(size: CGSize, safeArea: EdgeInsets, offset: CGFloat, velocity: CGFloat) -> Bool {
        let headerHeight = (size.height * 0.25) + safeArea.top
        let minimumHeaderHeigth = 64 + safeArea.top
        let targetEnd = offset + (velocity * 45)
        return targetEnd < (headerHeight - minimumHeaderHeigth) && targetEnd > 0
    }
    
    @ViewBuilder
    private func createHeaderView (size: CGSize, safeArea: EdgeInsets) -> some View {
        let headerHeight = 300 + safeArea.top
        let minimumHeaderHeigth = 120 + safeArea.top
        
        let contentHeight = max((headerHeight + offsetY), minimumHeaderHeigth)
        
//        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeigth), 1), 0)
    
        GeometryReader { _ in
            ZStack (alignment: .bottom) {
                
                VStack (spacing: 0) {
                    UnevenRoundedRectangle(topLeadingRadius: 20.0, topTrailingRadius: 20.0).fill(Color.background).frame(height: 15.0)
                    LinearGradient(gradient: Gradient(colors: [.clear, .background]), startPoint: .bottom, endPoint: .top).frame(height: 10)
                }
                
                Button (action: {
                    viewModel.showPhotoSelection()
                }) {
                    ZStack {
                        
                        Color.windowTwo
                        
                        if let currentPreview {
                            Image(uiImage: currentPreview).centerCropped()
                        }
                        
                        if currentPreview == nil {
                            ZStack {
                                
                                Image(systemName: "plus").font(.headline).foregroundStyle(.white)
                                
                            }.frame(width: 48, height: 48).background() {
                                Circle().fill(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
                            }
                        }
                        
                    }.aspectRatio(1.0, contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: 16.0)).padding(8).background {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
                    }.padding(.horizontal)
                    
                }.padding(.top, safeArea.top + 48).padding(.bottom, 10)
                
            }.background() {
                
                ColorBackgroundView(size: contentHeight * 0.8).padding(.bottom, 10)
                
            }.frame(height: contentHeight, alignment: .bottom)
            
        }.frame(height: headerHeight, alignment: .bottom).offset(y: -offsetY)
    }
    
    @ViewBuilder
    func createMainContent() -> some View {
        VStack {
            
            ZStack (alignment: .bottom) {
                
                LazyVStack {
                    
                    HStack {
                        ActionButtonView(icon: currentPreview != nil ? "photo.badge.checkmark" : "photo.badge.plus", text: currentPreview != nil ? NSLocalizedString("change_photo", comment: "") : NSLocalizedString("select_from_gallery", comment: ""), clickHandler: {
                            
                            viewModel.showPhotoSelection()
                            
                        }, addArrow: !backgroundRemoveAvailable)
                        
                        if backgroundRemoveAvailable {
                            ActionButtonView(icon: "wand.and.sparkles", text: NSLocalizedString("remove_background", comment: ""), clickHandler: {
                                
                                viewModel.showBackremover()
                                
                            }, addArrow: !backgroundRemoveAvailable)
                        }
                        
                    }.padding(.bottom)
                    
                    Text(NSLocalizedString("essential_data", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    VStack {
                        LazyVGrid(columns: [ GridItem(.adaptive(minimum: 160)) ]) {
                            ForEach(viewModel.essentialList.indices, id: \.self) { index in
                                ProfileItemView(item: $viewModel.essentialList[index], clickHandler: {
                                    viewModel.showCategory(index: index)
                                })
                            }
                        }
                    }.padding(.bottom)
                    
                    Text(NSLocalizedString("additional_data", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    VStack {
                        LazyVGrid(columns: [ GridItem(.adaptive(minimum: 160)) ]) {
                            ForEach(viewModel.additionalList.indices, id: \.self) { index in
                                ProfileItemView(item: $viewModel.additionalList[index], clickHandler: {
                                    viewModel.showCategory(index: index + 4)
                                })
                            }
                        }
                    }.padding(.bottom)
                    
                }.padding(.horizontal)
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
            Rectangle().fill(Color.background)
        }.sheet(isPresented: $viewModel.imageSelectionSheetShown) {
            PhotoSelectionView(initialId: viewModel.photoId, selectionHandler: { id in
                viewModel.handlePhotoSelection(id: id)
            }).presentationDetents([.large])
        }.sheet(isPresented: $viewModel.backgroundRemoveSheetShown) {
            BackgroundRemoverView(imageId: viewModel.photoId, selectionHandler: { id in
                viewModel.handlePhotoSelection(id: id)
            }).presentationDetents([.large])
        }.sheet(isPresented: $viewModel.guideSheetShown) {
            GuideView(guideId: 4).presentationDetents([.large])
        }
    }
}

#Preview {
    ProfileView()
}
