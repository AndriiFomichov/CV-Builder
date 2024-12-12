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
    
    var body: some View {
        VStack {
            MonthYearWheelRepresentable(minimumDate: getMinimumDate(), maximumDate: Date(), selectedMonth: $selectedMonth, selectedYear: $selectedYear).padding()
            
            MainButtonView(isSelected: .constant(true), text: NSLocalizedString("apply", comment: ""), clickHandler: applyHandler).padding(.bottom)
            
        }.background() {
            Color.backgroundDark
        }
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
