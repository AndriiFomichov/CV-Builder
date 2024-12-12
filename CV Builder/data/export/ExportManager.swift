//
//  ExportManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.11.2024.
//

import Foundation
import SwiftUI

class ExportManager {
    
    var rendererCv: ImageRenderer<CVMakerExportView>?
    var rendererCover: ImageRenderer<CoverMakerExportView>?

    @MainActor
    func convertPageToExportUIImage (cv: CVEntityWrapper, page: Int, size: Int, addBadgeMadeWith: Bool) async -> UIImage? {
        let image = autoreleasepool {
            let renderer = createRendererCv(cv: cv, page: page, addBadgeMadeWith: addBadgeMadeWith)
            let image = renderer.uiImage
            renderer.content = CVMakerExportView(cv: CVEntityWrapper(), page: 0)
            return image
        }
        if let image = image {
            return await image.resizeAsync(height: getExportSizeParams(size: size).height)
        } else {
            return image
        }
    }
    
    @MainActor
    func convertCoverLetterToExportUIImage (cv: CVEntityWrapper, size: Int, addBadgeMadeWith: Bool) async -> UIImage? {
        let image = autoreleasepool {
            let renderer = createRendererCover(cv: cv, addBadgeMadeWith: addBadgeMadeWith)
            let image = renderer.uiImage
            renderer.content = CoverMakerExportView(cv: cv)
            return image
        }
        if let image = image {
            return await image.resizeAsync(height: getExportSizeParams(size: size).height)
        } else {
            return image
        }
    }
    
    @MainActor
    private func createRendererCv (cv: CVEntityWrapper, page: Int, addBadgeMadeWith: Bool) -> ImageRenderer<CVMakerExportView> {
        return autoreleasepool {
            if let renderer = rendererCv {
                renderer.content = CVMakerExportView(cv: cv, page: page)
                return renderer
            } else {
                let rend = ImageRenderer(content: CVMakerExportView(cv: cv, page: page))
                rendererCv = rend
                return rend
            }
        }
    }
    
    @MainActor
    private func createRendererCover (cv: CVEntityWrapper, addBadgeMadeWith: Bool) -> ImageRenderer<CoverMakerExportView> {
        return autoreleasepool {
            if let renderer = rendererCover {
                renderer.content = CoverMakerExportView(cv: cv)
                return renderer
            } else {
                let rend = ImageRenderer(content: CoverMakerExportView(cv: cv))
                rendererCover = rend
                return rend
            }
        }
    }
    
    func getExportSizeParams (size: Int) -> CGSize {
        switch size {
//        case 0:
//            return CGSize(width: 294.945, height: 417.13)
//        case 1:
//            return CGSize(width: 421.35, height: 595.90)
        default:
            return CGSize(width: 421.35, height: 595.90)
        }
    }
    
    static func exportPngToUrl (filename: String, image: UIImage) async throws -> URL? {
        let tempFolder = FileManager.default.temporaryDirectory
        let fileName = validateFileName(name: filename) + ".png"
        let url = tempFolder.appendingPathComponent(fileName)

        if let data = image.pngData() {
            do {
                try data.write(to: url, options: .atomic)
                return url
            } catch let error {
                print(error)
            }
        } else {
            print("Image has no data")
        }
        
        return nil
    }
    
    static func exportJpegToUrl (filename: String, image: UIImage) async throws -> URL? {
        let tempFolder = FileManager.default.temporaryDirectory
        let fileName = validateFileName(name: filename) + ".jpeg"
        let url = tempFolder.appendingPathComponent(fileName)

        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: url, options: .atomic)
                return url
            } catch let error {
                print(error)
            }
        } else {
            print("Image has no data")
        }
        
        return nil
    }
    
    static func createPdfDocument (userName: String, fileName: String, pagesImages: [UIImage]) async -> URL? /*PDFDocument?*/ {
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = [
            kCGPDFContextAuthor as String: userName != "" ? userName : "",
            kCGPDFContextSubject as String: fileName
        ]
        let rect = CGRect(x: 0, y: 0, width: pagesImages[0].size.width, height: pagesImages[0].size.height)
        let renderer = UIGraphicsPDFRenderer(bounds: rect, format: format)
        
        let tempFolder = FileManager.default.temporaryDirectory
        let fileName = validateFileName(name: fileName) + ".pdf"
        let tempURL = tempFolder.appendingPathComponent(fileName)
        
        await savePagesToPdf(renderer: renderer, tempURL: tempURL, pagesImages: pagesImages)
        
        return tempURL
    }
    
    private static func savePagesToPdf (renderer: UIGraphicsPDFRenderer, tempURL: URL, pagesImages: [UIImage]) async {
        try? renderer.writePDF(to: tempURL) { context in
            for page in pagesImages {
                context.beginPage()
                page.draw(at: CGPoint.zero)
            }
        }
    }
    
    
    @MainActor
    func createPdfDocumentVector (userName: String, fileName: String, cv: CVEntityWrapper, isCv: Bool, addBadgeMadeWith: Bool) async -> URL? /*PDFDocument?*/ {
        let tempFolder = FileManager.default.temporaryDirectory
        let fileName = ExportManager.validateFileName(name: fileName) + ".pdf"
        let tempURL = tempFolder.appendingPathComponent(fileName)
        
        if isCv {
            await saveCvPagesToPdfVector(wrapper: cv, url: tempURL, addBadgeMadeWith: addBadgeMadeWith)
        } else {
            await saveCoverToPdfVector(wrapper: cv, url: tempURL, addBadgeMadeWith: addBadgeMadeWith)
        }
       
        return tempURL
    }
    
    @MainActor
    private func saveCvPagesToPdfVector (wrapper: CVEntityWrapper, url: URL, addBadgeMadeWith: Bool) async {
        
        let pages = CVVisualizationBuilder.getWrapperPagesCount(wrapper: wrapper)
        
        if pages > 0 {
            let renderer = createRendererCv(cv: wrapper, page: 0, addBadgeMadeWith: addBadgeMadeWith)
            
            renderer.render { size, context in
                // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

                // 5: Create the CGContext for our PDF pages
                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                    return
                }

                for i in 0..<pages {
                    let pageRenderer = createRendererCv(cv: wrapper, page: i, addBadgeMadeWith: addBadgeMadeWith)
                    
                    pdf.beginPDFPage(nil)

                    pageRenderer.render { _, pageContext in
                        pageContext(pdf)
                    }

                    pdf.endPDFPage()
                }
                
                pdf.closePDF()
            }
        }
    }
    
    @MainActor
    private func saveCoverToPdfVector (wrapper: CVEntityWrapper, url: URL, addBadgeMadeWith: Bool) async {
        if let coverLetter = wrapper.coverLetter {
            let renderer = createRendererCover(cv: wrapper, addBadgeMadeWith: addBadgeMadeWith)
            
            renderer.render { size, context in
                // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

                // 5: Create the CGContext for our PDF pages
                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                    return
                }

                let pageRenderer = createRendererCover(cv: wrapper, addBadgeMadeWith: addBadgeMadeWith)
                
                pdf.beginPDFPage(nil)

                pageRenderer.render { _, pageContext in
                    pageContext(pdf)
                }

                pdf.endPDFPage()
                
                pdf.closePDF()
            }
            
        }
    }
    
    private static func validateFileName (name: String) -> String {
        var name = name
        do {
            if name.count > 255 {
                name = String(name[..<254])
            }
            
            let regex = try NSRegularExpression(pattern: "[\\W]+")
            let filename = regex.stringByReplacingMatches(in: name, options: [], range: NSRange(location: 0, length: name.count), withTemplate: "_")
            
            return filename
        } catch {
            print("Error")
        }
        
        return NSLocalizedString("new_presentation", comment: "")
    }
}
