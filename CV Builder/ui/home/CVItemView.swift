//
//  CVItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct CVItemView: View {
    
    @Binding var cv: CVItem?
    let clickHandler: () -> Void
    let additionalClickHandler: () -> Void
    
    var body: some View {
        Button (action: clickHandler) {
            
            VStack (spacing: 0) {
                
                if let cv {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))
                        
                        ZStack {
                            if let previewTwo = cv.previewTwo {
                                Image(uiImage: previewTwo).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 8.0)).scaleEffect(1.02).rotationEffect(Angle(degrees: 3))
                            }
                            
                            if let previewOne = cv.previewOne {
                                Image(uiImage: previewOne).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 8.0))
                            } else {
                                RoundedRectangle(cornerRadius: 8.0).fill(Color.window)
                            }
                            
                        }.aspectRatio(0.707070707, contentMode: .fit).padding().padding(4)
                        
                    }.padding(8)
                    
                    HStack {
                        
                        VStack {
                            Text(cv.targetJob.isEmpty ? NSLocalizedString("universal", comment: "") : cv.targetJob).font(.headline).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                            
                            if !cv.targetCompany.isEmpty {
                                Text(cv.targetCompany).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                            }
                        }
                        
                        Button (action: additionalClickHandler) {
                            ZStack {
                                
                                Image(systemName: "ellipsis").font(.headline).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                                
                            }.frame(width: 36, height: 36)
                        }
                        
                    }.padding([.leading, .bottom], 8)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))

                        RoundedRectangle(cornerRadius: 8.0).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(8.0, style: .circular))).padding().padding(4)
                        
                    }.aspectRatio(0.707070707, contentMode: .fit).padding(8)
                    
                    HStack {
                        
                        VStack {
                            
                            Text("").frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 2).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(12.0, style: .circular)))
                            
                            Text("").frame(maxWidth: .infinity, alignment: .leading).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(12.0, style: .circular)))
                            
                        }.padding(.trailing).padding(.trailing)
                        
                    }.padding([.leading, .bottom, .trailing], 8)
                }
                
            }.background() {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            }
        }
    }
}

#Preview {
    CVItemView(cv: .constant(CVItem.getDefault()), clickHandler: {}, additionalClickHandler: {})
}
