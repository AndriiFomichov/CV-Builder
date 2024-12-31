//
//  ContentBlockView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 30.11.2024.
//

import SwiftUI

struct ContentBlockView: View {
    
    @Binding var item: ContentBlock
    
    let clickHandler: () -> Void
    let textChangeHandler: () -> Void
    let itemMoveHandler: () -> Void
    let actionClickHandler: (_ position: Int) -> Void
    
    let itemTextChangeHandler: (_ index: Int) -> Void
    let actionItemClickHandler: (_ index: Int, _ positionAction: Int) -> Void
    @Binding var networkStatus: NetworkStatus
    
    @State var text = ""
    @State var isLoading = false
    @State var isSelected = false
    @State var isFilled = false
    @State var aiAvailable = true
    
    @State private var draggedItem: ContentItem?
    
    var body: some View {
        VStack (spacing: 0) {
            
            Button (action: clickHandler) {
                HStack (spacing: 0) {
                    
                    ZStack {
                        
                        Image(systemName: item.icon).font(.headline).foregroundStyle(.accent)
                        
                    }.frame(width: 42, height: 42).background() {
                        RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                    }.padding(.trailing, 8)

                    VStack {
                        Text(item.name).font(.title3).bold().foregroundStyle(.accent).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    }
                    
                    Image(systemName: isSelected ? "checkmark.seal.fill" : "circle").font(.title2).foregroundStyle(LinearGradient(colors: isSelected ? [ .accentLight, .accent ] : [ .textAdditional ], startPoint: .topLeading, endPoint: .bottomTrailing)).contentTransition(.symbolEffect(.replace))
                }
            }.padding(8)
            
            if item.isTextAdded {
                TextField("", text: $text, prompt: Text(NSLocalizedString("enter_description", comment: "")).foregroundStyle(.textAdditional), axis: .vertical).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2...3).padding(.horizontal, 8).padding(.bottom, 8)
                
                HStack {
                    if aiAvailable {
                        if isFilled {
                            AiActionsListView (actions: [ NSLocalizedString("ai_rephrase", comment: ""), NSLocalizedString("ai_expand", comment: ""), NSLocalizedString("ai_shorten", comment: ""), NSLocalizedString("ai_to_bulleted", comment: ""), NSLocalizedString("ai_custom", comment: "") ], actionHandler: actionClickHandler)
                        } else {
                            AiActionsListView (actions: [ NSLocalizedString("ai_generate_text", comment: "") ], actionHandler: actionClickHandler)
                        }
                    } else {
                        NoAiSmallConnectionView()
                    }
                }.opacity(isLoading ? 0.5 : 1.0).padding(.bottom, 8)
            }
            
            if item.items.count > 0 {
                VStack {
                    
                    ForEach(item.items.indices, id: \.self) { index in
                        ContentItemView(item: $item.items[index], itemTextChangeHandler: {
                            itemTextChangeHandler(index)
                        }, actionClickHandler: { position in
                            actionItemClickHandler(index, position)
                        }, networkStatus: $networkStatus).onDrag {
                            self.draggedItem = item.items[index]
                            return NSItemProvider()
                        }.onDrop(of: [.text], delegate: ContentItemDropDelegate(destinationItem: item.items[index], list: $item.items, draggedItem: $draggedItem, dropEndHandler: {
                            itemMoveHandler()
                        }))
                    }
                    
                }.padding(8).background() {
                    RoundedRectangle(cornerRadius: 16.0).fill(Color.windowTwo)
                }.padding(8)
            }
            
        }.clipShape(RoundedRectangle(cornerRadius: 20.0)).borderLoadingAnimation(isAnimating: $isLoading).background() {
            
            RoundedRectangle(cornerRadius: 20.0).fill(Color.window)
            
        }.onAppear() {
            text = item.text
            withAnimation {
                isSelected = item.isAdded
            }
        }.onChange(of: item.isAdded) {
            withAnimation {
                isSelected = item.isAdded
            }
        }.onChange(of: item.isLoading) {
            withAnimation {
                isLoading = item.isLoading
            }
        }.onChange(of: item.text) {
            text = item.text
        }.onChange(of: text) {
            item.text = text
            textChangeHandler()
            withAnimation {
                isFilled = !text.isEmpty
            }
        }.onChange(of: networkStatus) {
            withAnimation {
                aiAvailable = networkStatus == .connected
            }
        }.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 20.0, style: .continuous))
    }
}

#Preview {
    ContentBlockView(item: .constant(ContentBlock.getDefault()), clickHandler: {}, textChangeHandler: {}, itemMoveHandler: {}, actionClickHandler: {i in }, itemTextChangeHandler: { i in }, actionItemClickHandler: { i, n in }, networkStatus: .constant(NetworkStatus.connected))
}
