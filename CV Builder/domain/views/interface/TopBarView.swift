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
    @Binding var progress: CGFloat
    @Binding var isLoading: Bool
    @Binding var isCollapsed: Bool
    
    var lineIllustration: String
    var illustration: String? = nil
    
    var progressShown: Bool = false
    var maxHeight: CGFloat = 200.0
    
    @State var collapsed = false
    @State var loadingShown = false
    @State var progressValue: CGFloat = 0.0
    @State var headerValue = ""
    @State var descriptionValue = ""
    
    var body: some View {
        ZStack {
            
            HStack {
                
                VStack (alignment: .leading) {
                    
                    if !collapsed {
                        Text(headerValue).font(collapsed ? .headline : .title).bold().foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                    }
                    
                    if !descriptionValue.isEmpty && !collapsed {
                        Text(descriptionValue).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).offset(y: 8)
                    }
                    
                    if loadingShown && !collapsed {
                        ProgressView().foregroundStyle(Color.white).transition(.opacity).padding(.top, 4)
                    }
                    
                }.padding([.leading, .trailing, .bottom])
                
                if progressShown && !collapsed {
                    CircleProgressView(progress: progressValue).frame(maxHeight: 90).padding(.trailing)
                }
                
                if let illustration, !illustration.isEmpty, !collapsed {
                    if illustration == "back_remover_illustration" {
                        BackRemoverIllustrationView().frame(width: 126, height: 126).padding(.trailing )
                    } else {
                        Image(illustration).resizable().scaledToFit()
                    }
                }
                
            }.frame(maxHeight: .infinity).padding(.bottom, 36)
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).background() {
            ZStack (alignment: getGravityForLine() == 1 ? .bottomTrailing : .bottomLeading) {
                LinearGradient(gradient: Gradient(colors: [.backgroundDark, .backgroundDark]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                if !collapsed {
                    Image(lineIllustration).renderingMode(.template).resizable().scaledToFit().foregroundStyle(.backgroundDarker)
                }
            }
        }.frame(height: isCollapsed ? 40.0 : maxHeight).onChange(of: isLoading) {
            withAnimation {
                self.loadingShown = isLoading
            }
        }.onChange(of: header) {
            withAnimation {
                self.headerValue = header
            }
        }.onChange(of: description) {
            withAnimation {
                self.descriptionValue = description
            }
        }.onChange(of: progress) {
            withAnimation {
                self.progressValue = progress
            }
        }.onChange(of: isCollapsed) {
            withAnimation {
                self.collapsed = isCollapsed
            }
        }.onAppear() {
            self.loadingShown = isLoading
            self.headerValue = header
            self.descriptionValue = description
            self.progressValue = progress
            self.collapsed = isCollapsed
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
    TopBarView(header: .constant("Header"), description: .constant("Description"), progress: .constant(0.4), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_four_illustration", illustration: nil, progressShown: true)
}
