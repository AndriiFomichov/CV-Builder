//
//  IconInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI
import PhotosUI
import _PhotosUI_SwiftUI

struct IconInputView: View {
    
    @Binding var preview: UIImage?
    let icon: String
    let selectionHandler: (_ selectedPhotos: [PhotosPickerItem]) -> Void
    
    @State var previewState: UIImage? = nil
    
    @State var selectedPhotos = [PhotosPickerItem]()
    
    var body: some View {
        
        PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 1, matching: .images) {

            HStack (spacing: 0) {
                
                ZStack {
                    
                    if let previewState {
                        Image(uiImage: previewState).resizable().scaledToFit().frame(width: 24, height: 24)
                    } else {
                        Image(systemName: icon).font(.headline).foregroundStyle(.accent)
                        
                        Image(systemName: "plus.circle.fill").font(.subheadline).foregroundStyle(.accent).offset(x: 12, y: 12)
                    }
                    
                }.frame(width: 42, height: 42).background() {
                    RoundedRectangle(cornerRadius: 12.0).fill(.windowTwo)
                }.padding(8)
                
            }.background() {
                
                RoundedRectangle(cornerRadius: 16.0).fill(Color.window)
                
            }
            
        }.onAppear() {
            withAnimation {
                previewState = preview
            }
        }.onChange(of: preview) {
            withAnimation {
                previewState = preview
            }
        }.onChange(of: selectedPhotos) { _, _ in
            selectionHandler(selectedPhotos)
        }
    }
}

#Preview {
    @Previewable @State var preview: UIImage? = UIImage(named: "education_illustration")
    IconInputView(preview: $preview, icon: "qrcode", selectionHandler: { list in })
}
