//
//  BackgroundRemoverViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import BackgroundRemoval

class BackgroundRemoverViewModel: ObservableObject {
    
    var imageId = -1
    
    let profileManager = ProfileManager()
    
    @Published var imagePreview: UIImage?
    @Published var imageResultPreview: UIImage?
    @Published var btnMainLoading = false
    @Published var btnMainSelected = true
    @Published var btnMainText = ""
    @Published var attemptsVisible = true
    @Published var attemptsText = ""
    @Published var lockedIconVisible = false
    @Published var isBackgroundRemoving = false
    @Published var btnCancelVisible = false
    @Published var tipsShown = false
    @Published var dismissed = false
    @Published var paywallPresented = false
    @Published var errorDialogShown = false
    
    var isBackgroundRemoved = false
    var resultImageData: Data?
    
    func updateData (imageId: Int) {
        self.imageId = imageId
        checkTips()
        updateAttempts()
        if imagePreview == nil {
            Task {
                await loadImagePreview()
            }
        }
        
        AnalyticsManager.saveEvent(event: Events.AI_BACK_REMOVER_OPENED)
    }
    
    private func checkTips () {
        if !Defaults.KEY_GUIDE_BACK_REMOVER {
            showTips()
            Defaults.KEY_GUIDE_BACK_REMOVER = true
        }
    }
    
    @MainActor
    private func loadImagePreview () async {
        if imageId != -1, let image = DatabaseBox.getImage(id: imageId), let data = image.image, let uiImage = UIImage(data: data) {
            self.imagePreview = await uiImage.resizeAsync(height: 450)
        }
    }
    
    func updateAttempts () {
        if Defaults.KEY_ACCOUNT_TYPE == 0 {
            if AiManager.getCurrentBackRemoverAttempts() > 0 {
                lockedIconVisible = false
                btnMainText = NSLocalizedString("remove_background", comment: "")
                attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: String(AiManager.getCurrentBackRemoverAttempts()))
            } else {
                lockedIconVisible = true
                btnMainText = NSLocalizedString("upgrade_you_plan_to_remove_background", comment: "")
                attemptsText = NSLocalizedString("free_attempts_left", comment: "").replacingOccurrences(of: "3", with: "0")
            }
        } else {
            lockedIconVisible = false
            btnMainText = NSLocalizedString("remove_background", comment: "")
            attemptsText = ""
            attemptsVisible = false
        }
    }
    
    func showTips () {
        tipsShown.toggle()
    }
    
    func nextStep () {
        if tipsShown {
            showTips()
        } else {
            if isBackgroundRemoved {
                Task {
                    await saveImageCopy()
                }
            } else if !isBackgroundRemoving {
                if Defaults.KEY_ACCOUNT_TYPE == 0 && AiManager.getCurrentBackRemoverAttempts() <= 0 {
                    showPaywall()
                } else {
                    Task {
                        await removeBackground()
                    }
                }
            }
        }
    }
    
    func close () {
        dismissed = true
    }
    
    @MainActor
    private func removeBackground () async {
        if let imagePreview {
            btnMainSelected = false
            isBackgroundRemoving = true
            
            let backgroundRemoval = BackgroundRemoval()
            
            print("Initial size. Width: " + String(Int(imagePreview.size.width)) + " height: " + String(Int(imagePreview.size.height)))
            
            do {
                let result = try backgroundRemoval.removeBackground(image: imagePreview)
                
                let croppedResult = await result.cropAsync(to: CGSizeMake(imagePreview.size.width, imagePreview.size.height))
                
                if let data = croppedResult.pngData() {
                    resultImageData = data
                    
                    print("Final size. Width: " + String(Int(croppedResult.size.width)) + " height: " + String(Int(croppedResult.size.height)))
                    
                    AiManager.useBackRemoverAttempt()
                    
                    imageResultPreview = croppedResult
                    
                    btnCancelVisible = true
                    attemptsVisible = false
                    btnMainText = NSLocalizedString("apply", comment: "")
                    isBackgroundRemoving = false
                    isBackgroundRemoved = true
                    
                    AnalyticsManager.saveEvent(event: Events.AI_BACK_REMOVER_APPLIED)
                    
                } else {
                    errorDialogShown = true
                    isBackgroundRemoving = false
                    updateAttempts()
                }
                
            } catch {
                print(error)
                errorDialogShown = true
                isBackgroundRemoving = false
                updateAttempts()
            }
            
            btnMainSelected = true
            
        } else {
            errorDialogShown = true
        }
    }
    
    func drawImage(_ image: UIImage) async -> UIImage? {
        guard let coreImage = image.cgImage else {
            return nil;
        }
        UIGraphicsBeginImageContext(CGSize(width: coreImage.width, height: coreImage.height))
        image.draw(in: CGRect(x: Int(0.0), y: Int(0.0), width: coreImage.width, height: coreImage.height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return resultImage;
    }
    
    @MainActor
    private func saveImageCopy () async {
        btnMainLoading = true
        
        if let resultImageData {
            var newImageId = -1
            
            newImageId = await profileManager.savePhoto(image: resultImageData, isBackgroundRemoved: true)
            
            if newImageId != -1 {
                profileManager.deleteImage(id: imageId)
                imageId = newImageId
                AnalyticsManager.saveEvent(event: Events.AI_BACK_REMOVER_SAVED)
            }
        }
        
        close()
    }
    
    private func showPaywall () {
        paywallPresented = true
    }
}
