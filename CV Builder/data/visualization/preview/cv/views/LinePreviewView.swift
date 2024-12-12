//
//  LinePreviewView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 06.12.2024.
//

import SwiftUI

struct LinePreviewView: View {
    
    var color: String
    
    var width: Int
    var cornersRadius: CGFloat
    var orientation: Int
    
    var dotAdded: Bool
    var dotBackColor: String
    var dotStrokeColor: String
    var dotBackAdded: Bool
    var dotStrokeAdded: Bool
    
    var body: some View {
        if orientation == 0 {
            ZStack {
                RoundedRectangle(cornerRadius: cornersRadius).fill(color.isEmpty ? .clear : Color(hex: color)).frame(height: CGFloat(width))
                if dotAdded {
                    HStack {
                        DotPreviewView(color: dotBackColor, width: width * 2, height: width * 2, strokeWidth: width / 3, strokeColor: dotStrokeColor, backAdded: dotBackAdded, strokeAdded: dotStrokeAdded)
                        Spacer()
                        DotPreviewView(color: dotBackColor, width: width * 2, height: width * 2, strokeWidth: width / 3, strokeColor: dotStrokeColor, backAdded: dotBackAdded, strokeAdded: dotStrokeAdded)
                    }
                }
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: cornersRadius).fill(color.isEmpty ? .clear : Color(hex: color)).frame(width: CGFloat(width))
                if dotAdded {
                    VStack {
                        DotPreviewView(color: dotBackColor, width: width * 2, height: width * 2, strokeWidth: width / 3, strokeColor: dotStrokeColor, backAdded: dotBackAdded, strokeAdded: dotStrokeAdded)
                        Spacer()
                        DotPreviewView(color: dotBackColor, width: width * 2, height: width * 2, strokeWidth: width / 3, strokeColor: dotStrokeColor, backAdded: dotBackAdded, strokeAdded: dotStrokeAdded)
                    }
                }
            }
        }
    }
}

#Preview {
    LinePreviewView(color: "#000000", width: 12, cornersRadius: 12.0, orientation: 1, dotAdded: true, dotBackColor: "", dotStrokeColor: "", dotBackAdded: true, dotStrokeAdded: true)
}
