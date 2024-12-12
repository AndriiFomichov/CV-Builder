//
//  QRCodePreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct QRCodePreviewView: View {
    
    var qrCodeId: Int
    var foregroundColor: String
    var backgroundColor: String
    var isBackgroundAdded: Bool
    var width: CGFloat
    var height: CGFloat
    var cornersRadius: CGFloat
    
    var body: some View {
        VStack {
            if let image = getUiImage() {
                Image(uiImage: image).renderingMode(.template).resizable().scaledToFit().foregroundStyle(Color(hex: foregroundColor)).padding(isBackgroundAdded ? 8 : 0)
            } else {
                RoundedRectangle(cornerRadius: cornersRadius).fill(Color(hex: backgroundColor))
            }
        }.frame(width: width, height: height).background() {
            if isBackgroundAdded, !backgroundColor.isEmpty {
                RoundedRectangle(cornerRadius: cornersRadius).fill(Color(hex: backgroundColor))
            }
        }
    }
    
    private func getUiImage () -> UIImage? {
        if let qrCode = DatabaseBox.getQRCode(id: qrCodeId), let data = qrCode.image, let image = UIImage(data: data) {
            return image.resize(height: height)
        }
        return nil
    }
}

#Preview {
    QRCodePreviewView(qrCodeId: 0, foregroundColor: "#000000", backgroundColor: "#ACFFFF", isBackgroundAdded: true, width: 100, height: 100, cornersRadius: 12.0)
}
