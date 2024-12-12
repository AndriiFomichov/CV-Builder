//
//  UserDefaultsData.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 12.11.2024.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    
    // Standard
    var KEY_VISITS: DefaultsKey<Int> { .init("visits", defaultValue: 0) }
    var KEY_ACCOUNT_TYPE: DefaultsKey<Int> { .init("account_type", defaultValue: 0) }
    var KEY_REVIEWED: DefaultsKey<Bool> { .init("reviewed", defaultValue: false) }
    var KEY_CONSENT_SHOWN: DefaultsKey<Bool> { .init("consent_shown", defaultValue: false) }
    var KEY_APP_NOTIFIED: DefaultsKey<Bool> { .init("app_update_notified", defaultValue: false) }
    
    // Guides
    var KEY_GUIDE_BACK_REMOVER: DefaultsKey<Bool> { .init("guide_back_remover", defaultValue: false) }
    
    // Ai attempts
    var KEY_AI_ATTEMPTS_LAST_UPDATE: DefaultsKey<Int> { .init("ai_attempts_last_update", defaultValue: -1) }
    var KEY_BACK_REMOVER_ATTEMPTS: DefaultsKey<Int> { .init("ai_back_remover_attempts", defaultValue: 3) }
    var KEY_CV_ATTEMPTS: DefaultsKey<Int> { .init("ai_cv_attempts", defaultValue: 3) }
    var KEY_QR_ATTEMPTS: DefaultsKey<Int> { .init("qr_generator_attempts", defaultValue: 1) }
    var KEY_EXPORT_ATTEMPTS: DefaultsKey<Int> { .init("export_attempts", defaultValue: 3) }
    var KEY_AI_TEXT_ATTEMPTS: DefaultsKey<Int> { .init("ai_text_attempts", defaultValue: 10) }
    var KEY_AI_ASSISTANT_ATTEMPTS: DefaultsKey<Int> { .init("ai_assistant_attempts", defaultValue: 2) }
    
    
}
