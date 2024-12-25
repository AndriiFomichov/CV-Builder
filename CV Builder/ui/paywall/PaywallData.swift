//
//  PaywallData.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import Foundation

class PaywallData {
    
    static func getPaywallHeader (benefitsId: Int, name: String) -> String {
        if name.isEmpty {
            return getHeaderWithoutName(benefitsId: benefitsId)
        } else {
            return getHeaderWithName(benefitsId: benefitsId, name: name)
        }
    }
    
    private static func getHeaderWithName (benefitsId: Int, name: String) -> String {
        switch benefitsId {
        case 0:
            return name + NSLocalizedString("paywall_header_ai_with_name", comment: "")
            
        case 1:
            return name + NSLocalizedString("paywall_header_back_remover_with_name", comment: "")
        
        case 2:
            return name + NSLocalizedString("paywall_header_export_with_name", comment: "")
        
        case 3:
            return name + NSLocalizedString("paywall_header_qr_codes_with_name", comment: "")
            
        default:
            return name + NSLocalizedString("paywall_header_ai_with_name", comment: "")
        }
    }
    
    private static func getHeaderWithoutName (benefitsId: Int) -> String {
        switch benefitsId {
        case 0:
            return NSLocalizedString("paywall_header_ai", comment: "")
            
        case 1:
            return NSLocalizedString("paywall_header_back_remover", comment: "")
        
        case 2:
            return NSLocalizedString("paywall_header_export", comment: "")
        
        case 3:
            return NSLocalizedString("paywall_header_qr_codes", comment: "")
            
        default:
            return NSLocalizedString("paywall_header_ai", comment: "")
        }
    }
    
    static func getDescription (benefitsId: Int) -> String {
        switch benefitsId {
        case 0:
            return NSLocalizedString("paywall_description_ai", comment: "")
            
        case 1:
            return NSLocalizedString("paywall_description_back_remover", comment: "")
        
        case 2:
            return NSLocalizedString("paywall_description_export", comment: "")
        
        case 3:
            return NSLocalizedString("paywall_description_qr_codes", comment: "")
            
        default:
            return NSLocalizedString("paywall_description_ai", comment: "")
        }
    }
}
