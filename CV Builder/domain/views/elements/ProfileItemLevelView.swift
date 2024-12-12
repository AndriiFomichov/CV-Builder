//
//  ProfileItemLevelView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import SwiftUI

struct ProfileItemLevelView: View {
    
    @Binding var level: Int
    let changeHandler: (_ level: Int) -> Void
    
    var levels = 5
    
    @State var levelState = -1
    
    var body: some View {
        HStack {
            Text(NSLocalizedString("level", comment: "")).font(.subheadline).foregroundStyle(.textAdditional)
            
            ForEach(0..<levels, id:\.self) { level in
                Button (action: {
                    self.level = level
                    changeHandler(level)
                }) {
                    Circle().fill(level <= levelState ? Color.accentLight : Color.windowTwo).frame(width: 18, height: 18)
                }
            }
            
            Spacer()
        }.onAppear() {
            levelState = level
        }.onChange(of: level) {
            withAnimation {
                levelState = level
            }
        }
    }
}

#Preview {
    ProfileItemLevelView(level: .constant(-1), changeHandler: { l in })
}
