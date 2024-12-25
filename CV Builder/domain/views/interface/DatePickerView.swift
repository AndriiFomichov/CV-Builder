//
//  DatePickerView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct DatePickerView: View {
    
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    
    var applyHandler: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.background.ignoresSafeArea()
                
                VStack {
                    MonthYearWheelRepresentable(minimumDate: getMinimumDate(), maximumDate: Date(), selectedMonth: $selectedMonth, selectedYear: $selectedYear).padding().background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.backgroundDark)
                    }.padding(.horizontal)
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("apply", comment: ""), clickHandler: {
                        applyHandler()
                        dismiss()
                    }).padding(.vertical)
                }
                
            }.navigationTitle("").navigationBarTitleDisplayMode(.inline).toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }
            
        }.tint(.accent)
    }
    
    private func getMinimumDate () -> Date {
        var components = DateComponents()
        components.year = 1950
        if let date = Calendar.current.date(from: components) {
            return date
        }
        return Date()
    }
}

#Preview {
    DatePickerView(selectedMonth: .constant(0), selectedYear: .constant(2000), applyHandler: {})
}
