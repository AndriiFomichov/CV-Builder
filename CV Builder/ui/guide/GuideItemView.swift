//
//  GuideItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import SwiftUI

struct GuideItemView: View {
    
    let item: GuideItem
    
    var body: some View {
        ZStack {
            
            HStack {
                
                if item.alignment == 0, !item.illustration.isEmpty {
                    ScreenIllustrationView(illustration: item.illustration).padding([.leading, .top], 12)
                }
                
                VStack {
                    
                    Text(item.header).font(item.isHeaderLarge ? .largeTitle : .title2).bold().foregroundLinearGradient(colors: item.isHeaderHighlighted ? [ Color.accentLight, Color.accent ] : [Color.text], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                    
                    if !item.description.isEmpty {
                        Text(item.description).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).offset(y: -8).padding(.top, 1)
                    }
                    
                    if !item.tip.isEmpty {
                        Text(item.tip).font(.caption).foregroundStyle(.accentLight).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).offset(y: -8).padding(.top, 4)
                    }
                    
                }.padding(12)
                
                if item.alignment == 1, !item.illustration.isEmpty {
                    ScreenIllustrationView(illustration: item.illustration).padding([.top, .trailing], 12)
                }
                
            }
            
        }.frame(maxHeight: .infinity).background() {
            
            ColorBackgroundView(alignment: item.backgroundAlignment)
            
        }.clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}

struct ScreenIllustrationView: View {
    
    let illustration: String
    
    var body: some View {
        Image(illustration).cropped(horizontalOffset: 50, verticalOffset: 0).offset(y: 20).frame(width: 130, height: 235).clipped()
    }
}

#Preview {
    GuideItemView(item: GuideItem.getDefault())
}
