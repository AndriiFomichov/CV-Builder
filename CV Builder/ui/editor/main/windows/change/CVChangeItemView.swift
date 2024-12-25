//
//  CVChangeItemView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 24.12.2024.
//

import SwiftUI

struct CVChangeItemView: View {
    
    @Binding var item: CVChange
    let selectionHandler: () -> Void
    let descriptionHandler: (_ isSelected: Bool) -> Void
    
    @State var isSelected = true
    @State var isDescriptionSelected = true
    
    var body: some View {
        Button (action: selectionHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    
                    Image(systemName: item.blockIcon).font(.headline).foregroundStyle(isSelected ? .accent : .accentLight)
                    
                }.frame(width: 38, height: 38).background() {
                    RoundedRectangle(cornerRadius: 32.0).foregroundStyle(.windowColored)
                }.padding(8).padding(.vertical, 8)
                
                VStack (alignment: .leading, spacing: 6) {
                    
                    Text(item.blockName).font(.title3).bold().foregroundLinearGradient(colors: isSelected ? [ Color.accentLight, Color.accent] : [Color.accentLight], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(2)
                    
                    if item.descriptionGenerationNeeded {
                        
                        Button (action: {
                            isDescriptionSelected.toggle()
                        }) {
                            HStack (spacing: 4) {
                                
                                Image("sparkle_colored_icon").resizable().scaledToFit().frame(width: 20, height: 20).opacity(isDescriptionSelected ? 1.0 : 0.5)
                                
                                Text(item.descriptionGenerationsText).font(.subheadline).foregroundStyle(isDescriptionSelected ? .accent : .accentLight).multilineTextAlignment(.leading)
                                
                                Toggle("", isOn: $isDescriptionSelected).tint(.accent).fixedSize().scaleEffect(0.6).frame(width: 34, height: 22)
                                
                            }.padding(8).background() {
                                RoundedRectangle(cornerRadius: 24.0).fill(.windowColored)
                            }.opacity(isSelected ? 1.0 : 0.5)
                        }
                    }
                    
                }.padding(.vertical, 8)
                
                Image(systemName: isSelected ? "checkmark.seal.fill" : "circle").font(.title2).foregroundStyle(LinearGradient(colors: isSelected ? [ .accentLight, .accent ] : [ .textAdditional ], startPoint: .topLeading, endPoint: .bottomTrailing)).contentTransition(.symbolEffect(.replace)).padding(8)
                
            }.background() {
                ColorBackgroundView(alignment: .topLeading, x: 15)
            }.clipShape(RoundedRectangle(cornerRadius: 20.0))
            
        }.onAppear() {
            isSelected = item.isChangeEnabled
            isDescriptionSelected = item.descriptionGenerationEnabled
        }.onChange(of: item.isChangeEnabled) {
            withAnimation {
                isSelected = item.isChangeEnabled
            }
        }.onChange(of: isDescriptionSelected) {
            descriptionHandler(isDescriptionSelected)
        }
    }
}

#Preview {
    @Previewable @State var item = CVChange.getDefault()
    CVChangeItemView(item: $item, selectionHandler: {}, descriptionHandler: { b in })
}
