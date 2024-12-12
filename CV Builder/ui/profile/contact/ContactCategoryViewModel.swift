//
//  ContactCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation
import UIKit

class ContactCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var phone = ""
    @Published var email = ""
    @Published var website = ""
    @Published var qrCodeId = -1
    @Published var qrCodePreview: UIImage?
    
    @Published var qrGeneratorSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        getData()
    }
    
    private func getData () {
        if let profile {
            phone = profile.phone
            email = profile.email
            website = profile.websiteLink
            qrCodeId = profile.websiteQrCodeId
            if qrCodeId != -1 {
                Task {
                    await showQRCode()
                }
            }
        }
    }
    
    @MainActor
    private func showQRCode () async {
        if qrCodeId != -1, let code = DatabaseBox.getQRCode(id: qrCodeId), let data = code.image, let uiImage = UIImage(data: data) {
            qrCodePreview = await uiImage.resizeAsync(height: 150)
        }
    }
    
    func openQrCode () {
        qrGeneratorSheetShown = true
    }
    
    func handleQrCodeGenerator (id: Int) {
        if id != -1 {
            qrCodeId = id
            Task {
                await showQRCode()
            }
        }
    }
    
    func handleLinkChange () {
        if let profile {
            if website != profile.websiteLink && qrCodeId != -1 {
                profileManager.deleteQrCode(id: qrCodeId)
                qrCodeId = -1
                qrCodePreview = nil
            }
            profile.websiteLink = website
        }
    }
    
    func save () {
        if let profile {
            profile.phone = phone
            profile.email = email
            profile.websiteLink = website
            profile.websiteQrCodeId = qrCodeId
            DatabaseBox.saveContext()
        }
    }
}
