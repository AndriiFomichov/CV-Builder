//
//  EmptyInputListView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

struct EmptyInputListView: View {
    
    let header: String
    let description: String
    
    var body: some View {
        ZStack {
            
            VStack {
                Text(header).font(.title).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                
                if !description.isEmpty {
                    Text(description).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).padding(.top, 1)
                }
            }.padding()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
            ZStack (alignment: .bottomLeading) {
                SwiftUI.Image("small_line_two_illustration").renderingMode(.template).resizable().scaledToFit().foregroundStyle(Color.backgroundDark)
                
                RoundedRectangle(cornerRadius: 16.0).stroke(.window, style: StrokeStyle(lineWidth: 3))
            }
        }.clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}

#Preview {
    EmptyInputListView(header: "Skills", description: "Description")
}
