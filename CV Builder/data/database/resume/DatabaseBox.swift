//
//  DatabaseBox.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftData

class DatabaseBox {
    
    static func saveContext () {
        DispatchQueue.main.async {
            if let context = AppGlobalData.context {
                do {
                    try context.save()
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    // SAVE -------------------------------------------------
    
    // profile
    static func saveEntity (item: ProfileEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: SocialMediaEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: SkillEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: EducationEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: WorkEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: CertificateEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: InterestEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: LanguageEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: ReferenceEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    // cv
    
    static func saveEntity (item: CVEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: GeneralInfoBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: ProfileDescriptionBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: ContactInfoBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: SocialMediaBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: QRCodesBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: EducationBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: WorkBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: LanguagesBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: SkillsBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: InterestsBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: CertificatesBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: ReferencesBlockEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: CoverLetterEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    // cv items
    
    static func saveEntity (item: SocialMediaBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: LanguageBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: EducationBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: WorkBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: SkillBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: InterestBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: CertificateBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: ReferenceBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    // media
    
    static func saveEntity (item: ImageEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func saveEntity (item: QRCodeEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    
    // DELETE -------------------------------------------------
    
    // profile
    static func deleteEntity (item: ProfileEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: SocialMediaEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: SkillEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: EducationEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: WorkEntity) {
        if let context = AppGlobalData.context {
            context.insert(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: CertificateEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: LanguageEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: ReferenceEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    // cv
    
    static func deleteEntity (item: CVEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: GeneralInfoBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: ProfileDescriptionBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: ContactInfoBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: SocialMediaBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: QRCodesBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: EducationBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: WorkBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: LanguagesBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: SkillsBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: InterestsBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: CertificatesBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: ReferencesBlockEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    // cv items
    
    static func deleteEntity (item: SocialMediaBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: LanguageBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: EducationBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: WorkBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: SkillBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: InterestBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: CertificateBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: ReferenceBlockItemEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    // media
    
    static func deleteEntity (item: ImageEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    static func deleteEntity (item: QRCodeEntity) {
        if let context = AppGlobalData.context {
            context.delete(item)
            DatabaseBox.saveContext()
        }
    }
    
    
    // GET -------------------------------------------------
    
    static func getCVsIdsOnly () -> [CVEntity] {
        var list:[CVEntity] = []
        if let context = AppGlobalData.context {
            
            var settings = FetchDescriptor<CVEntity>(predicate: #Predicate { entity in true }, sortBy: [.init(\.lastModified, order: .reverse)])
            settings.propertiesToFetch = [\.id]
            
            do {
                list = try context.fetch(settings)
            } catch {
                print("Error")
            }
        }
        return list
    }
    
    static func getCVs () -> [CVEntity] {
        var list:[CVEntity] = []
        if let context = AppGlobalData.context {
            
            let settings = FetchDescriptor<CVEntity>(predicate: #Predicate { entity in true }, sortBy: [.init(\.lastModified, order: .reverse)])
            
            do {
                list = try context.fetch(settings)
            } catch {
                print("Error")
            }
        }
        return list
    }
    
    static func getCV (id: String) -> CVEntity? {
        if let context = AppGlobalData.context {
            
            let settings = FetchDescriptor<CVEntity>(predicate: #Predicate { $0.id == id })
            
            do {
                let list = try context.fetch(settings)
                if list.count > 0 {
                    return list[0]
                }
            } catch {
                print("Error")
            }
        }
        return nil
    }
    
    static func getProfile () -> ProfileEntity? {
        if let context = AppGlobalData.context {
            
            var settings = FetchDescriptor<ProfileEntity>()
            settings.fetchLimit = 1
            
            do {
                let list = try context.fetch(settings)
                if list.count > 0 {
                    return list[0]
                }
            } catch {
                print("Error")
            }
        }
        return nil
    }
    
    static func getProfile (id: String) -> ProfileEntity? {
        if let context = AppGlobalData.context {
            
            let settings = FetchDescriptor<ProfileEntity>(predicate: #Predicate { $0.id == id })
            
            do {
                let list = try context.fetch(settings)
                if list.count > 0 {
                    return list[0]
                }
            } catch {
                print("Error")
            }
        }
        return nil
    }
    
    static func getImage (id: Int) -> ImageEntity? {
        if let context = AppGlobalData.context {
            
            let settings = FetchDescriptor<ImageEntity>(predicate: #Predicate { $0.realId == id })
            
            do {
                let list = try context.fetch(settings)
                if list.count > 0 {
                    return list[0]
                }
            } catch {
                print("Error")
            }
        }
        return nil
    }
    
    static func getImagesWithoutPreview (limit: Int = -1) -> [ImageEntity] {
        var list:[ImageEntity] = []
        if let context = AppGlobalData.context {
            var settings = FetchDescriptor<ImageEntity>()
            settings.propertiesToFetch = [\.id, \.realId, \.width, \.height]
            if limit != -1 {
                settings.fetchLimit = limit
            }
            
            do {
                list = try context.fetch(settings)
            } catch {
                print("Error")
            }
        }
        return list
    }
    
    static func getQRCode (id: Int) -> QRCodeEntity? {
        if let context = AppGlobalData.context {
            
            let settings = FetchDescriptor<QRCodeEntity>(predicate: #Predicate { $0.realId == id })
            
            do {
                let list = try context.fetch(settings)
                if list.count > 0 {
                    return list[0]
                }
            } catch {
                print("Error")
            }
        }
        return nil
    }
    
    static func getQRCodesWithoutPreview (limit: Int = -1) -> [QRCodeEntity] {
        var list:[QRCodeEntity] = []
        if let context = AppGlobalData.context {
            var settings = FetchDescriptor<QRCodeEntity>()
            settings.propertiesToFetch = [\.id, \.realId, \.width, \.height]
            if limit != -1 {
                settings.fetchLimit = limit
            }
            
            do {
                list = try context.fetch(settings)
            } catch {
                print("Error")
            }
        }
        return list
    }
}
