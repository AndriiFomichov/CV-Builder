//
//  SideBarStack.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct SideBarStack<SidebarContent: View, Content: View>: View {
    
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @State var overlayOpacity: Double = 0.0
    @State var showSidebar: Bool = false
    @Binding var show: Bool
    
    init(sidebarWidth: CGFloat, show: Binding<Bool>, @ViewBuilder sidebar: () -> SidebarContent, @ViewBuilder content: () -> Content) {
        self.sidebarWidth = sidebarWidth > 380 ? 380 : sidebarWidth
        self._show = show
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .frame(width: sidebarWidth, alignment: .center)
                .offset(x: showSidebar ? 0 : -1 * sidebarWidth, y: 0)
            mainContent
                .overlay(
                    Group {
                        if showSidebar {
                            Color.gray
                                .opacity(overlayOpacity)
                                .onTapGesture {
                                    self.show = false
                                }
                        } else {
                            Color.clear
                            .opacity(showSidebar ? 0 : 0)
                            .onTapGesture {
                                self.show = false
                            }
                        }
                    }
                ).ignoresSafeArea()
                .offset(x: showSidebar ? sidebarWidth : 0, y: 0)
        }.onChange(of: show) {
            withAnimation {
                self.showSidebar = show
                self.overlayOpacity = show ? 0.01 : 0
            }
        }
    }
}
