//
//  PhotoTipView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct PhotoTipView: View {
    
    let tip: PhotoTip
    
    var body: some View {
        HStack (spacing: 0) {
            
            if tip.orientation == 0 {
                if !tip.imageOne.isEmpty {
                    ZStack (alignment: .topTrailing) {
                        Image(tip.imageOne).centerCropped().background() {
                            Color.windowColored
                        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
                        
                        if !tip.imageTwo.isEmpty {
                            Image(systemName: "xmark.circle").font(.headline).foregroundStyle(.white).padding(4)
                        }
                        
                    }.aspectRatio(0.75, contentMode: .fit).frame(height: 100).padding(.trailing, 8)
                }
                
                if !tip.imageTwo.isEmpty {
                    ZStack (alignment: .topTrailing) {
                        Image(tip.imageTwo).centerCropped().background() {
                            Color.windowColored
                        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
                        
                        Image(systemName: "checkmark.circle.fill").font(.headline).foregroundStyle(.accent).padding(4)
                        
                    }.aspectRatio(0.75, contentMode: .fit).frame(height: 100).padding(.trailing, 8)
                }
                
                VStack {
                    Text(tip.header).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    if !tip.description.isEmpty {
                        Text(tip.description).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    }
                }.padding(.vertical, 8)
            } else {
                
                VStack {
                    Text(tip.header).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    if !tip.description.isEmpty {
                        Text(tip.description).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    }
                }.padding(.vertical, 8).padding(.leading, 8)
                
                if !tip.imageOne.isEmpty {
                    ZStack (alignment: .topTrailing) {
                        Image(tip.imageOne).centerCropped().background() {
                            Color.windowColored
                        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
                        
                        if !tip.imageTwo.isEmpty {
                            Image(systemName: "xmark.circle").font(.headline).foregroundStyle(.white).padding(4)
                        }
                        
                    }.aspectRatio(0.75, contentMode: .fit).frame(height: 100).padding(.leading, 8)
                }
                
                if !tip.imageTwo.isEmpty {
                    ZStack (alignment: .topTrailing) {
                        Image(tip.imageTwo).centerCropped().background() {
                            Color.windowColored
                        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
                        
                        Image(systemName: "checkmark.circle.fill").font(.headline).foregroundStyle(.accent).padding(4)
                        
                    }.aspectRatio(0.75, contentMode: .fit).frame(height: 100).padding(.leading, 8)
                }
            }
            
        }.padding(8).background() {
            
            ColorBackgroundView(alignment: tip.backgroundAlignment)
            
        }.clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}

#Preview {
    PhotoTipView(tip: PhotoTip.getDefault())
}
