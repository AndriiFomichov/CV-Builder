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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    ZStack (alignment: .bottom) {
                        
                        VStack {
                            Spacer()
                            UnevenRoundedRectangle(topLeadingRadius: 20.0, topTrailingRadius: 20.0).fill(Color.background).frame(height: 20.0)
                        }
                        
                        Button (action: {
                            viewModel.showPhotoSelection()
                        }) {
                            ZStack {
                                
                                if let currentPreview {
                                    Image(uiImage: currentPreview).resizable().scaledToFit().background {
                                        Color.windowTwo
                                    }
                                } else {
                                    Color.windowTwo.aspectRatio(0.75, contentMode: .fit)
                                }
                                
                                if currentPreview == nil {
                                    ZStack {
                                        
                                        Image(systemName: "plus").font(.headline).foregroundStyle(.white)
                                        
                                    }.frame(width: 48, height: 48).background() {
                                        Circle().fill(.accent)
                                    }
                                }
                                
                            }.clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(8).background {
                                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                            }.padding(.horizontal)
                        }
                        
                    }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background() {
                        ZStack (alignment: .bottomTrailing) {
                            Color.backgroundDark.ignoresSafeArea()
                            
                            Image("small_line_four_illustration").renderingMode(.template).resizable().scaledToFit().foregroundStyle(.backgroundDarker)
                        }
                    }.frame(height: 200)

                    VStack {
                        
                        ZStack (alignment: .bottom) {
                            
                            ScrollView (showsIndicators: false) {
                                
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
                                        ForEach(viewModel.essentialList.indices, id: \.self) { index in
                                            ProfileItemView(item: $viewModel.essentialList[index], clickHandler: {
                                                viewModel.showCategory(index: index)
                                            }).padding(.bottom, 8)
                                        }
                                    }.padding(.bottom)
                                    
                                    Text(NSLocalizedString("additional_data", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    VStack {
                                        ForEach(viewModel.additionalList.indices, id: \.self) { index in
                                            ProfileItemView(item: $viewModel.additionalList[index], clickHandler: {
                                                viewModel.showCategory(index: index + 3)
                                            }).padding(.bottom, 8)
                                        }
                                    }.padding(.bottom, 124)
                                    
                                }.padding()
                            }
                            
                            VStack {
                                LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .bottom, endPoint: .top).frame(height: 20)
                                
                                Spacer()
                                
                                LinearGradient(gradient: Gradient(colors: [.clear, Color.background]), startPoint: .top, endPoint: .bottom).frame(height: 90)
                            }.ignoresSafeArea()
                            
                            
                            ProfileStatusView(progress: $viewModel.profileProgress, saveClickHandler: {
                                dismiss()
                            }).padding(8)
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        Rectangle().fill(Color.background)
                    }
                    
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
                    LanguagesCategoryView(profile: viewModel.profile)
                case 4:
                    SkillsCategoryView(profile: viewModel.profile)
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
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

#Preview {
    ProfileView()
}
