//
//  GeneralInfoBlockEntity.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

@Model
class GeneralInfoBlockEntity {
    
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var name: String
    var location: String
    var jobTitle: String
    var photoId: Int
    var isAdded: Bool
    var position: Int
    var isMainBlock: Bool
    var page: Int
    
    var stylePhotoZoom: Float
    var stylePhotoFilterEnabled: Bool
    var stylePhotoStrokeAdded: Bool
    
    init(name: String, location: String, jobTitle: String, photoId: Int, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, stylePhotoZoom: Float, stylePhotoFilterEnabled: Bool, stylePhotoStrokeAdded: Bool) {
        self.name = name
        self.location = location
        self.jobTitle = jobTitle
        self.photoId = photoId
        self.isAdded = isAdded
        self.position = position
        self.isMainBlock = isMainBlock
        self.page = page
        self.stylePhotoZoom = stylePhotoZoom
        self.stylePhotoFilterEnabled = stylePhotoFilterEnabled
        self.stylePhotoStrokeAdded = stylePhotoStrokeAdded
    }
    
    init(entity: GeneralInfoBlockEntity) {
        self.name = entity.name
        self.location = entity.location
        self.jobTitle = entity.jobTitle
        self.photoId = entity.photoId
        self.isAdded = entity.isAdded
        self.position = entity.position
        self.isMainBlock = entity.isMainBlock
        self.page = entity.page
        self.stylePhotoZoom = entity.stylePhotoZoom
        self.stylePhotoFilterEnabled = entity.stylePhotoFilterEnabled
        self.stylePhotoStrokeAdded = entity.stylePhotoStrokeAdded
    }
}
