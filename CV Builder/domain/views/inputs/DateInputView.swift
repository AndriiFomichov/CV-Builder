//
//  DateInputView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import SwiftUI

struct DateInputView: View {
    
    @Binding var date: Date?
    @Binding var isNow: Bool
    let hint: String
    var icon = "calendar"
    
    @State var isSelectedState = false
    @State var text = ""
    
    var body: some View {
        HStack (spacing: 0) {
            
            ZStack {
                
                Image(systemName: isSelectedState ? "checkmark.circle.fill" : icon).font(.headline).foregroundStyle(isSelectedState ? .accent : .textAdditional).contentTransition(.symbolEffect(.replace))
                
            }.frame(width: 42, height: 42).background() {
                RoundedRectangle(cornerRadius: 24.0).fill(.windowTwo)
            }.padding(8)
            
            Text(text).font(.title2).bold().foregroundStyle(isSelectedState ? .accent : .textAdditional).fixedSize().frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).padding(.trailing, 4).padding(.vertical, 4)
            
        }.frame(maxWidth: .infinity).background() {
            RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
        }.onAppear() {
            withAnimation {
                if isNow {
                    isSelectedState = true
                    text = NSLocalizedString("field_dates_now", comment: "")
                } else {
                    if let date {
                        isSelectedState = true
                        text = convertDateToText(date: date)
                    } else {
                        isSelectedState = false
                        text = hint
                    }
                }
            }
        }.onChange(of: date) {
            withAnimation {
                if isNow {
                    isSelectedState = true
                    text = NSLocalizedString("field_dates_now", comment: "")
                } else {
                    if let date {
                        isSelectedState = true
                        text = convertDateToText(date: date)
                    } else {
                        isSelectedState = false
                        text = hint
                    }
                }
            }
        }.onChange(of: isNow) {
            withAnimation {
                if isNow {
                    isSelectedState = true
                    text = NSLocalizedString("field_dates_now", comment: "")
                } else {
                    if let date {
                        isSelectedState = true
                        text = convertDateToText(date: date)
                    } else {
                        isSelectedState = false
                        text = hint
                    }
                }
            }
        }
    }
    
    private func convertDateToText (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yy"
        return formatter.string(from: date)
    }
}

#Preview {
    @Previewable @State var date: Date?
    DateInputView(date: $date, isNow: .constant(false), hint: "Select start")
}
