//
//  SocialCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation
import UIKit

class SocialCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var mediaList: [SocialMediaItem] = []
    @Published var mediaAddingSheetShown = false
    
    var qrCodeEditedMedia: SocialMediaItem?
    @Published var qrCodeSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        Task {
            await updateMediaList()
        }
    }
    
    @MainActor
    private func updateMediaList () async {
        var list: [SocialMediaItem] = []
        
        if let profile, let socialMediasList = profile.socialMediasList {
            for item in socialMediasList {
                var preview: UIImage?
                if item.qrCodeId != -1 {
                    preview = await uploadQRCode(id: item.qrCodeId)
                }
                list.append(SocialMediaItem(entity: item, qrCodePreview: preview))
            }
        }
        
        mediaList = list.sorted(by: { $0.position < $1.position })
    }
    
    private func uploadQRCode (id: Int) async -> UIImage? {
        if id != -1, let icon = DatabaseBox.getQRCode(id: id), let data = icon.image, let uiImage = UIImage(data: data) {
            return await uiImage.resizeAsync(height: 120)
        }
        return nil
    }
    
    func deleteMedia (index: Int) {
        if let profile, index != -1 {
            let item = mediaList[index]
            profileManager.deleteSocialMedia(profile: profile, socialMedia: item.entity)
            mediaList.remove(at: index)
        }
    }
    
    func handleItemsMoved () {
        if mediaList.count > 1 {
            for i in 0..<mediaList.count {
                let item = mediaList[i]
                item.position = i
                mediaList[i] = item
                
                item.entity.position = item.position
            }
            DatabaseBox.saveContext()
        }
    }
    
    func showMediaAdding () {
        mediaAddingSheetShown = true
    }
    
    func handleMediaAddingFinished () {
        Task {
            await updateMediaList()
        }
    }
    
    func showQRCode (index: Int) {
        if index >= 0 && index < mediaList.count {
            qrCodeEditedMedia = mediaList[index]
            qrCodeSheetShown = true
        }
    }
    
    func handleQrCodeGenerator (id: Int) {
        if let qrCodeEditedMedia, id != -1 {
            qrCodeEditedMedia.qrCodeId = id
            qrCodeEditedMedia.entity.qrCodeId = id
            DatabaseBox.saveContext()
            Task {
                await updateMediaList()
            }
        }
    }
}
