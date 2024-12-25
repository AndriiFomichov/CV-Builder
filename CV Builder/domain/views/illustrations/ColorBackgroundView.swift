//
//  ColorBackgroundView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.12.2024.
//

import SwiftUI

struct ColorBackgroundView: View {
    
    var alignment: Alignment = .bottomTrailing
    
    var size: CGFloat = 100.0
    var blur: CGFloat = 30.0
    
    var offsetX: CGFloat = 20.0
    var offsetY: CGFloat = 20.0
    
    init(alignment: Alignment = .bottomTrailing, x: CGFloat? = nil, y: CGFloat? = nil, size: CGFloat = 100.0, blur: CGFloat = 30.0) {
        self.alignment = alignment
        
        self.size = size
        self.blur = blur
        
        if let x {
            offsetX = x
        } else {
            offsetX = getOffsetXFromAlignment()
        }
        if let y {
            offsetY = y
        } else {
            offsetY = getOffsetYFromAlignment()
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [ .windowColored, .windowColored ], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack {
                HStack {
                    if alignment == .topLeading {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                    Spacer()
                    if alignment == .top {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                    Spacer()
                    if alignment == .topTrailing {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                }
                
                Spacer()
                
                HStack {
                    if alignment == .leading {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                    Spacer()
                    if alignment == .center {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                    Spacer()
                    if alignment == .trailing {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                }
                
                Spacer()
                
                HStack {
                    if alignment == .bottomLeading {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                    Spacer()
                    if alignment == .bottom {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                    Spacer()
                    if alignment == .bottomTrailing {
                        Circle().fill(Color.circleColored).blur(radius: blur).frame(width: size, height: size).offset(x: offsetX, y: offsetY)
                    }
                }
            }
        }.clipped()
    }
    
    private func getOffsetXFromAlignment () -> CGFloat {
        switch alignment {
        case .topLeading:
            return size * -0.2
        case .leading:
            return size * -0.2
        case .bottomLeading:
            return size * -0.2
        case .topTrailing:
            return size * 0.2
        case .trailing:
            return size * 0.2
        case .bottomTrailing:
            return size * 0.2
        default:
            return 0.0
        }
    }
    
    private func getOffsetYFromAlignment () -> CGFloat {
        switch alignment {
        case .topLeading:
            return size * -0.2
        case .top:
            return size * -0.2
        case .topTrailing:
            return size * -0.2
        case .bottomLeading:
            return size * 0.2
        case .bottom:
            return size * 0.2
        case .bottomTrailing:
            return size * 0.2
        default:
            return 0.0
        }
    }
}

#Preview {
    ColorBackgroundView()
}
