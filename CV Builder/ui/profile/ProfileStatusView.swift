//
//  ProfileStatusView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct ProfileStatusView: View {
    
    @Binding var progress: CGFloat
    let saveClickHandler: () -> Void
    
    @State var progressState: CGFloat = 0.0
    
    var body: some View {
        HStack (spacing: 0) {
            
            CircleProgressView(progress: progressState, backColor: .windowTwo, font: .subheadline).frame(maxHeight: 64).padding()
            
            VStack (spacing: 0) {
                
                Text(getHeader()).font(.title3).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                
                Text(getDescription()).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.top, 8).lineLimit(3)
                
            }.padding(.vertical)
            
            SmallButtonView(isSelected: .constant(true), text: NSLocalizedString("save", comment: ""), clickHandler: saveClickHandler).padding(8)
            
        }.background() {
            RoundedRectangle(cornerRadius: 16.0).fill(Color.window).shadow(color: Color.black.opacity(0.05), radius: 6)
        }.onAppear() {
            withAnimation {
                progressState = progress
            }
        }.onChange(of: progress) {
            withAnimation {
                progressState = progress
            }
        }
    }
    
    private func getHeader () -> String {
        if progress == 1.0 {
            return NSLocalizedString("complete_profile_header", comment: "")
        } else {
            return NSLocalizedString("incomplete_profile_header", comment: "")
        }
    }
    
    private func getDescription () -> String {
        if progress == 1.0 {
            return NSLocalizedString("complete_profile_description", comment: "")
        } else {
            return NSLocalizedString("incomplete_profile_description", comment: "")
        }
    }
}

#Preview {
    ProfileStatusView(progress: .constant(0.2), saveClickHandler: {})
}
