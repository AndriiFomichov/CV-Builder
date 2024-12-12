//
//  BackRemoverIllustrationView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct BackRemoverIllustrationView: View {
    
    let rowOneColors = [ Color.windowTwo, Color.window, Color.windowTwo, Color.window, Color.windowTwo, Color.window, Color.windowTwo, Color.window, Color.windowTwo ]
    
    let rowTwoColors = [ Color.window, Color.windowTwo, Color.window, Color.windowTwo, Color.window, Color.windowTwo, Color.window, Color.windowTwo, Color.window ]
    
    var body: some View {
        ZStack {
            
            ZStack {
                
                VStack (spacing: 0) {
                    ForEach(0...8, id: \.self) { row in
                        HStack (spacing: 0) {
                            ForEach(0...8, id: \.self) { column in
                                Rectangle().fill(row % 2 == 0 ? rowOneColors[column] : rowTwoColors[column])
                            }
                        }
                    }
                }
                
                LinearGradient(colors: [ Color.windowTwo, Color.windowTwo.opacity(0.0) ], startPoint: .leading, endPoint: .trailing)
                
                Image("profile_photo_seven_illustration").resizable().scaledToFit()
                
            }.clipShape(RoundedRectangle(cornerRadius: 10.0)).padding(8)
            
            HStack {
                VStack {
                    Spacer()
                    Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 32, height: 32)
                }
                Spacer()
                VStack {
                    Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 24, height: 24)
                    Spacer()
                }
            }
            
        }.clipShape(RoundedRectangle(cornerRadius: 12.0)).aspectRatio(1.0, contentMode: .fit)
    }
}

#Preview {
    BackRemoverIllustrationView()
}
