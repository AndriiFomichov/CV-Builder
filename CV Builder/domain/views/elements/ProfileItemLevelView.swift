//
//  ProfileItemLevelView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import SwiftUI

struct ProfileItemLevelView: View {
    
    let level: Int
    let options: [MenuItem]
    let changeHandler: (_ level: Int) -> Void
    
    var levels = 5
    
    @State var isSelected = false
    @State var icon = ""
    @State var name = ""
    @State var optionsShown = false
    
    var body: some View {
        SelectionMenuView(currentText: $name, options: options, selectionHandler: { item in
            changeHandler(item.id)
            withAnimation {
                updateCurrentIcon(level: item.id)
            }
        }) {
            HStack {
                HStack {
                    
                    if !icon.isEmpty {
                        Image(systemName: icon).font(.subheadline).foregroundStyle(isSelected ? .accent : .text).contentTransition(.symbolEffect(.replace))
                    }
                    
                    Text(name).font(.subheadline).foregroundStyle(isSelected ? .accent : .text)
                    
                    Image(systemName: "chevron.down").font(.subheadline).foregroundStyle(isSelected ? .accent : .text).rotationEffect(optionsShown ? Angle(degrees: 180) : Angle(degrees: 0))
                    
                }.padding(8).padding(.horizontal, 4).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(Color.windowTwo)
                }
                Spacer()
            }
        }.onAppear() {
            updateCurrentIcon(level: level)
        }
    }
    
    private func updateCurrentIcon (level: Int) {
        if level >= 0 && level < options.count {
            isSelected = true
            name = options[level].name
            icon = options[level].icon
        } else {
            isSelected = false
            name = NSLocalizedString("select_level", comment: "")
            icon = ""
        }
    }
}

#Preview {
    ProfileItemLevelView(level: -1, options: [ MenuItem.getDefault(), MenuItem.getDefault() ], changeHandler: { l in })
}
