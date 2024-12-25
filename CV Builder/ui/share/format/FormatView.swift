//
//  FormatView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct FormatView: View {
    
    @Binding var format: Format
    let clickHandler: () -> Void
    
    @State var isSelected = false
    @State var animated = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack (alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 16.0).fill(format.color.opacity(0.04)).aspectRatio(0.7, contentMode: .fit).offset(x: animated ? -24 : -36, y: 12).scaleEffect(1.2).rotationEffect(Angle(degrees: animated ? 5 : 0))
                    
                    RoundedRectangle(cornerRadius: 16.0).fill(format.color.opacity(0.07)).aspectRatio(0.7, contentMode: .fit).offset(x: animated ? -14 : -24, y: 24).scaleEffect(1.1).rotationEffect(Angle(degrees: animated ? 8 : 0))
                    
                    Image(format.icon).resizable().scaledToFit().frame(width: 64, height: 64).scaleEffect(animated ? 1.0 : 0.8).scaleEffect(isSelected ? 1.1 : 1.0)
                    
                }.frame(width: 82).padding(.trailing)
                
                VStack {
                    Text(format.header).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.bottom, 2)
                    
                    Text(format.description).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    if format.isRecommended {
                        LabelView(text: NSLocalizedString("recommended", comment: ""), backColor: .windowColored, textColor: .accentLight).padding(.top, 4)
                    }

                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding(.vertical)
                
                SelectedIndicatorView(isSelected: $isSelected, type: 1).padding(8).padding(.trailing, 4)
                
            }.background {
                RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
            }.clipShape(RoundedRectangle(cornerRadius: 20.0)).overlay {
                RoundedRectangle(cornerRadius: 20.0).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
            }.scaleEffect(isSelected ? 1.02 : 1.0)
            
        }.onAppear() {
            withAnimation {
                isSelected = format.isSelected
                animated = true
            }
        }.onChange(of: format.isSelected) {
            withAnimation {
                isSelected = format.isSelected
            }
        }
    }
}

#Preview {
    FormatView(format: .constant(Format.getDefault()), clickHandler: {})
}
