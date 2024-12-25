//
//  MainButtonView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct MainButtonView: View {
    
    @Binding var isSelected: Bool
    var text: String
    var icon: String?
    var isIconSystem = true
    var clickHandler: () -> Void
    @Binding var progressVisible: Bool
    
    @State var selected = false
    @State var progressBarVisible = false
    
    init(isSelected: Binding<Bool>, progressVisible: Binding<Bool> = .constant(false), text: String, icon: String? = nil, isIconSystem: Bool = true, clickHandler: @escaping () -> Void) {
        self.selected = isSelected.wrappedValue
        self._isSelected = isSelected
        self._progressVisible = progressVisible
        self.text = text
        self.icon = icon
        self.isIconSystem = isIconSystem
        self.clickHandler = clickHandler
    }
    
    var body: some View {
        Button (action: {
            clickHandler()
        }) {
            HStack {
                Text(text).font(.headline).bold().foregroundStyle(Color.white).lineLimit(1)
                
                if let icon = icon, !icon.isEmpty {
                    if isIconSystem {
                        Image(systemName: icon).font(.headline).foregroundStyle(Color.white).padding(.leading, 4)
                    } else {
                        Image(icon).renderingMode(.template).resizable().scaledToFit().foregroundStyle(Color.white).frame(width: 24, height: 24).padding(.leading, 2)
                    }
                }
                
                if progressBarVisible {
                    ProgressView().tint(Color.white).padding(.leading, 4)
                }
                
            }.frame(maxWidth: .infinity).padding().background() {
                RoundedRectangle(cornerRadius: 32.0).fill(LinearGradient(colors: selected ? [ Color.accentLight, Color.accent ] : [Color.accentLightest], startPoint: .topLeading, endPoint: .bottomTrailing))
            }.padding(.horizontal)
            
        }.onChange(of: isSelected) {
            if selected != isSelected {
                withAnimation {
                    selected = isSelected
                }
            }
        }.onChange(of: progressVisible) {
            if progressBarVisible != progressVisible {
                withAnimation {
                    progressBarVisible = progressVisible
                }
            }
        }
    }
}

#Preview {
    MainButtonView(isSelected: .constant(true), text: "Continue", icon: "lock.fill", clickHandler: {})
}
