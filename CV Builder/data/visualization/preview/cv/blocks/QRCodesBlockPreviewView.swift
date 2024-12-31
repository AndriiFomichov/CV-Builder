//
//  QRCodesBlockPreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 18.11.2024.
//

import SwiftUI

struct QRCodesBlockPreviewView: View {
    
    var cv: CVEntityWrapper
    
    var qrForegroundColor: String
    var qrBackgroundColor: String
    
    var blockBackgroundColor: String
    var blockStrokeColor: String
    
    var addDivider: Bool = false
    var addBlockPadding: Bool = false
    var addBottomPadding: Bool = false
    
    var body: some View {
        if let block = cv.qrCodesBlock, block.qrCodes.count > 0 {
            VStack (spacing: 0) {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: CGFloat(cv.marginsSize / 3)) {
                    ForEach(0..<block.qrCodes.count, id:\.self) { item in
                        QRCodePreviewView(qrCodeId: block.qrCodes[item], foregroundColor: qrForegroundColor, backgroundColor: qrBackgroundColor, isBackgroundAdded: block.styleBackAdded, width: 60.0, height: 60.0, cornersRadius: CGFloat(cv.cornersRadius))
                    }
                }
                
                if addDivider {
                    RoundedRectangle(cornerRadius: CGFloat(cv.cornersRadius)).fill(Color(hex: cv.lineColor)).frame(height: CGFloat(cv.lineWidth)).padding(.top, CGFloat(cv.marginsSize))
                }
                
            }.padding(CGFloat(addBlockPadding ? cv.marginsSize : 0)).background() {
                if !blockBackgroundColor.isEmpty {
                    RoundedRectangle(cornerRadius: CGFloat(0)).fill(Color(hex: blockBackgroundColor))
                }
            }.overlay {
                if !blockStrokeColor.isEmpty {
                    RoundedRectangle(cornerRadius: CGFloat(0)).fill(.clear).stroke(Color(hex: blockStrokeColor), style: StrokeStyle(lineWidth: CGFloat(cv.strokeWidth)))
                }
            }.padding(.bottom, CGFloat(addBottomPadding ? cv.marginsSize : 0))
        }
    }
    
    private func getQRCodeEntity (id: Int) -> QRCodeEntity? {
        return DatabaseBox.getQRCode(id: id)
    }
}

#Preview {
    let visualization = CVVisualizationBuilder()
    let defaultWrapper = CVEntityWrapper.getDefault()
    let wrapper = visualization.updatePositionsWrapperOne(style: Style.getDefault(), wrapper: defaultWrapper)
    QRCodesBlockPreviewView(cv: wrapper, qrForegroundColor: "#000000", qrBackgroundColor: "#ACFFFF", blockBackgroundColor: "", blockStrokeColor: "")
}
