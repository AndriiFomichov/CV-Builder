//
//  PhotoFieldsInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct PhotoFieldsInputView: View {
    
    @Binding var imageId: Int
    @Binding var preview: UIImage?
    @Binding var previewBackgroundRemoveAvailable: Bool
    var photoSelectionHandler: (_ id: Int) -> Void
    
    @State var currentPreview: UIImage?
    @State var backgroundRemoveAvailable = false
    
    @State var imageSelectionSheetShown = false
    @State var backgroundRemoveSheetShown = false
    
    var body: some View {
        VStack {
            
            Text(NSLocalizedString("profile_photo", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
            
            Button (action: {
                imageSelectionSheetShown = true
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
                            Circle().fill(LinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                    }
                    
                }.clipShape(RoundedRectangle(cornerRadius: 16.0)).padding(8).background {
                    RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
                }.padding(.horizontal).padding(.bottom, 8)
            }
            
            HStack {
                ActionButtonView(icon: currentPreview != nil ? "photo.badge.checkmark" : "photo.badge.plus", text: currentPreview != nil ? NSLocalizedString("change_photo", comment: "") : NSLocalizedString("select_from_gallery", comment: ""), clickHandler: {
                    
                    imageSelectionSheetShown = true
                    
                }, addArrow: !backgroundRemoveAvailable)
                
                if backgroundRemoveAvailable {
                    ActionButtonView(icon: "wand.and.sparkles", text: NSLocalizedString("remove_background", comment: ""), clickHandler: {
                        
                        backgroundRemoveSheetShown = true
                        
                    }, addArrow: !backgroundRemoveAvailable)
                }
            }.onAppear() {
                currentPreview = preview
                backgroundRemoveAvailable = previewBackgroundRemoveAvailable
            }.onChange(of: preview) {
                withAnimation {
                    currentPreview = preview
                }
            }.onChange(of: previewBackgroundRemoveAvailable) {
                withAnimation {
                    backgroundRemoveAvailable = previewBackgroundRemoveAvailable
                }
            }.sheet(isPresented: $imageSelectionSheetShown) {
                PhotoSelectionView(initialId: imageId, selectionHandler: photoSelectionHandler).presentationDetents([.large])
            }.sheet(isPresented: $backgroundRemoveSheetShown) {
                BackgroundRemoverView(imageId: imageId, selectionHandler: photoSelectionHandler).presentationDetents([.large])
            }
            
        }.padding()
    }
}

#Preview {
    PhotoFieldsInputView(imageId: .constant(-1), preview: .constant(nil), previewBackgroundRemoveAvailable: .constant(false), photoSelectionHandler: { id in })
}
