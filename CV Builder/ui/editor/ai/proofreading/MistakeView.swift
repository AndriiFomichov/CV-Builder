//
//  MistakeView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 05.12.2024.
//

import SwiftUI

struct MistakeView: View {
    
    let mistake: Mistake
    
    @State var expanded = false
    
    var body: some View {
        VStack (spacing: 0) {
            
            HStack (spacing: 0) {
                
                Text(mistake.blockName).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1).padding(.trailing, 4)
                
                Button (action: {
                    withAnimation {
                        expanded.toggle()
                    }
                }) {
                    ArrowExpandView(optionsShown: $expanded)
                }
                
            }.padding(8)
            
            ScrollView (showsIndicators: false) {
                ZStack {
                    
                    Spacer().containerRelativeFrame([.vertical])
                    
                    Text(formatString(text: mistake.textNew)).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(8)
                    
                }
            }.frame(height: expanded ? 120 : 48).background() {
                RoundedRectangle(cornerRadius: 12.0).fill(Color.windowTwo)
            }.padding([.leading, .bottom, .trailing], 8)
            
        }.background() {
            RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
        }
    }
    
    private func formatString (text: String) -> AttributedString {
        var string = AttributedString()
        
        for index in 0..<text.count {
            var characterString = AttributedString(String(text[index]))
            for colorIndex in mistake.textNewUpdateIndexs {
                if index == colorIndex {
                    characterString.foregroundColor = Color.success
                }
            }
            string += characterString
        }
        
        return string
    }
}

#Preview {
    MistakeView(mistake: Mistake.getDefault())
}
