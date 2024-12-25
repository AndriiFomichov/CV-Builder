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
    
    @State var previewOne: UIImage?
    @State var previewTwo: UIImage?
    @State var header = ""
    @State var description = ""
    
    var body: some View {
        Button (action: clickHandler) {
            
            VStack (spacing: 0) {
                
                if let cv {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))
                        
                        ZStack {
                            if let previewTwo {
                                Image(uiImage: previewTwo).centerCropped().scaleEffect(1.01).clipShape(RoundedRectangle(cornerRadius: 8.0)).scaleEffect(1.02).rotationEffect(Angle(degrees: 3))
                            }
                            
                            if let previewOne {
                                Image(uiImage: previewOne).centerCropped().scaleEffect(1.01).clipShape(RoundedRectangle(cornerRadius: 8.0)).shadow(color: .black.opacity(0.2), radius: 30)
                            } else {
                                RoundedRectangle(cornerRadius: 8.0).fill(Color.window)
                            }
                            
                        }.aspectRatio(0.707070707, contentMode: .fit).padding().padding(4)
                        
                    }.clipShape(RoundedRectangle(cornerRadius: 16.0)).padding(8)
                    
                    HStack {
                        
                        VStack {
                            Text(header).font(.headline).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                            
                            if !description.isEmpty {
                                Text(description).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                            }
                        }
                        
                        Button (action: additionalClickHandler) {
                            ZStack {
                                
                                Image(systemName: "ellipsis").font(.headline).foregroundStyle(.textAdditional).rotationEffect(Angle(degrees: 90.0))
                                
                            }.frame(width: 36, height: 36)
                        }
                        
                    }.padding([.leading, .bottom], 8).onAppear() {
                        withAnimation {
                            previewOne = cv.previewOne
                            previewTwo = cv.previewTwo
                            header = cv.targetJob.isEmpty ? NSLocalizedString("universal", comment: "") : cv.targetJob
                            description = cv.targetCompany
                        }
                    }.onChange(of: cv.previewOne) {
                        withAnimation {
                            previewOne = cv.previewOne
                        }
                    }.onChange(of: cv.previewTwo) {
                        withAnimation {
                            previewTwo = cv.previewTwo
                        }
                    }.onChange(of: cv.targetJob) {
                        withAnimation {
                            header = cv.targetJob.isEmpty ? NSLocalizedString("universal", comment: "") : cv.targetJob
                        }
                    }.onChange(of: cv.targetCompany) {
                        withAnimation {
                            description = cv.targetCompany
                        }
                    }
                    
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.windowTwo.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))

                        RoundedRectangle(cornerRadius: 8.0).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(8.0, style: .circular))).padding().padding(4)
                        
                    }.aspectRatio(0.707070707, contentMode: .fit).padding(8)
                    
                    HStack {
                        
                        VStack {
                            
                            Text("").frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 2).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(12.0, style: .circular))).frame(height: 20)
                            
                            Text("").frame(maxWidth: .infinity, alignment: .leading).skeleton(with: true, appearance: .solid(color: Color.window, background: Color.windowTwo), shape: .rounded(.radius(12.0, style: .circular))).frame(height: 16)
                            
                        }.padding(.trailing).padding(.trailing)
                        
                    }.padding([.leading, .bottom, .trailing], 8)
                }
                
            }.background() {
                RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
            }
            
        }
    }
}

#Preview {
    CVItemView(cv: .constant(CVItem.getDefault()), clickHandler: {}, additionalClickHandler: {})
}
