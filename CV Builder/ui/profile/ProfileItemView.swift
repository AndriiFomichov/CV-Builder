//
//  ProfileItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct ProfileItemView: View {
    
    @Binding var item: ProfileItem
    let clickHandler: () -> Void
    
    @State var progress: CGFloat = 0.0
    
    var body: some View {
        Button (action: clickHandler) {
            
            VStack {
                
                HStack {
                    
                    ZStack (alignment: .leading) {
                        
                        ZStack {
                            
                            Image(systemName: item.icon).font(.title3).foregroundStyle(progress == 1.0 ? .accent : .text)
                            
                            CircleProgressView(progress: progress, lineWidth: 2, backColor: .windowColored, textColor: .clear)
                            
                            if progress == 1.0 {
                                Image(systemName: "checkmark.circle.fill").font(.headline).foregroundStyle(.accent).offset(x: 20, y: 20)
                            }
                            
                        }.frame(width: 48, height: 48).background() {
                            RoundedRectangle(cornerRadius: 32.0).foregroundStyle(.windowColored)
                        }
                    }
                    
                    Spacer()
                    
                    Text(String(Int(progress * 100)) + "%").font(.subheadline).foregroundStyle(progress == 1.0 ? .accent : .text)
                }
                
                ZStack {
                    
                    Color.clear
                    
                    HStack {
                        
                        VStack (spacing: 4) {
                            Text(item.header).font(.title2).bold().foregroundLinearGradient(colors: progress == 1.0 ? [ Color.accentLight, Color.accent] : [Color.text], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                            
                            Text(item.description).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                        }
                        
                        Image(systemName: "chevron.right").foregroundStyle(.accentLight).font(.subheadline)
                        
                    }.padding(.vertical, 8)
                }
                
            }.padding(8).background() {
                ColorBackgroundView(alignment: .topTrailing, size: 130)
            }.clipShape(RoundedRectangle(cornerRadius: 20.0))
            
        }.onAppear() {
            withAnimation {
                progress = item.progress
            }
        }.onChange(of: item.progress) {
            withAnimation {
                progress = item.progress
            }
        }
    }
}

#Preview {
    ProfileItemView(item: .constant(ProfileItem.getDefault()), clickHandler: {})
}
