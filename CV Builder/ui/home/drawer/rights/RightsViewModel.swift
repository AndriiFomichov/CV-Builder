//
//  RightsViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import Foundation

class RightsViewModel: ObservableObject {
    
    @Published var images: [Reference] = []
    
    func updateData () {
        updateImageReferences()
    }
    
    private func updateImageReferences () {
        var list: [Reference] = []
        
        list.append(Reference(text: "Image by cookie_studio on Freepik"))
        list.append(Reference(text: "Image by diana.grytsku on Freepik"))
        list.append(Reference(text: "Image by freepik on Freepik"))
        list.append(Reference(text: "Image by kroshka__nastya on Freepik"))
        
        images = list
    }
}
