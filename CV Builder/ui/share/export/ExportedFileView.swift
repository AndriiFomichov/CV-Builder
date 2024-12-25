//
//  ExportedFileView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import SwiftUI

struct ExportedFileView: View {
    
    var file: ExportedFile
    
    var body: some View {
        if let url = file.url {
            ShareLink(item: url) {
                HStack (spacing: 0) {
                    
                    ZStack {
                        
                        Image(file.fileIcon).resizable().scaledToFit().frame(width: 24, height: 24)
                        
                    }.frame(width: 42, height: 42).background() {
                        RoundedRectangle(cornerRadius: 24.0).fill(Color.windowTwo)
                    }.padding(8)
                    
                    Text(file.fileName).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4).lineLimit(2)
                    
                    HStack (spacing: 4) {
                        
                        Text(NSLocalizedString("share", comment: "")).font(.subheadline).bold().foregroundStyle(Color.white).multilineTextAlignment(.leading).fixedSize()
                        
                        Image(systemName: "square.and.arrow.up.fill").font(.subheadline).foregroundStyle(Color.white)
                        
                    }.padding(12).padding(.horizontal, 2).background() {
                        
                        RoundedRectangle(cornerRadius: 32.0).fill(Color.accent)
                        
                    }.padding(8)
                    
                }.frame(maxWidth: .infinity).background {
                    RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
                }
            }
        }
    }
}

#Preview {
    ExportedFileView(file: ExportedFile.getDefault())
}
