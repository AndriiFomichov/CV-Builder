//
//  EditableTopBarView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import SwiftUI

struct EditableTopBarView: View {
    
    @Binding var header: String
    @Binding var description: String
    @Binding var text: String
    
    var icon: String
    var hint: String
    var lineIllustration: String
    var maxHeight: CGFloat = 200.0
    
    @State var headerValue = ""
    @State var descriptionValue = ""
    
    var body: some View {
        ZStack {
            
            HStack {
                
                VStack (alignment: .leading) {
                    
                    Text(headerValue).font(.title).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                    
                    if !descriptionValue.isEmpty {
                        Text(descriptionValue).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).offset(y: 8).lineLimit(1)
                    }
                    
                    TextInputView(text: $text, icon: icon, hint: hint).padding(.top)
                    
                }.padding([.leading, .trailing, .bottom])

            }.frame(maxHeight: .infinity).padding(.bottom, 36)
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).background() {
            ZStack (alignment: getGravityForLine() == 1 ? .bottomTrailing : .bottomLeading) {
                LinearGradient(gradient: Gradient(colors: [.backgroundDark, .backgroundDark]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                Image(lineIllustration).renderingMode(.template).resizable().scaledToFit().foregroundStyle(.backgroundDarker)
            }
        }.frame(height: maxHeight).onChange(of: header) {
            withAnimation {
                self.headerValue = header
            }
        }.onChange(of: description) {
            withAnimation {
                self.descriptionValue = description
            }
        }.onAppear() {
            self.headerValue = header
            self.descriptionValue = description
        }
    }
    
    private func getGravityForLine () -> Int {
        switch lineIllustration {
        case "small_line_one_illustration":
            return 0
        case "small_line_two_illustration":
            return 0
        case "small_line_three_illustration":
            return 1
        case "small_line_four_illustration":
            return 1
        case "small_line_five_illustration":
            return 0
        default:
            return 0
        }
    }
}

#Preview {
    EditableTopBarView(header: .constant("Header"), description: .constant("Desc"), text: .constant(""), icon: "gear", hint: "Hint", lineIllustration: "small_line_four_illustration")
}
