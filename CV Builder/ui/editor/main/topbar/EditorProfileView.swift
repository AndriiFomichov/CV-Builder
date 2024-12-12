//
//  EditorProfileView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorProfileView: View {
    
    @Binding var name: String
    @Binding var description: String
    @Binding var photo: UIImage?
    let profileUpdateHandler: () -> Void
    
    @State var profileSheetShown = false
    
    var body: some View {
        HStack {
            Button (action: {
                profileSheetShown = true
            }) {
                HStack (spacing: 0) {
                    
                    ZStack {
                        
                        Image(systemName: "photo").font(.headline).foregroundStyle(.textAdditional)
                        
                        if let photo {
                            Image(uiImage: photo).centerCropped()
                        }
                        
                    }.clipShape(RoundedRectangle(cornerRadius: 12.0)).frame(width: 42, height: 42).background() {
                        RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo)
                    }.padding(8)
                    
                    VStack {
                        
                        Text(name.isEmpty ? NSLocalizedString("user_name", comment: "") : name).font(.headline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                        
                        Text(description).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                        
                    }.padding(.trailing, 4).padding(.vertical, 4)
                    
                    Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                    
                }.frame(maxWidth: .infinity).background() {
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                }.padding([.leading, .bottom, .trailing]).padding(.top, 2)
            }
        }.background() {
            UnevenRoundedRectangle(bottomLeadingRadius: 20.0, bottomTrailingRadius: 20.0).fill(Color.background)
        }.background() {
            Color.backgroundDark
        }.sheet(isPresented: $profileSheetShown, onDismiss: {
            profileUpdateHandler()
        }) {
            ProfileView().presentationDetents([.large])
        }
    }
}

#Preview {
    EditorProfileView(name: .constant("Name"), description: .constant("Description"), photo: .constant(nil), profileUpdateHandler: {})
}
