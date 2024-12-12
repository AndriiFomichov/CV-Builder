//
//  QualityView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct QualityView: View {
    
    @Binding var item: Quality
    let clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack (alignment: .leading) {
                    
                    Image("linkedin_import_illustration").renderingMode(.template).cropped(horizontalOffset: 100, verticalOffset: 50).foregroundStyle(Color.windowTwo).opacity(0.5).frame(width: 60)
                    
                    ZStack {
                        
                        Image(systemName: item.icon).font(.title3).foregroundStyle(.accent)
                        
                    }.frame(width: 54, height: 54).background() {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.window).shadow(color: Color.black.opacity(0.05), radius: 6)
                    }.padding([.leading, .top, .bottom])
                    
                }.padding(.trailing)
                
                VStack (spacing: 0) {
                    
                    Text(item.name).font(.title2).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                    if item.isPremium && item.isPremiumVisible {
                        HStack {
                            Text(NSLocalizedString("premium_plan", comment: "")).font(.subheadline).foregroundStyle(Color.white).multilineTextAlignment(.leading).padding(8).background() {
                                RoundedRectangle(cornerRadius: 12.0).fill(Color.accent)
                            }
                            Spacer()
                        }.padding(.top, 4)
                    }
                    
                }.padding(.trailing, 4).padding(.vertical)
                
                SelectedIndicatorView(isSelected: $isSelected).padding(8)
                
            }.clipShape(RoundedRectangle(cornerRadius: 16.0)).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            }.overlay {
                RoundedRectangle(cornerRadius: 16.0).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
            }
            
        }.onAppear() {
            withAnimation {
                isSelected = item.isSelected
            }
        }.onChange(of: item.isSelected) {
            withAnimation {
                isSelected = item.isSelected
            }
        }
    }
}

#Preview {
    QualityView(item: .constant(Quality.getDefault()), clickHandler: {})
}
