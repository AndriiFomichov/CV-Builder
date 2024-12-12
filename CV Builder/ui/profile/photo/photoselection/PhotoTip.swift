//
//  PhotoTip.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import Foundation

class PhotoTip {
    
    var header: String
    var description: String
    var imageOne: String
    var imageTwo: String
    var orientation: Int
    
    init(header: String, description: String, imageOne: String, imageTwo: String, orientation: Int) {
        self.header = header
        self.description = description
        self.imageOne = imageOne
        self.imageTwo = imageTwo
        self.orientation = orientation
    }
    
    static func getDefault () -> PhotoTip {
        return PhotoTip(header: "Header", description: "description", imageOne: "profile_photo_one_illustration", imageTwo: "profile_photo_one_illustration", orientation: 1)
    }
}
