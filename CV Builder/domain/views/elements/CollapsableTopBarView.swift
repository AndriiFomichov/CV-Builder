//
//  CollapsableTopBarView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

enum HeaderState {
    case expanded
    case collapsed
}

struct CollapsableTopBarView<HeaderView: View, ScrollView: View>: View {
    let expandedHeaderHeight: CGFloat
    let collapsedHeaderHeight: CGFloat
    let headerView: (() -> HeaderView)
    let scrollView: (() -> ScrollView)
    @Binding var offset: CGFloat
    @Binding var headerState: HeaderState
    
    init(expandedHeaderHeight: CGFloat,
         collapsedHeaderHeight: CGFloat,
         offset: Binding<CGFloat>,
         headerState: Binding<HeaderState>,
         headerView: @escaping () -> HeaderView,
         scrollView: @escaping () -> ScrollView) {
        self.expandedHeaderHeight = expandedHeaderHeight
        self.collapsedHeaderHeight = collapsedHeaderHeight
        self._offset = offset
        self._headerState = headerState
        self.headerView = headerView
        self.scrollView = scrollView
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            scrollView() // Scrollable content
            
            headerView() // Collapsible header
                .frame(height: expandedHeaderHeight)
                .offset(y: getOffset(offset: offset))
                .zIndex(1) // Ensure the header stays on top
        }
    }
    
    private func getOffset(offset: CGFloat) -> CGFloat {
        guard offset < .zero else { return .zero }
        if offset > -(expandedHeaderHeight - collapsedHeaderHeight) {
            updateHeaderState(currentState: headerState, futureState: .expanded)
            return offset
        } else {
            updateHeaderState(currentState: headerState, futureState: .collapsed)
            return -(expandedHeaderHeight - collapsedHeaderHeight)
        }
    }
    
    private func updateHeaderState(currentState: HeaderState,
                                   futureState: HeaderState) {
        if currentState != futureState {
            DispatchQueue.main.async {
                self.headerState = futureState
            }
        }
    }
}
