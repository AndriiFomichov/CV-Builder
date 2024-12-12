//
//  Reference.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import Foundation

class Reference {
    
    var text: String
    var link: String?
    var icon: String
    
    init(text: String, link: String? = nil, icon: String = "person.crop.circle") {
        self.text = text
        self.link = link
        self.icon = icon
    }
    
    static func getDefault () -> Reference {
        return Reference(text: "Photo by me", link: "https://icons8.com/")
    }
}
