//
//  QualityView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct QualityView: View {
    
    var format: Format
    @Binding var item: Quality
    let clickHandler: () -> Void
    
    @State var animated = false
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack (alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 12.0).fill(format.color.opacity(0.04)).aspectRatio(0.7, contentMode: .fit).offset(x: animated ? -24 : -36, y: 12).scaleEffect(1.2).rotationEffect(Angle(degrees: animated ? 5 : 0))
                    
                    RoundedRectangle(cornerRadius: 12.0).fill(format.color.opacity(0.07)).aspectRatio(0.7, contentMode: .fit).offset(x: animated ? -14 : -24, y: 24).scaleEffect(1.1).rotationEffect(Angle(degrees: animated ? 8 : 0))
                    
                    Image(format.icon).resizable().scaledToFit().frame(width: 48, height: 48).scaleEffect(animated ? 1.0 : 0.8).scaleEffect(isSelected ? 1.1 : 1.0)
                    
                    Image(systemName: item.icon).font(.caption).foregroundStyle(format.color).padding(6).background {
                        Circle().fill(.windowTwo)
                    }.offset(x: 5, y: 20)
                    
                }.frame(width: 64).padding(.trailing)
                
                VStack (spacing: 0) {
                    
                    Text(item.name).font(.title2).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                    if item.isPremium && item.isPremiumVisible {
                        LabelView(text: NSLocalizedString("premium_plan", comment: "")).padding(.top, 4)
                    }
                    
                }.padding(.trailing, 4).padding(.vertical, 12)
                
                SelectedIndicatorView(isSelected: $isSelected, type: 1).padding(8)
                
            }.clipShape(RoundedRectangle(cornerRadius: 20.0)).background() {
                RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
            }.overlay {
                RoundedRectangle(cornerRadius: 20.0).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
            }.scaleEffect(isSelected ? 1.02 : 1.0)
            
        }.onAppear() {
            withAnimation {
                isSelected = item.isSelected
                animated = true
            }
        }.onChange(of: item.isSelected) {
            withAnimation {
                isSelected = item.isSelected
            }
        }
    }
}

#Preview {
    QualityView(format: Format.getDefault(), item: .constant(Quality.getDefault()), clickHandler: {})
}
