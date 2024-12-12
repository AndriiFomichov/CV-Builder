//
//  QRCodeGenerator.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class QRCodeGenerator {
    
    func generateQR(text: String) -> Data? {
        let filter = CIFilter.qrCodeGenerator()
        guard let data = text.data(using: .ascii, allowLossyConversion: false) else { return nil }
        filter.message = data
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()
    }
}
