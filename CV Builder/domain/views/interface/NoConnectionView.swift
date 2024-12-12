//
//  NoConnectionView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import SwiftUI

struct NoConnectionView: View {
    
    @State private var animate = false
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: "wifi.slash").font(.headline).foregroundStyle(.error).symbolEffect(.bounce.down, value: animate)
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo)
            }.padding(8)
            
            VStack {
                Text(NSLocalizedString("no_connection_header", comment: "")).font(.title3).bold().foregroundStyle(.error).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                
                Text(NSLocalizedString("no_connection_description", comment: "")).font(.caption).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3)
                
            }.padding(.trailing, 4).padding(.vertical, 4)
            
            
        }.frame(maxWidth: .infinity).background() {
            RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
        }.onAppear() {
            animate = true
        }
    }
}

#Preview {
    NoConnectionView()
}
