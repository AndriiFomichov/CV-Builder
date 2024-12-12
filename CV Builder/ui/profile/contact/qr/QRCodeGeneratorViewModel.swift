//
//  QRCodeGeneratorViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class QRCodeGeneratorViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    let qrCodeGenerator = QRCodeGenerator()
    
    var initialQRCodeId = -1
    var selectedQRCodeId = -1
    
    var link: String?
    var qrCodeGenerated: Data?
    
    @Published var preview: UIImage?
    @Published var isLoading = false
    @Published var btnMainSelected = false
    @Published var btnMainText = ""
    
    @Published var lockedIconVisible = false
    @Published var attemptsVisible = true
    @Published var attemptsText = ""
    
    @Published var paywallSheetShown = false
    @Published var dismissed = false
    
    func updateData (initial: Int, link: String) {
        self.initialQRCodeId = initial
        self.link = link
        Task {
            if initialQRCodeId != -1 {
                await showPreview()
            } else {
                await createQrCode()
            }
        }
    }
    
    @MainActor
    private func showPreview () async {
        btnMainSelected = true
        btnMainText = NSLocalizedString("close", comment: "")
        attemptsVisible = false
        
        isLoading = true
        
        if let entity = DatabaseBox.getQRCode(id: initialQRCodeId) {
            await showPreview(data: entity.image)
        }
        
        isLoading = false
    }
    
    @MainActor
    private func createQrCode () async {
        updateAttempts()
        
        isLoading = true
        
        if let link, !link.isEmpty {
            qrCodeGenerated = qrCodeGenerator.generateQR(text: link)
            await showPreview(data: qrCodeGenerated)
        }
        
        isLoading = false
        btnMainSelected = true
    }
    
    func updateAttempts () {
        if Defaults.KEY_ACCOUNT_TYPE == 0 {
            if AiManager.getCurrentQRAttempts() > 0 {
                lockedIconVisible = false
                btnMainText = NSLocalizedString("create", comment: "")
                attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: String(AiManager.getCurrentQRAttempts()))
            } else {
                lockedIconVisible = true
                btnMainText = NSLocalizedString("upgrade_you_plan_to_create_qr_code", comment: "")
                attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: "0")
            }
        } else {
            lockedIconVisible = false
            btnMainText = NSLocalizedString("create", comment: "")
            attemptsText = ""
            attemptsVisible = false
        }
    }
    
    @MainActor
    private func showPreview (data: Data?) async {
        if let data, let uiImage = UIImage(data: data) {
            preview = await uiImage.resizeAsync(height: 250)
        }
    }
    
    @MainActor
    func nextStep () {
        if initialQRCodeId != -1 {
            dismissed = true
        } else {
            if let link, let qrCodeGenerated {
                if Defaults.KEY_ACCOUNT_TYPE == 0 && AiManager.getCurrentQRAttempts() <= 0 {
                    paywallSheetShown = true
                } else {
                    Task {
                        selectedQRCodeId = await profileManager.saveQRCode(image: qrCodeGenerated, link: link)
                        if selectedQRCodeId != -1 {
//                            AiManager.useQRAttempt()
                            profileManager.deleteQrCode(id: initialQRCodeId)
                        }
                        dismissed = true
                    }
                }
            } else {
                dismissed = true
            }
        }
    }
}
