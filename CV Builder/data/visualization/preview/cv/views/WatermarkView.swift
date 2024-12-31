//
//  WatermarkView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.12.2024.
//

import SwiftUI

struct WatermarkView: View {
    
    let added: Bool
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            if added {
                Color.clear
                Image("watermark_illustration").resizable().scaledToFit().frame(width: 270).opacity(0.28)
            }
        }
    }
}

#Preview {
    WatermarkView(added: true)
}
