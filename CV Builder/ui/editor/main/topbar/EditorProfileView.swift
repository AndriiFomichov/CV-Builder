//
//  EditorProfileView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import SwiftUI

struct EditorProfileView: View {
    
    @Binding var name: String
    @Binding var description: String
    @Binding var photo: UIImage?
    let clickHandler: () -> Void
    
    var body: some View {
        HStack {
            Button (action: clickHandler) {
                HStack (spacing: 0) {
                    
                    ZStack {
                        
                        if let photo {
                            Image(uiImage: photo).centerCropped()
                        } else {
                            Image(systemName: "person.crop.circle").font(.headline).foregroundStyle(.accent)
                        }
                        
                    }.clipShape(RoundedRectangle(cornerRadius: 12.0)).frame(width: 46, height: 46).background() {
                        RoundedRectangle(cornerRadius: 12.0).fill(.windowColored)
                    }.padding(6)
                    
                    VStack {
                        
                        Text(name.isEmpty ? NSLocalizedString("user_name", comment: "") : name).font(.headline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                        
                        Text(description).font(.subheadline).foregroundStyle(.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1)
                        
                    }.padding(.trailing, 4).padding(.vertical, 4)
                    
                    Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                    
                }.frame(maxWidth: .infinity).background() {
                    ProfileBackgorund().fill(.window)
                }.padding([.leading, .bottom, .trailing]).padding(.top, 2)
            }
        }.background() {
            UnevenRoundedRectangle(bottomLeadingRadius: 24.0, bottomTrailingRadius: 24.0).fill(Color.background)
        }.background() {
            Color.backgroundDark
        }
    }
}

struct ProfileBackgorund: Shape {
    
    var cornersRadius: CGFloat = 16.0
    var innerHeight: CGFloat = 2.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX + cornersRadius, y: rect.minY))
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY + innerHeight), control1: CGPoint(x: rect.minX + cornersRadius, y: rect.minY), control2: CGPoint(x: rect.midX - 10, y: rect.minY + innerHeight))
        path.addCurve(to: CGPoint(x: rect.maxX - cornersRadius, y: rect.minY), control1: CGPoint(x: rect.midX + 10, y: rect.minY + 3), control2: CGPoint(x: rect.maxX - cornersRadius, y: rect.minY))
        
        path.addArc(center: CGPoint(x: rect.maxX - cornersRadius, y: rect.minY + cornersRadius), radius: cornersRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 345), clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornersRadius))
        
        path.addArc(center: CGPoint(x: rect.maxX - cornersRadius, y: rect.maxY - cornersRadius), radius: cornersRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY - innerHeight), control1: CGPoint(x: rect.maxX - cornersRadius, y: rect.maxY), control2: CGPoint(x: rect.midX - 10, y: rect.maxY - innerHeight))
        path.addCurve(to: CGPoint(x: rect.minX + cornersRadius, y: rect.maxY), control1: CGPoint(x: rect.midX - 10, y: rect.maxY - 3), control2: CGPoint(x: rect.minX + cornersRadius, y: rect.maxY))
        
        path.addArc(center: CGPoint(x: rect.minX + cornersRadius, y: rect.maxY - cornersRadius), radius: cornersRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornersRadius))
        
        path.addArc(center: CGPoint(x: rect.minX + cornersRadius, y: rect.minY + cornersRadius), radius: cornersRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: false)

        return path
    }
}

#Preview {
    EditorProfileView(name: .constant("Name"), description: .constant("Description"), photo: .constant(nil), clickHandler: {})
}
