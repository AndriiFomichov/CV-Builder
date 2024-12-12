//
//  ConsentManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 12.11.2024.
//

import Foundation
import UserMessagingPlatform

class ConsentManager: ObservableObject {
    
    @Published var isChecked = false
    var consentShown = false
    
    private static var isMobileAdsStartCalled = false
    
    func checkConsentOnAppStart (viewController: UIViewController) {
        
        let parameters = UMPRequestParameters()
        let debugSettings = UMPDebugSettings()
        debugSettings.testDeviceIdentifiers = [ "F019AE0D-01AD-43C9-A8AE-457CE4085B16" ]
//        debugSettings.geography = .regulatedUSState
        parameters.debugSettings = debugSettings
        
        print("Called UMP ----------------- ----------")
        
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters) { requestConsentError in
            
            print("Called UMP ----------------- info updated")

            if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.required {
                
                self.consentShown = true
                
//                AnalyticsManager.saveEvent(event: Events.CONSENT_SHOWN)
                
                UMPConsentForm.loadAndPresentIfRequired(from: viewController) { loadAndPresentError in
                    
                    print("Called UMP ----------------- presented")
                    
                    self.isChecked = true
                    ConsentManager.startGoogleMobileAdsSDK()
                }
                
            } else {
                self.isChecked = true
                ConsentManager.startGoogleMobileAdsSDK()
            }
        }
        
        if UMPConsentInformation.sharedInstance.canRequestAds {
            ConsentManager.startGoogleMobileAdsSDK()
        }
    }
    
    private static func startGoogleMobileAdsSDK() {
        DispatchQueue.main.async {
            guard !self.isMobileAdsStartCalled else { return }

            self.isMobileAdsStartCalled = true

            AdsManager.initAds()
        }
    }
}

