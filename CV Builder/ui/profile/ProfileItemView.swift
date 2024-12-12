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
            HStack (spacing: 0) {
                
                ZStack (alignment: .leading) {
                    
                    Image("linkedin_import_illustration").renderingMode(.template).cropped(horizontalOffset: 100, verticalOffset: 50).foregroundStyle(Color.windowTwo).opacity(0.5).frame(width: 60)
                    
                    ZStack {
                        
                        Image(systemName: item.icon).font(.title3).foregroundStyle(progress == 0.0 ? .textAdditional : .accent)
                        
                    }.frame(width: 54, height: 54).background() {
                        RoundedRectangle(cornerRadius: 12.0).foregroundStyle(Color.window).shadow(color: Color.black.opacity(0.05), radius: 6)
                    }.padding([.leading, .top, .bottom])
                    
                }.padding(.trailing)
                
                VStack (spacing: 0) {
                    
                    Text(item.header).font(.title2).bold().foregroundLinearGradient(colors: progress == 1.0 ? [ Color.accent, Color.accentLight] : [Color.text], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                    Text(item.description).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.top, 8).lineLimit(3)
                    
                    HorizontalProgressView(progress: $progress).padding(.top)
                    
                }.padding(.trailing, 4).padding(.vertical)
                
                Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                
            }.clipShape(RoundedRectangle(cornerRadius: 16.0)).background() {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            }
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
