//
//  ImageExtensions.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

extension SwiftUI.Image {
    func centerCropped () -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
    
    func cropped (horizontalOffset: Int, verticalOffset: Int) -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height, alignment: Image.getCropPoint(horizontalOffset: horizontalOffset, verticalOffset: verticalOffset))
            .clipped()
        }
    }
    
    private static func getCropPoint (horizontalOffset: Int, verticalOffset: Int) -> Alignment {
        if horizontalOffset == 0 {
            if verticalOffset == 0 {
                return Alignment.topLeading
            } else if verticalOffset == 50 {
                return Alignment.leading
            } else if verticalOffset == 100 {
                return Alignment.bottomLeading
            }
        } else if horizontalOffset == 50 {
            if verticalOffset == 0 {
                return Alignment.top
            } else if verticalOffset == 50 {
                return Alignment.center
            } else if verticalOffset == 100 {
                return Alignment.bottom
            }
        } else if horizontalOffset == 100 {
            if verticalOffset == 0 {
                return Alignment.topTrailing
            } else if verticalOffset == 50 {
                return Alignment.trailing
            } else if verticalOffset == 100 {
                return Alignment.bottomTrailing
            }
        }
        return Alignment.center
    }
}

extension UIImage {
    
    /// Resizes the image by keeping the aspect ratio
    func resize(height: CGFloat) -> UIImage {
        return autoreleasepool {
            
            let ratio = self.size.width / self.size.height
            
            var finalWidth = height
            var finalHeight = height
            if 1.0 > ratio {
                finalHeight = height / ratio
            } else {
                finalWidth = height * ratio
            }

            let newSize = CGSize(width: finalWidth, height: finalHeight)
            let renderer = UIGraphicsImageRenderer(size: newSize)
            
            return renderer.image { _ in
                self.draw(in: CGRect(origin: .zero, size: newSize))
            }
        }
    }
    
    func resizeAsync(height: CGFloat) async -> UIImage {
        return autoreleasepool {
            
            let ratio = self.size.width / self.size.height
            
            var finalWidth = height
            var finalHeight = height
            if 1.0 > ratio {
                finalHeight = height / ratio
            } else {
                finalWidth = height * ratio
            }

            let newSize = CGSize(width: finalWidth, height: finalHeight)
            
            let format = UIGraphicsImageRendererFormat()
//            format.scale = 1
            
            let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
            
            return renderer.image { _ in
                self.draw(in: CGRect(origin: .zero, size: newSize))
            }
        }
    }
    
    func cropAsync(to: CGSize) async -> UIImage {

        guard let cgimage = self.cgImage else { return self }

        let contextImage: UIImage = UIImage(cgImage: cgimage)

        guard let newCgImage = contextImage.cgImage else { return self }

        let contextSize: CGSize = contextImage.size

        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height

        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height

        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)

        // Create bitmap image from context using the rect
        guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self}

        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

        UIGraphicsBeginImageContextWithOptions(to, false, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resized ?? self
    }
}
