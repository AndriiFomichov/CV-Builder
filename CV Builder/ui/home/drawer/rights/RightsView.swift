//
//  RightsView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI

struct RightsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RightsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                ScrollView (showsIndicators: false) {
                    
                    VStack {
                        
                        LazyVGrid(columns: [ GridItem(.adaptive(minimum: 420)) ]) {
                            ForEach(viewModel.images.indices, id: \.self) { index in
                                ReferenceView(reference: viewModel.images[index]).padding(.bottom, 2)
                            }
                        }
                        
                    }.padding()
                }
                
            }.navigationTitle(NSLocalizedString("rights", comment: "")).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }
        }.onAppear() {
            viewModel.updateData()
        }
    }
}

#Preview {
    RightsView()
}
