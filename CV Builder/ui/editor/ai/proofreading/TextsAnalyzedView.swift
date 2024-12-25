//
//  TextsAnalyzedView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct TextsAnalyzedView: View {
    
    let icon: String
    let text: String
    let number: Int
    let color: Color
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: icon).font(.headline).foregroundStyle(color)
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 32.0).fill(.window)
            }.padding(8)
            
            VStack (spacing: 0) {
                Text(text).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                
                Text(String(number)).font(.title3).bold().foregroundStyle(color).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                
            }.padding([.top, .trailing, .bottom], 8)
            
        }.background() {
            RoundedRectangle(cornerRadius: 32.0).fill(Color.windowColored)
        }
    }
}

#Preview {
    TextsAnalyzedView(icon: "gear", text: "Text", number: 55, color: .success)
}
