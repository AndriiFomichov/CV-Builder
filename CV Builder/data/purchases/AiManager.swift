//
//  AiManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import Foundation
import SwiftyUserDefaults

class AiManager {
    
    // on app launch and after subscription purchase
    static func updateAttempts () {
        let isPremium = Defaults.KEY_ACCOUNT_TYPE != 0
        if isPremium {
            let lastUpdateTime = Defaults.KEY_AI_ATTEMPTS_LAST_UPDATE
            let currentDate = Date()
            if lastUpdateTime != -1 {
                let lastUpdatedDate = Date(timeIntervalSince1970: TimeInterval(lastUpdateTime))
                
                let differenceInHours = Int(currentDate.timeIntervalSince(lastUpdatedDate)) / 3600
                print("Difference in hours: " + String(differenceInHours))
                
                if differenceInHours >= 24 {
                    Defaults.KEY_CV_ATTEMPTS = 30
                    Defaults.KEY_AI_TEXT_ATTEMPTS = 200
                    Defaults.KEY_AI_ASSISTANT_ATTEMPTS = 20
                    Defaults.KEY_AI_ATTEMPTS_LAST_UPDATE = Int(currentDate.timeIntervalSince1970)
                }
                
            } else {
                Defaults.KEY_CV_ATTEMPTS = 30
                Defaults.KEY_AI_TEXT_ATTEMPTS = 200
                Defaults.KEY_AI_ASSISTANT_ATTEMPTS = 20
                Defaults.KEY_AI_ATTEMPTS_LAST_UPDATE = Int(currentDate.timeIntervalSince1970)
            }
        }
    }
    
    // in ai screens
    static func getCurrentAttempts () -> Int {
        return Defaults.KEY_CV_ATTEMPTS
    }
    
    static func getCurrentBackRemoverAttempts () -> Int {
        return Defaults.KEY_BACK_REMOVER_ATTEMPTS
    }
    
    static func getCurrentQRAttempts () -> Int {
        return Defaults.KEY_QR_ATTEMPTS
    }
    
    static func getExportAttempts () -> Int {
        return Defaults.KEY_EXPORT_ATTEMPTS
    }
    
    static func getAiTextAttempts () -> Int {
        return Defaults.KEY_AI_TEXT_ATTEMPTS
    }
    
    static func getAiAssistantAttempts () -> Int {
        return Defaults.KEY_AI_ASSISTANT_ATTEMPTS
    }
    
    // when a generating prompt
    static func useAttempt () {
        Defaults.KEY_CV_ATTEMPTS -= 1
    }
    
    static func useBackRemoverAttempt () {
        Defaults.KEY_BACK_REMOVER_ATTEMPTS -= 1
    }
    
    static func useQRAttempt () {
        Defaults.KEY_QR_ATTEMPTS -= 1
    }
    
    static func useExportAttempt () {
        Defaults.KEY_EXPORT_ATTEMPTS -= 1
    }
    
    static func useAiTextAttempt () {
        Defaults.KEY_AI_TEXT_ATTEMPTS -= 1
    }
    
    static func useAiAssistantAttempt () {
        Defaults.KEY_AI_ASSISTANT_ATTEMPTS -= 1
    }
}
