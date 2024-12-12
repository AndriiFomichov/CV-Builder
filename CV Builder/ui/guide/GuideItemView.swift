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
                    
                    Text(item.header).font(item.isHeaderLarge ? .largeTitle : .title2).bold().foregroundLinearGradient(colors: item.isHeaderHighlighted ? [ Color.accent, Color.accentLight] : [Color.text], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                    
                    if !item.description.isEmpty {
                        Text(item.description).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).offset(y: -8).padding(.top, 1)
                    }
                    
                    if !item.tip.isEmpty {
                        Text(item.tip).font(.caption).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).offset(y: -8).padding(.top, 4)
                    }
                    
                }.padding(12)
                
                if item.alignment == 1, !item.illustration.isEmpty {
                    ScreenIllustrationView(illustration: item.illustration).padding([.top, .trailing], 12)
                }
                
            }
            
        }.background() {
            
            ZStack (alignment: getGravityForLine() == 1 ? .bottomTrailing : .bottomLeading) {
                Rectangle().foregroundStyle(Color.backgroundDark.shadow(.inner(color: .text.opacity(0.08), radius: 16, x: 1, y: 1)))
                
                if !item.lineIllustration.isEmpty {
                    Image(item.lineIllustration).renderingMode(.template).resizable().scaledToFit().foregroundStyle(.backgroundDarker)
                }
            }
            
        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    private func getGravityForLine () -> Int {
        switch item.lineIllustration {
        case "small_line_one_illustration":
            return 0
        case "small_line_two_illustration":
            return 0
        case "small_line_three_illustration":
            return 1
        case "small_line_four_illustration":
            return 1
        case "small_line_five_illustration":
            return 0
        default:
            return 0
        }
    }
}

struct ScreenIllustrationView: View {
    
    let illustration: String
    
    var body: some View {
        Image(illustration).cropped(horizontalOffset: 50, verticalOffset: 0).offset(y: 20).scaleEffect(1.7).frame(width: 130, height: 235).clipped()
    }
}

#Preview {
    GuideItemView(item: GuideItem.getDefault())
}
