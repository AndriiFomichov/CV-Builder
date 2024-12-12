//
//  AppGlobalData.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.11.2024.
//

import Foundation
import SwiftData

class AppGlobalData {
    
    static var sharedModelContainer: ModelContainer?
    static var context: ModelContext?
    
    static func initContext (sharedModelContainer: ModelContainer) {
        self.sharedModelContainer = sharedModelContainer
        self.context = ModelContext(sharedModelContainer)
    }
}
