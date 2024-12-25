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
    
    enum GeneratorType {
      case qrCode, barCode, aztecCode
      
      var filterName: String {
        switch self {
        case .aztecCode:
          return "CIAztecCodeGenerator"
        case .barCode:
          return "CICode128BarcodeGenerator"
        case .qrCode:
          return "CIQRCodeGenerator"
        }
      }
    }

    func generateCode(type: GeneratorType, text: String,
                      transform: CGAffineTransform = CGAffineTransform(scaleX: 32.0, y: 32.0),
                      fillColor: UIColor = UIColor.black,
                      backgroundColor: CIColor = CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)) -> Data? {
      guard let filter = CIFilter(name: type.filterName) else {
        return nil
      }
      
      filter.setDefaults()
      
      guard let data = text.data(using: String.Encoding.utf8) else {
        return nil
      }
      
      filter.setValue(data, forKey: "inputMessage")
      
      let filterFalseColor = CIFilter(name: "CIFalseColor")
      filterFalseColor?.setDefaults()
      filterFalseColor?.setValue(filter.outputImage, forKey: "inputImage")
      filterFalseColor?.setValue(CIColor(cgColor: fillColor.cgColor), forKey: "inputColor0")
      filterFalseColor?.setValue(backgroundColor, forKey: "inputColor1")
      
      
      guard let image = filterFalseColor?.outputImage else { return nil }
      
      return UIImage(ciImage: image.transformed(by: transform), scale: 1.0,
                     orientation: UIImage.Orientation.up).pngData()
    }
    
//    func generateQR(text: String) -> Data? {
//        let filter = CIFilter.qrCodeGenerator()
//        guard let data = text.data(using: .ascii, allowLossyConversion: false) else { return nil }
//        filter.message = data
//        filter.
//        guard let ciimage = filter.outputImage else { return nil }
//        let transform = CGAffineTransform(scaleX: 10, y: 10)
//        let scaledCIImage = ciimage.transformed(by: transform)
//        let uiimage = UIImage(ciImage: scaledCIImage)
//        return uiimage.pngData()
//    }
}
