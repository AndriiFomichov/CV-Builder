//
//  FormatView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct FormatView: View {
    
    @Binding var format: Format
    let clickHandler: () -> Void
    
    @State var isSelected = false
    
    var body: some View {
        Button (action: clickHandler) {
            HStack (spacing: 0) {
                
                ZStack {
                    Image(format.icon + "_bottom").renderingMode(.template).resizable().scaledToFit().foregroundStyle(format.color.opacity(0.6))
                    
                    Image(format.icon + "_top").resizable().scaledToFit()
                    
                }.frame(width: 82).padding(.trailing)
                
                
                VStack {
                    Text(format.header).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.bottom, 2)
                    
                    Text(format.description).font(.subheadline).foregroundStyle(Color.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                    
                    if format.isRecommended {
                        HStack {
                            Text(NSLocalizedString("recommended", comment: "")).font(.subheadline).foregroundStyle(Color.text).multilineTextAlignment(.leading).padding(8).background() {
                                RoundedRectangle(cornerRadius: 12.0).fill(Color.window)
                            }
                            Spacer()
                        }.padding(.top, 4)
                    }

                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding(.vertical, 12)
                
                SelectedIndicatorView(isSelected: $isSelected, type: 1).padding(8).padding(.trailing, 4)
                
            }.background {
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
            }.clipShape(RoundedRectangle(cornerRadius: 16.0)).overlay {
                RoundedRectangle(cornerRadius: 16.0).stroke(isSelected ? Color.accent : Color.clear, style: StrokeStyle(lineWidth: 2))
            }
            
        }.onAppear() {
            withAnimation {
                self.isSelected = format.isSelected
            }
        }.onChange(of: format.isSelected) {
            withAnimation {
                self.isSelected = format.isSelected
            }
        }
    }
}

#Preview {
    FormatView(format: .constant(Format.getDefault()), clickHandler: {})
}
