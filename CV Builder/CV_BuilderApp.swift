//
//  CV_BuilderApp.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 09.11.2024.
//

import SwiftUI
import SwiftData

@main
struct CV_BuilderApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var purchaseManager = PurchaseManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ProfileEntity.self, SocialMediaEntity.self, SkillEntity.self, EducationEntity.self, WorkEntity.self, CertificateEntity.self, LanguageEntity.self, ReferenceEntity.self, InterestEntity.self, CVEntity.self, CoverLetterEntity.self, GeneralInfoBlockEntity.self, ProfileDescriptionBlockEntity.self, ContactInfoBlockEntity.self, SocialMediaBlockEntity.self, QRCodesBlockEntity.self, EducationBlockEntity.self, WorkBlockEntity.self, LanguagesBlockEntity.self, SkillsBlockEntity.self, InterestsBlockEntity.self, CertificatesBlockEntity.self, ReferencesBlockEntity.self, SocialMediaBlockItemEntity.self, LanguageBlockItemEntity.self, EducationBlockItemEntity.self, WorkBlockItemEntity.self, SkillBlockItemEntity.self, InterestBlockItemEntity.self, CertificateBlockItemEntity.self, ReferenceBlockItemEntity.self, ImageEntity.self, QRCodeEntity.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let c = try ModelContainer(for: schema, configurations: [modelConfiguration])
            AppGlobalData.initContext(sharedModelContainer: c)
            return c
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView().modelContainer(sharedModelContainer).environmentObject(purchaseManager)
        }
    }
    
    struct FormViewControllerRepresentable: UIViewControllerRepresentable {
        let viewController = UIViewController()

        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
