//
//  EmptyInputListView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

struct EmptyInputListView: View {
    
    let icon: String
    let header: String
    let description: String
    
    let buttonOneName: String
    let buttonOneIcon: String
    let buttonOneHandler: () -> Void
    
    var buttonTwoName: String? = nil
    var buttonTwoIcon: String? = nil
    var buttonTwoHandler: (() -> Void)? = nil
    
    @State var animating = false
    
    var body: some View {
        ZStack {
            
            VStack (spacing: 12) {
                
                Spacer()
                
                ZStack {
                    
                    Image(systemName: icon).font(.title2).foregroundStyle(.accent).symbolEffect(.bounce, value: animating).onAppear() {
                        withAnimation {
                            animating = true
                        }
                    }
                    
                }.frame(width: 54, height: 54).background() {
                    RoundedRectangle(cornerRadius: 32.0).fill(.window)
                }
                
                Text(header).font(.title).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                
                if !description.isEmpty {
                    Text(description).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)
                }
                
                Spacer()
                
                HStack (spacing: 8) {
                    ActionButtonView(icon: buttonOneIcon, text: buttonOneName, clickHandler: buttonOneHandler, addArrow: true)
                    
                    if let buttonTwoName, let buttonTwoIcon, let buttonTwoHandler {
                        ActionButtonView(icon: buttonTwoIcon, text: buttonTwoName, clickHandler: buttonTwoHandler, addArrow: true)
                    }
                }
                
            }.padding()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
            ColoredBackgroundLargeView()
        }.clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}

#Preview {
    EmptyInputListView(icon: "gear", header: "Skills", description: "Description", buttonOneName: "Button", buttonOneIcon: "gear", buttonOneHandler: {})
}
