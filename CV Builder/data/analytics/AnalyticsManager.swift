//
//  AnalyticsManager.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.11.2024.
//

import Foundation
import Mixpanel
import FirebaseAnalytics

class AnalyticsManager {
    
    static func initMixpanel () {
        Mixpanel.initialize(token: "96a24651b041d6ac26e863b37da1abdd", trackAutomaticEvents: false)
    }
    
    static func saveEvent (event: Events, characteristics: [String] = [], values: [String] = []) {
        log(event: event, characteristics: characteristics, values: values)
    }
    
    static func identifyUser (id: String = UUID().uuidString) {
        Mixpanel.mainInstance().identify(distinctId: id)
    }
    
    static func saveUserProperty (propertyName: String, value: String) {
        Mixpanel.mainInstance().people.set(properties: [ propertyName : value ])
    }
    
    private static func log (event: Events, characteristics: [String], values: [String]) {
//        logEventFirebase(event: event, characteristics: characteristics, values: values)
//        logEventMixpanel(event: event, characteristics: characteristics, values: values)
    }
    
    private static func logEventFirebase (event: Events, characteristics: [String], values: [String]) {
        var params: [String:Any] = [:]
        if characteristics.count > 0 && values.count > 0 && characteristics.count == values.count {
            for i in 0...characteristics.count - 1 {
                params[characteristics[i]] = values[i]
            }
        }
        Analytics.logEvent(event.rawValue, parameters: params)
    }
    
    private static func logEventMixpanel (event: Events, characteristics: [String], values: [String]) {
        var params: [String:String] = [:]
        if characteristics.count > 0 && values.count > 0 && characteristics.count == values.count {
            for i in 0...characteristics.count - 1 {
                params[characteristics[i]] = values[i]
            }
        }
        Mixpanel.mainInstance().track(event: event.rawValue, properties: params)
    }
}
