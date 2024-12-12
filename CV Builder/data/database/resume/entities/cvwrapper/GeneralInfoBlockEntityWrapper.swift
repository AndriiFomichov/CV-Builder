//
//  GeneralInfoBlockEntityWrapper.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 15.11.2024.
//

import Foundation

class GeneralInfoBlockEntityWrapper {
    
    var entity: GeneralInfoBlockEntity?
    
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
    
    init(entity: GeneralInfoBlockEntity?, name: String, location: String, jobTitle: String, photoId: Int, isAdded: Bool, position: Int, isMainBlock: Bool, page: Int, stylePhotoZoom: Float, stylePhotoFilterEnabled: Bool, stylePhotoStrokeAdded: Bool) {
        self.entity = entity
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
        self.entity = entity
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
    
    static func getDefault (position: Int, isMainBlock: Bool) -> GeneralInfoBlockEntityWrapper {
        return GeneralInfoBlockEntityWrapper(entity: nil, name: NSLocalizedString("dummy_name", comment: ""), location: NSLocalizedString("dummy_location", comment: ""), jobTitle: NSLocalizedString("dummy_job_title", comment: ""), photoId: -1, isAdded: true, position: position, isMainBlock: isMainBlock, page: 0, stylePhotoZoom: 1.0, stylePhotoFilterEnabled: false, stylePhotoStrokeAdded: false)
    }
}
