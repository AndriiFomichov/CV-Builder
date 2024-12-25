//
//  FontItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 02.12.2024.
//

import SwiftUI

struct FontItemView: View {
    
    @Binding var font: String?
    @Binding var fontSize: Int
    var fontSizeRange: ClosedRange<Int> = 1...54
    
    let fontType: String
    
    let clickHandler: () -> Void
    let sizeHandler: () -> Void
    
    var body: some View {
        if let font {
            VStack (spacing: 8) {
                
                Text(fontType).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                
                Button (action: clickHandler) {
                    VStack (spacing: 8) {
                        
                        ZStack {
                            
                            Text(font).font(SwiftUI.Font.custom(font, size: 24)).foregroundStyle(.accent).lineLimit(1)
                            
                        }.frame(height: 48).frame(maxWidth: .infinity).background() {
                            RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.windowColored)
                        }
                        
                        HStack (spacing: 0) {
                            
                            ZStack {
                                
                                Image(systemName: "textformat.characters").font(.headline).foregroundStyle(.accent)
                                
                            }.frame(width: 42, height: 42).background() {
                                RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                            }.padding(.trailing, 8)
                            
                            Text(NSLocalizedString("select_font", comment: "")).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                            
                            Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline)
                        }
                        
                    }.padding(8).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
                    }
                }.padding(.horizontal)
                
                SliderButtonView(text: NSLocalizedString("select_size", comment: ""), value: $fontSize, sliderRange: fontSizeRange).padding(.horizontal).onChange(of: fontSize) {
                    sizeHandler()
                }
                
            }.padding(.bottom)
        }
    }
}

#Preview {
    FontItemView(font: .constant("Roboto"), fontSize: .constant(12), fontType: "Headers", clickHandler: {}, sizeHandler: {})
}
