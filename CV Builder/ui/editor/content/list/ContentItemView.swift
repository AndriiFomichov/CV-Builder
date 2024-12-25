//
//  ContentItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import SwiftUI

struct ContentItemView: View {
    
    @Binding var item: ContentItem
    let itemTextChangeHandler: () -> Void
    let actionClickHandler: (_ position: Int) -> Void
    @Binding var networkStatus: NetworkStatus
    
    @State var text = ""
    @State var isLoading = false
    @State var isFilled = false
    @State var aiAvailable = true
    
    var body: some View {
        VStack (spacing: 0) {
            
            HStack (spacing: 0) {

                VStack {
                    
                    Text(item.header).font(.headline).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    Text(item.description).font(.caption).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)

                }
                
                ZStack {
                    
                    Image(systemName: "line.3.horizontal").font(.headline).foregroundStyle(.textAdditional)
                    
                }.frame(width: 42, height: 42)
                
            }.padding(8)
            
            TextField("", text: $text, prompt: Text(NSLocalizedString("enter_description", comment: "")).foregroundStyle(.textAdditional), axis: .vertical).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(3...4).opacity(isLoading ? 0.5 : 1.0).padding(.horizontal, 8).padding(.bottom, 8)
            
            HStack {
                if aiAvailable {
                    if isFilled {
                        AiActionsListView (actions: [ NSLocalizedString("ai_rephrase", comment: ""), NSLocalizedString("ai_expand", comment: ""), NSLocalizedString("ai_shorten", comment: ""), NSLocalizedString("ai_to_bulleted", comment: "") ], actionHandler: actionClickHandler)
                    } else {
                        AiActionsListView (actions: [ NSLocalizedString("ai_generate_text", comment: "") ], actionHandler: actionClickHandler)
                    }
                } else {
                    NoAiSmallConnectionView()
                }
            }.opacity(isLoading ? 0.5 : 1.0).padding(.bottom, 8)
            
        }.clipShape(RoundedRectangle(cornerRadius: 12.0)).borderLoadingAnimation(isAnimating: $isLoading, cornersRadius: 10.0).background() {
            
            RoundedRectangle(cornerRadius: 12.0).fill(Color.window)
            
        }.onAppear() {
            text = item.text
        }.onChange(of: item.isLoading) {
            withAnimation {
                isLoading = item.isLoading
            }
        }.onChange(of: item.text) {
            text = item.text
        }.onChange(of: text) {
            item.text = text
            itemTextChangeHandler()
            withAnimation {
                isFilled = !text.isEmpty
            }
        }.onChange(of: networkStatus) {
            withAnimation {
                aiAvailable = networkStatus == .connected
            }
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 12.0, style: .continuous))
    }
}

#Preview {
    ContentItemView(item: .constant(ContentItem.getDefault()), itemTextChangeHandler: {}, actionClickHandler: { i in }, networkStatus: .constant(NetworkStatus.connected))
}
