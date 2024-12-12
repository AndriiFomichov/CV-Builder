//
//  ImagePreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct ImagePreviewView: View {
    
    var imageId: Int
    var imageName: String = ""
    var cornerTL: CGFloat
    var cornerTT: CGFloat
    var cornerBL: CGFloat
    var cornerBT: CGFloat
    var width: CGFloat
    var height: CGFloat
    var zoom: CGFloat
    var filterEnabled: Bool
    var filterColor: String
    var strokeWidth: Int
    var strokeColor: String
    
    var body: some View {
        VStack {
            if let image = getUiImage() {
                Image(uiImage: image).centerCropped().scaleEffect(zoom)
            } else {
                Color(hex: filterColor)
            }
        }.frame(width: width, height: height).clipShape(UnevenRoundedRectangle(topLeadingRadius: cornerTL, bottomLeadingRadius: cornerBL, bottomTrailingRadius: cornerBT, topTrailingRadius: cornerTT)).overlay {
            UnevenRoundedRectangle(topLeadingRadius: cornerTL, bottomLeadingRadius: cornerBL, bottomTrailingRadius: cornerBT, topTrailingRadius: cornerTT).fill(.clear).stroke(Color(hex: strokeColor), style: StrokeStyle(lineWidth: CGFloat(strokeWidth)))
        }
        
    }
    
    private func getUiImage () -> UIImage? {
        if imageId == -1 && !imageName.isEmpty {
            if let image = UIImage(named: imageName) {
                return image.resize(height: height)
            }
        } else {
            if let entity = DatabaseBox.getImage(id: imageId), let data = entity.image, let image = UIImage(data: data) {
                return image.resize(height: height)
            }
        }
        return nil
    }
}

#Preview {
    ImagePreviewView(imageId: 0, cornerTL: 12, cornerTT: 12, cornerBL: 12, cornerBT: 12, width: 100, height: 100, zoom: 1.1, filterEnabled: false, filterColor: "#ACFFFF", strokeWidth: 0, strokeColor: "")
}
