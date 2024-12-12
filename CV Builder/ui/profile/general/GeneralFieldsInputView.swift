//
//  GeneralFieldsInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct GeneralFieldsInputView: View {
    
    @Binding var name: String
    @Binding var location: String
    @Binding var job: String
    @Binding var description: String
    
    var allFields = true
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                
                Text(NSLocalizedString("field_name", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                
                TextInputView(text: $name, icon: "person.crop.circle", hint: NSLocalizedString("field_name_hint", comment: "")).padding(.bottom)
                
                if allFields {
                    Text(NSLocalizedString("field_location", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    TextInputView(text: $location, icon: "paperplane.fill", hint: NSLocalizedString("field_location_hint", comment: "")).padding(.bottom)
                }
                
                Text(NSLocalizedString("field_job_title", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                
                TextInputView(text: $job, icon: "briefcase.fill", hint: NSLocalizedString("field_job_title_hint", comment: "")).padding(.bottom)
                
                if allFields {
                    Text(NSLocalizedString("field_profile_description", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    TextInputView(text: $description, icon: "text.document.fill", hint: NSLocalizedString("field_profile_description_hint", comment: ""))
                    
                    Text(NSLocalizedString("field_profile_description_tip", comment: "")).font(.subheadline).foregroundStyle(Color.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.bottom)
                }
                
            }.padding()
        }
    }
}

#Preview {
    GeneralFieldsInputView(name: .constant(""), location: .constant(""), job: .constant(""), description: .constant(""))
}
