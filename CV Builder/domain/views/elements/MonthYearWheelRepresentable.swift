//
//  MonthYearWheelRepresentable.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 14.11.2024.
//

import Foundation
import SwiftUI

struct MonthYearWheelRepresentable: View {
    
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    private var minimumDate: Date
    private var maximumDate: Date
    private var months: [String]
    private var years: [Int] = []
    
    private var availableYears: [Int] {
        let minYear = Calendar.current.component(.year, from: minimumDate)
        let maxYear = Calendar.current.component(.year, from: maximumDate)
        return Array(minYear...maxYear)
    }
    
    init(minimumDate: Date, maximumDate: Date, selectedMonth: Binding<Int>, selectedYear: Binding<Int>) {
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self._selectedMonth = selectedMonth
        self._selectedYear = selectedYear
        self.months = []
        for i in 0..<12 {
            months.append(NSLocalizedString("month_f_" + String(i), comment: ""))
        }
        self.years = availableYears
    }
    
    var body: some View {
        HStack {
            Picker("Month", selection: $selectedMonth) {
                ForEach(1...12, id: \.self) { month in
                    Text(self.months[month - 1]).tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Year", selection: $selectedYear) {
                ForEach(availableYears, id: \.self) { year in
                    Text(verbatim: "\(year)").tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        .onChange(of: selectedMonth) {
            guard let date = DateComponents(calendar: Calendar.current, year: selectedYear, month: selectedMonth, day: 1, hour: 0, minute: 0, second: 0).date else { return }
            if date < minimumDate {
                selectedYear = Calendar.current.component(.year, from: minimumDate)
                selectedMonth = Calendar.current.component(.month, from: minimumDate)
            } else if date > maximumDate {
                selectedYear = Calendar.current.component(.year, from: maximumDate)
                selectedMonth = Calendar.current.component(.month, from: maximumDate)
            }
        }
    }
}
