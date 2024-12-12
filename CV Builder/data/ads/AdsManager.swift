//
//  AdsManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 12.11.2024.
//

import Foundation
import GoogleMobileAds
import SwiftyUserDefaults

class AdsManager: NSObject, GADFullScreenContentDelegate {
    
    // TODO set relevant ads ids
    
//    static let ID_INTERSTITIAL_CONSTRUCTOR = "ca-app-pub-8325816867115193/5921601704"
//    static let ID_INTERSTITIAL_CONTENT = "ca-app-pub-8325816867115193/8834705502"
//    static let ID_INTERSTITIAL_EXPORT = "ca-app-pub-8325816867115193/2179101153"
    static let ID_INTERSTITIAL_CONSTRUCTOR = "ca-app-pub-3940256099942544/4411468910"
    static let ID_INTERSTITIAL_CONTENT = "ca-app-pub-3940256099942544/4411468910"
    static let ID_INTERSTITIAL_EXPORT = "ca-app-pub-3940256099942544/4411468910"
    
    private static var ifInitialized = false
//    private static var ifAllowed = false
    
    static func initAds () {
        GADMobileAds.sharedInstance().start(completionHandler: { success in
            ifInitialized = true
        })
    }
    
//    static func setAllowed (allowed: Bool) {
//        ifAllowed = allowed
//    }
    
    private var interstitial: GADInterstitialAd?
    private var interstitialAdShown = false
    private var completionHandler: (() -> Void)?
    
    func setCompletionHandler (completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
    }
    
    func loadAd (identifier: String) async {
        if AdsManager.ifInitialized && /*AdsManager.ifAllowed &&*/ Defaults.KEY_ACCOUNT_TYPE != 1 && interstitial == nil {
            do {
                print("Ad load started")
                interstitial = try await GADInterstitialAd.load(withAdUnitID: identifier, request: GADRequest())
                interstitial?.fullScreenContentDelegate = self
            } catch {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                interstitial = nil
                interstitialAdShown = false
            }
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        startCompletionAction()
        interstitial = nil
        interstitialAdShown = false
    }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
        interstitialAdShown = true
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        startCompletionAction()
        interstitial = nil
        interstitialAdShown = false
    }
    
    func showAd () {
        if let interstitial = interstitial, !interstitialAdShown, Defaults.KEY_ACCOUNT_TYPE != 1 {
            print("Ad should be shown")
            interstitial.present(fromRootViewController: nil)
        } else {
            startCompletionAction()
        }
    }
    
    private func startCompletionAction () {
        if let completionHandler = completionHandler {
            completionHandler()
        }
    }
}
