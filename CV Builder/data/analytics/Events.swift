//
//  Events.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 11.11.2024.
//

import Foundation

enum Events: String {
    
    // Onboard
    case ONBOARD_OPENED = "onboard_opened"
    case ONBOARD_STYLES_OPENED = "onboard_styles_opened"
    case ONBOARD_GENERAL_OPENED = "onboard_general_opened"
    case ONBOARD_PHOTO_OPENED = "onboard_photo_opened"
    case ONBOARD_EDUCATION_OPENED = "onboard_education_opened"
    case ONBOARD_WORK_OPENED = "onboard_work_opened"
    case ONBOARD_TARGET_OPENED = "onboard_target_opened"
    case ONBOARD_VISUALIZATION_OPENED = "onboard_visualization_opened"
    
    // Constructor
    case CONSTRUCTOR_STYLES_OPENED = "constructor_styles_opened"
    case CONSTRUCTOR_TARGET_OPENED = "constructor_target_opened"
    case CONSTRUCTOR_VISUALIZATION_OPENED = "constructor_visualization_opened"
    
    // Home
    case SIDE_MENU = "side_menu_opened"
    case CV_ACTIONS = "home_cv_actions"
    case CV_DELETED = "home_cv_deleted"
    case CV_DUPLICTED = "home_cv_duplicated"
    
    // Export
    case SHARE_OPENED = "share_opened"
    case SHARE_PARAMS_OPENED = "share_params_opened"
    case SHARE_EXPORT_OPENED = "share_export_opened"
    case EXPORTED_PDF_VECTOR = "exported_pdf_vector"
    case EXPORTED_PDF = "exported_pdf"
    case EXPORTED_JPEG = "exported_jpeg"
    case EXPORTED_PNG = "exported_png"
    
    
    
    
    
    
    // AI
    case AI_REQUEST = "ai_request"
    
    case AI_CV_LIMIT = "ai_cv_limit_reached"
    case AI_TEXT_LIMIT = "ai_text_limit_reached"
    case AI_ASSISTANT_LIMIT = "ai_assistant_limit_reached"
    
    // Background remover
    case AI_BACK_REMOVER_OPENED = "ai_back_remover_opened"
    case AI_BACK_REMOVER_APPLIED = "ai_back_remover_applied"
    case AI_BACK_REMOVER_SAVED = "ai_back_remover_saved"
    
}
