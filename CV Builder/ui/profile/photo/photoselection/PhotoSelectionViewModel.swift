//
//  PhotoSelectionViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

class PhotoSelectionViewModel: ObservableObject {
    
    var initialImageId = -1
    var selectedImage = -1
    
    let profileManager = ProfileManager()
    
    @Published var tipsList: [PhotoTip] = []
    @Published var mistakesList: [PhotoTip] = []
    
    @Published var selectedPhotos = [PhotosPickerItem]()
    
    @Published var isLoading = false
    
    @Published var errorDialogShown = false
    @Published var dismissed = false
    
    func updateData (initial: Int) {
        self.initialImageId = initial
        updateTips()
        updateMistakes()
    }
    
    private func updateTips () {
        tipsList = PreloadedDatabase.getPhotoTips()
    }
    
    private func updateMistakes () {
        mistakesList = PreloadedDatabase.getPhotoMistakes()
    }
    
    func handleImageSelection () {
        Task {
            await performImageSaving()
        }
    }
    
    @MainActor
    private func performImageSaving () async {
        isLoading = true
        
        if !selectedPhotos.isEmpty && selectedPhotos.count >= 1 {
            let photo = selectedPhotos[0]

            if let imageData = try? await photo.loadTransferable(type: Data.self) {
                
                selectedImage = await profileManager.savePhoto(image: imageData)
                
                if selectedImage != -1 {
                    profileManager.deleteImage(id: initialImageId)
                    isLoading = false
                    dismissed = true
                } else {
                    isLoading = false
                    errorDialogShown = true
                }
                
            } else {
                errorDialogShown = true
                isLoading = false
            }
        } else {
            errorDialogShown = true
            isLoading = false
        }
    }
}
