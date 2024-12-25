//
//  SelectionMenuView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 19.12.2024.
//

import SwiftUI

struct SelectionMenuView<Content: View>: View {
    
    @Binding var currentText: String
    let options: [MenuItem]
    let selectionHandler: (_ item: MenuItem) -> Void
    let content: () -> Content
    
    var body: some View {
        Menu {
            ForEach(0..<options.count, id: \.self) { index in
                Button(action: {
                    selectionHandler(options[index])
                }) {
                    if options[index].icon.isEmpty {
                        Text(options[index].name).foregroundStyle(currentText == options[index].name ? .accent : options[index].color)
                    } else {
                        Label(options[index].name, systemImage: options[index].icon).foregroundStyle(currentText == options[index].name ? .accent : options[index].color)
                    }
                }
            }
        } label: {
            content()
        }
    }
}

class MenuItem {
    
    var id: Int
    var name: String
    var icon: String
    var color: Color
    
    init(id: Int, name: String, icon: String = "", color: Color = .text) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
    }
    
    static func getDefault () -> MenuItem {
        return MenuItem(id: 0, name: "Name", icon: "Gear", color: .accent)
    }
}
