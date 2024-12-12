//
//  AppDelegate.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.11.2024.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics
import FirebaseMessaging
import SwiftyUserDefaults

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        AnalyticsManager.initMixpanel()
        
//        Defaults.KEY_ACCOUNT_TYPE = 1
        
        return true
    }
    
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    static func ifNotificationsRequestNeeded (completionHandler: @escaping (_ isNeeded: Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
            completionHandler(settings.authorizationStatus == .notDetermined)
        })
    }
    
    static func requestNotifications (application: UIApplication, requestedHandler: (() -> Void)? = nil) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
            if let requestedHandler = requestedHandler {
                requestedHandler()
            }
        })
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)

        return UIBackgroundFetchResult.newData
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)

        return [[.alert, .sound]]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
            
        print(userInfo)
    }
}

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict)
    }
}
