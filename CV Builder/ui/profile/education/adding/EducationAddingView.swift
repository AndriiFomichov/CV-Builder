//
//  EducationAddingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct EducationAddingView: View, KeyboardReadable {
    
    var profile: ProfileEntity?
    var entity: EducationEntity?
    var allFields = false
    
    @Environment(\.dismiss) var dismiss
//    @ObservedObject var keyboard = KeyboardResponder()
    
    @StateObject var viewModel = EducationAddingViewModel()
    
    @State var isCollapsed = false
    
    @State private var selectingDate = 0
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("education", comment: "")), description: .constant(""), isCollapsed: $isCollapsed, icon: "graduationcap.fill", iconPlusAdded: true, maxHeight: 180)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                Text(NSLocalizedString("field_education_level", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.level, icon: "checkmark.seal.fill", hint: NSLocalizedString("field_education_level_hint", comment: ""), options: getLevelOptions()).padding(.bottom)
                                
                                Text(NSLocalizedString("field_education_institution", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                HStack {
                                    
                                    TextInputView(text: $viewModel.institution, icon: "building.columns.fill", hint: NSLocalizedString("field_education_institution_hint", comment: ""))
                                    
                                    IconInputView(preview: $viewModel.logo, icon: "photo", selectionHandler: { photos in
                                        viewModel.handleImageSelection(selectedPhotos: photos)
                                    })
                                    
                                }.padding(.bottom)
                                
                                Text(NSLocalizedString("field_field_of_study", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.field, icon: "lightbulb.max.fill", hint: NSLocalizedString("field_field_of_study_hint", comment: ""), options: getFieldOptions()).padding(.bottom)
                                
                                HStack {
                                    
                                    VStack {
                                        
                                        Text(NSLocalizedString("field_start_date", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                        
                                        Button (action: {
                                            updateSelectedDates(type: 0, date: viewModel.startDate)
                                            self.endEditing()
                                            viewModel.showDatePicker()
                                        }) {
                                            DateInputView(date: $viewModel.startDate, isNow: .constant(false), hint: NSLocalizedString("field_select_start_hint", comment: ""))
                                        }
                                    }
                                    
                                    VStack {
                                        
                                        Text(NSLocalizedString("field_end_date", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                        
                                        if viewModel.isStillLearning {
                                            DateInputView(date: $viewModel.endDate, isNow: $viewModel.isStillLearning, hint: NSLocalizedString("field_select_end_hint", comment: ""))
                                        } else {
                                            Button (action: {
                                                updateSelectedDates(type: 1, date: viewModel.endDate)
                                                self.endEditing()
                                                viewModel.showDatePicker()
                                            }) {
                                                DateInputView(date: $viewModel.endDate, isNow: $viewModel.isStillLearning, hint: NSLocalizedString("field_select_end_hint", comment: ""))
                                            }
                                        }
                                    }
                                }
                                
                                ToggleInputView(isSelected: $viewModel.isStillLearning, icon: "lamp.desk.fill", text: NSLocalizedString("field_still_learning_hint", comment: "")).padding(.bottom)
                                
                                if allFields {
                                    Text(NSLocalizedString("field_degree_earned", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    TextInputView(text: $viewModel.degree, icon: "graduationcap.fill", hint: NSLocalizedString("field_degree_earned_hint", comment: ""), options: getDegreeOptions()).padding(.bottom)
                                    
                                    Text(NSLocalizedString("field_gpa", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    TextInputView(text: $viewModel.gpa, icon: "trophy.fill", hint: NSLocalizedString("field_gpa_hint", comment: "")).padding(.bottom)
                                    
                                    Text(NSLocalizedString("field_related_coursework", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    TextInputView(text: $viewModel.coursework, icon: "trophy.fill", hint: NSLocalizedString("field_related_coursework_hint", comment: "")).padding(.bottom)
                                }
                                
                            }.padding()
                            
                        }.alert(NSLocalizedString("delete_education_header", comment: ""), isPresented: $viewModel.deleteAlertShown) {
                            Button(NSLocalizedString("keep", comment: ""), role: .cancel, action: {})
                            Button(NSLocalizedString("delete", comment: ""), role: .destructive, action: {
                                viewModel.performDelete()
                            })
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                    }.padding(.top, -24)
                    
                    if isCollapsed {
                        KeyboardActionsView(clearHanlder: {
                            self.endEditing()
                        }, doneHanlder: {
                            self.endEditing()
                        })
                    } else {
                        MainButtonView(isSelected: .constant(true), text: viewModel.btnMainText, clickHandler: {
                            viewModel.save()
                        }).padding(.vertical)
                    }
                    
                }.sheet(isPresented: $viewModel.datePickerSheetShown) {
                    DatePickerView(selectedMonth: $selectedMonth, selectedYear: $selectedYear, applyHandler: {
                        viewModel.saveDate(dateType: selectingDate, date: convertSelectedMonthYearToDate())
                    }).presentationDetents([.medium])
                }
                
            }.navigationTitle(isCollapsed ? NSLocalizedString("education", comment: "") : "").navigationBarTitleDisplayMode(.inline).toolbar {
                
                if viewModel.deleteVisible {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.delete()
                        }) {
                            Image(systemName: "trash.fill").foregroundColor(Color.accent)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(profile: profile, entity: entity)
            }.onReceive(keyboardPublisher) { newIsKeyboardVisible in
                withAnimation {
                    isCollapsed = newIsKeyboardVisible
                }
            }.onChange(of: viewModel.dismissed) {
                dismiss()
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
    
    private func updateSelectedDates (type: Int, date: Date?) {
        selectingDate = type
        if let date {
            selectedMonth = Calendar.current.component(.month, from: date)
            selectedYear = Calendar.current.component(.year, from: date)
        }
    }
    
    private func convertSelectedMonthYearToDate () -> Date? {
        var components = DateComponents()
        components.month = selectedMonth
        components.year = selectedYear
        return Calendar.current.date(from: components)
    }
    
    private func getLevelOptions () -> [MenuItem] {
        var list: [MenuItem] = []
        for i in 0..<7 {
            list.append(MenuItem(id: i, name: NSLocalizedString("field_education_level_sug_" + String(i), comment: "")))
        }
        return list
    }
    
    private func getFieldOptions () -> [MenuItem] {
        var list: [MenuItem] = []
        for i in 0..<20 {
            list.append(MenuItem(id: i, name: NSLocalizedString("field_field_of_study_sug_" + String(i), comment: "")))
        }
        return list
    }
    
    private func getDegreeOptions () -> [MenuItem] {
        var list: [MenuItem] = []
        for i in 0..<20 {
            list.append(MenuItem(id: i, name: NSLocalizedString("field_degree_earned_sug_" + String(i), comment: "")))
        }
        return list
    }
}

#Preview {
    EducationAddingView()
}
