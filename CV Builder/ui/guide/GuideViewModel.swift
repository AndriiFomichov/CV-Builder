//
//  GuideViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation

class GuideViewModel: ObservableObject {
    
    @Published var header = ""
    @Published var description = ""
    @Published var icon = ""
    @Published var isIconSystem = true
    
    func updateData (guide: Int) {
        switch guide {
        case 0:
            header = NSLocalizedString("general_data_tip_header", comment: "")
            description = NSLocalizedString("general_data_tip_description", comment: "")
            icon = "person.crop.circle"
        case 1:
            header = NSLocalizedString("education_tip_header", comment: "")
            description = NSLocalizedString("education_tip_description", comment: "")
            icon = "graduationcap.fill"
        case 2:
            header = NSLocalizedString("work_tip_header", comment: "")
            description = NSLocalizedString("work_tip_description", comment: "")
            icon = "briefcase.fill"
        case 3:
            header = NSLocalizedString("job_specific_tip_header", comment: "")
            description = NSLocalizedString("job_specific_tip_description", comment: "")
            icon = "sparkle_colored_icon"
            isIconSystem = false
        case 4:
            header = NSLocalizedString("essential_info_tip_header", comment: "")
            description = NSLocalizedString("essential_info_tip_description", comment: "")
            icon = "person.crop.circle"
        case 5:
            header = NSLocalizedString("skills_tip_header", comment: "")
            description = NSLocalizedString("skills_tip_description", comment: "")
            icon = "lightbulb.max.fill"
        default:
            header = NSLocalizedString("general_data_tip_header", comment: "")
            description = NSLocalizedString("general_data_tip_description", comment: "")
            icon = "person.crop.circle"
        }
    }
}
