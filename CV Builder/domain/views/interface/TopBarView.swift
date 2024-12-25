//
//  TopBarView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 13.11.2024.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var header: String
    @Binding var description: String
    @Binding var isCollapsed: Bool
    
    var icon: String = ""
    var isIconSystem: Bool = true
    var iconPlusAdded: Bool = false
    
    var maxHeight: CGFloat = 200.0
    
    @State var collapsed = false
    @State var headerValue = ""
    @State var descriptionValue = ""
    @State var iconAnimating = false
    
    var body: some View {
        ZStack {
            
            HStack {
                
                VStack (alignment: .center) {
                    
                    if !icon.isEmpty && !collapsed {
                        ZStack {
                            
                            if isIconSystem {
                                Image(systemName: icon).font(.title2).foregroundStyle(.accent).symbolEffect(.bounce, value: iconAnimating)
                            } else {
                                Image(icon).resizable().scaledToFit().frame(width: 28, height: 28)
                            }
                            
                            if iconPlusAdded {
                                Image(systemName: "plus.circle.fill").font(.headline).foregroundStyle(.accent).offset(x: 18, y: 18)
                            }
                            
                        }.frame(width: 54, height: 54).background() {
                            RoundedRectangle(cornerRadius: 32.0).fill(.window)
                        }
                    }
                    
                    if !collapsed {
                        Text(headerValue).font(collapsed ? .headline : .title).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).contentTransition(.identity)
                    }
                    
                    if !descriptionValue.isEmpty && !collapsed {
                        Text(descriptionValue).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center).offset(y: 8).contentTransition(.identity)
                    }
                    
                }.padding([.leading, .trailing, .bottom])

            }.frame(maxHeight: .infinity).padding(.bottom, 36)
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).background() {
            
            ColorBackgroundView(size: 160).ignoresSafeArea()
            
        }.frame(height: isCollapsed ? 40.0 : maxHeight).onChange(of: header) {
            withAnimation {
                headerValue = header
            }
        }.onChange(of: description) {
            withAnimation {
                descriptionValue = description
            }
        }.onChange(of: isCollapsed) {
            withAnimation {
                collapsed = isCollapsed
            }
        }.onAppear() {
            headerValue = header
            descriptionValue = description
            collapsed = isCollapsed
            withAnimation {
                iconAnimating = true
            }
        }
    }
}

#Preview {
    TopBarView(header: .constant("Header"), description: .constant("Description"), isCollapsed: .constant(false), icon: "gear", isIconSystem: true, iconPlusAdded: true)
}
