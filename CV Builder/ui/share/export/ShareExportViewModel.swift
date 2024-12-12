//
//  ShareExportViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation
import SwiftyUserDefaults
import UIKit

class ShareExportViewModel: ObservableObject {
    
    let exportManager = ExportManager()

    @Published var header = NSLocalizedString("exporting_files", comment: "")
    @Published var isLoading = false
    @Published var fileIcon = ""
    @Published var btnMainSelected = false
    @Published var exportedFiles: [ExportedFile] = []
    @Published var reviewAsked = false
    
    @Published var errorUnknownDialogShown = false
    
    var format = -1
    var name = "file_name"
    var quality = 0
    
    var parentViewModel: ShareViewModel?
    
    func updateData (parentViewModel: ShareViewModel) {
        self.parentViewModel = parentViewModel
        getData()
        requestReview()
        AnalyticsManager.saveEvent(event: Events.SHARE_EXPORT_OPENED)
        
        if let cv = parentViewModel.cv {
            if format != -1 {
                
                isLoading = true
                btnMainSelected = false
                
//                AiManager.useExportAttempt() /*----------------------------->>>>>>>>>>>>>>>>>>>>>> Unhide*/
                
                if format == 0 {
                    Task {
                        await exportPdfAsVector(cv: cv)
                    }
                } else {
                    Task {
                        await convertImages(cv: cv)
                    }
                }
                
            } else {
                print("Error 1")
                errorUnknownDialogShown = true
            }
        } else {
            print("Error 2")
            errorUnknownDialogShown = true
        }
    }
    
    private func requestReview () {
        if !Defaults.KEY_REVIEWED {
            reviewAsked = true
            Defaults.KEY_REVIEWED = true
        }
    }
    
    private func getData () {
        if let parentViewModel {
            name = parentViewModel.name
            format = parentViewModel.format
            quality = parentViewModel.quality
            fileIcon = format != 0 && format != 1 ? (format == 2 ? "icon_jpeg" : "icon_png") : "icon_pdf"
        }
    }
    
    @MainActor
    private func convertImages (cv: CVEntity) async {
        
        var pagesList: [UIImage] = []
        var cover: UIImage?
        
        let addBadge = Defaults.KEY_ACCOUNT_TYPE == 0
        
        let wrapper = CVEntityWrapper(entity: cv)
        let pages = CVVisualizationBuilder.getWrapperPagesCount(wrapper: wrapper)
        
        for i in 0..<pages {
            if let image = await exportManager.convertPageToExportUIImage(cv: wrapper, page: i, size: quality, addBadgeMadeWith: addBadge) {
                print("appended: width - " + String(Int(image.size.width)) + ", height - " + String(Int(image.size.height)))
                pagesList.append(image)
                print("Page appended")
            }
        }
        
        if let coverLetter = wrapper.coverLetter {
            if let image = await exportManager.convertCoverLetterToExportUIImage(cv: wrapper, size: quality, addBadgeMadeWith: addBadge) {
                print("appended: width - " + String(Int(image.size.width)) + ", height - " + String(Int(image.size.height)))
                cover = image
                print("Cover appended")
            }
        }
        
        if format == 1 {
            await exportPdfAsImages(cv: cv, pagesList: pagesList, cover: cover)
        } else {
            await exportImages(cv: cv, pagesList: pagesList, cover: cover)
        }
    }
    
    @MainActor
    private func exportImages (cv: CVEntity, pagesList: [UIImage], cover: UIImage?) async {
        if pagesList.count > 0 {
            var urls: [URL] = []
            for i in 0..<pagesList.count {
                let image = pagesList[i]
                
                if let url = await saveImageToDsik(fileName: name + " (" + String(i+1) + ")", image: image) {
                    urls.append(url)
                }
            }
            
            var coverUrl: URL?
            if let cover {
                coverUrl = await saveImageToDsik(fileName: name + " - " + NSLocalizedString("cover_letter", comment: ""), image: cover)
            }
            
            await createExportedFilesList(urlPages: urls, coverUrl: coverUrl)
        } else {
            errorUnknownDialogShown = true
        }
    }
    
    @MainActor
    private func saveImageToDsik (fileName: String, image: UIImage) async -> URL? {
        do {
            if format == 2 {
                return try await ExportManager.exportJpegToUrl(filename: fileName, image: image)
            } else if format == 3 {
                return try await ExportManager.exportPngToUrl(filename: fileName, image: image)
            }
        } catch {
            errorUnknownDialogShown = true
        }
        return nil
    }
    
    @MainActor
    private func exportPdfAsImages (cv: CVEntity, pagesList: [UIImage], cover: UIImage?) async {
        if pagesList.count > 0 {
            var urls: [URL] = []
            
            if pagesList.count > 0 {
                let url = await ExportManager.createPdfDocument(userName: "User name", fileName: name, pagesImages: pagesList)
                if let url {
                    urls.append(url)
                }
            }
            
            var coverUrl: URL?
            if let cover {
                coverUrl = await ExportManager.createPdfDocument(userName: "User name", fileName: name + " - " + NSLocalizedString("cover_letter", comment: ""), pagesImages: [cover])
            }
            
            await createExportedFilesList(urlPages: urls, coverUrl: coverUrl)
            
        } else {
            errorUnknownDialogShown = true
        }
    }
    
    @MainActor
    private func exportPdfAsVector (cv: CVEntity) async {
        let wrapper = CVEntityWrapper(entity: cv)

        let addBadge = Defaults.KEY_ACCOUNT_TYPE == 0
        
        var urls: [URL] = []
        
        let url = await exportManager.createPdfDocumentVector(userName: "User name", fileName: name, cv: wrapper, isCv: true, addBadgeMadeWith: addBadge)
        if let url {
            urls.append(url)
        }
        var coverUrl: URL?
        if wrapper.coverLetter != nil {
            coverUrl = await exportManager.createPdfDocumentVector(userName: "User name", fileName: name + " - " + NSLocalizedString("cover_letter", comment: ""), cv: wrapper, isCv: false, addBadgeMadeWith: addBadge)
        }
        
        await createExportedFilesList(urlPages: urls, coverUrl: coverUrl)
    }
    
    @MainActor
    private func createExportedFilesList (urlPages: [URL]? = nil, coverUrl: URL?) async {
        var filesList: [ExportedFile] = []
        
        if format == 0 || format == 1 {
            if let urlPages {
                filesList.append(ExportedFile(format: format, fileName: name, fileIcon: format == 0 ? "icon_pdf_vector" : "icon_pdf", url: urlPages[0]))
            }
            if let coverUrl {
                filesList.append(ExportedFile(format: format, fileName: name + " - " + NSLocalizedString("cover_letter", comment: ""), fileIcon: format == 0 ? "icon_pdf_vector" : "icon_pdf", url: coverUrl))
            }
            
            if format == 0 {
                AnalyticsManager.saveEvent(event: Events.EXPORTED_PDF_VECTOR)
            } else if format == 1 {
                AnalyticsManager.saveEvent(event: Events.EXPORTED_PDF)
            }
            
        } else {
            if let urlPages {
                for i in 0..<urlPages.count {
                    let file = ExportedFile(format: format, fileName: name + " (" + String(i+1) + ")", fileIcon: format == 2 ? "icon_jpeg" : "icon_png", url: urlPages[i])
                    filesList.append(file)
                }
            }
            if let coverUrl {
                filesList.append(ExportedFile(format: format, fileName: name + " - " + NSLocalizedString("cover_letter", comment: ""), fileIcon: format == 2 ? "icon_jpeg" : "icon_png", url: coverUrl))
            }
            
            if format == 2 {
                AnalyticsManager.saveEvent(event: Events.EXPORTED_JPEG)
            } else if format == 3 {
                AnalyticsManager.saveEvent(event: Events.EXPORTED_PNG)
            }
        }
        
        if filesList.count > 0 {
            exportedFiles = filesList
            isLoading = false
            btnMainSelected = true
            header = NSLocalizedString("complete", comment: "")
        } else {
            print("Error 3")
            errorUnknownDialogShown = true
        }
    }
    
    func nextStep () {
        if !isLoading {
            close()
        }
    }
    
    func close () {
        if let parentViewModel {
            parentViewModel.closeSheet()
        }
    }
}
