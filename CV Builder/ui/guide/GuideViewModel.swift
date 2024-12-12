//
//  GuideViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation

class GuideViewModel: ObservableObject {
    
    @Published var header = ""
    @Published var illustration = ""
    @Published var description = ""
    
    func updateData (guide: Int) {
        switch guide {
        case 0:
            header = NSLocalizedString("general_data_tip_header", comment: "")
            description = NSLocalizedString("general_data_tip_description", comment: "")
        case 1:
            header = NSLocalizedString("education_tip_header", comment: "")
            description = NSLocalizedString("education_tip_description", comment: "")
        case 2:
            header = NSLocalizedString("work_tip_header", comment: "")
            description = NSLocalizedString("work_tip_description", comment: "")
        case 3:
            header = NSLocalizedString("job_specific_tip_header", comment: "")
            description = NSLocalizedString("job_specific_tip_description", comment: "")
//            illustration = ""// add illustration
        case 4:
            header = NSLocalizedString("essential_info_tip_header", comment: "")
            description = NSLocalizedString("essential_info_tip_description", comment: "")
        case 5:
            header = NSLocalizedString("skills_tip_header", comment: "")
            description = NSLocalizedString("skills_tip_description", comment: "")
        default:
            header = NSLocalizedString("general_data_tip_header", comment: "")
            description = NSLocalizedString("general_data_tip_description", comment: "")
        }
    }
}
