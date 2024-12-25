//
//  WorkAddingView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 22.11.2024.
//

import SwiftUI

struct WorkAddingView: View, KeyboardReadable {
    
    var profile: ProfileEntity?
    var entity: WorkEntity?
    var allFields = false
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = WorkAddingViewModel()
    
    @State var isCollapsed = false
    
    @State private var selectingDate = 0
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: .constant(NSLocalizedString("work_experience", comment: "")), description: .constant(""), isCollapsed: $isCollapsed, icon: "briefcase.fill", iconPlusAdded: true, maxHeight: 180)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            VStack {
                                
                                Text(NSLocalizedString("field_job_title", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                TextInputView(text: $viewModel.jobTitle, icon: "checkmark.seal.fill", hint: NSLocalizedString("field_job_title_hint", comment: "")).padding(.bottom)
                                
                                Text(NSLocalizedString("field_work_institution", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                
                                HStack {
                                    TextInputView(text: $viewModel.company, icon: "building.columns.fill", hint: NSLocalizedString("field_work_institution_hint", comment: ""))
                                    
                                    IconInputView(preview: $viewModel.icon, icon: "photo", selectionHandler: { photos in
                                        viewModel.handleImageSelection(selectedPhotos: photos)
                                    })
                                    
                                }.padding(.bottom)
                                
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
                                        
                                        if viewModel.isStillWorking {
                                            DateInputView(date: $viewModel.endDate, isNow: $viewModel.isStillWorking, hint: NSLocalizedString("field_select_end_hint", comment: ""))
                                        } else {
                                            Button (action: {
                                                updateSelectedDates(type: 1, date: viewModel.endDate)
                                                self.endEditing()
                                                viewModel.showDatePicker()
                                            }) {
                                                DateInputView(date: $viewModel.endDate, isNow: $viewModel.isStillWorking, hint: NSLocalizedString("field_select_end_hint", comment: ""))
                                            }
                                        }
                                    }
                                    
                                }
                                
                                ToggleInputView(isSelected: $viewModel.isStillWorking, icon: "briefcase.fill", text: NSLocalizedString("field_still_working_hint", comment: "")).padding(.bottom)
                                
                                if allFields {
                                    
                                    Text(NSLocalizedString("field_location", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    TextInputView(text: $viewModel.location, icon: "paperplane.fill", hint: NSLocalizedString("field_location_hint", comment: "")).padding(.bottom)
                                    
                                    Text(NSLocalizedString("field_responsibilities", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    TextInputView(text: $viewModel.responsibilities, icon: "trophy.fill", hint: NSLocalizedString("field_responsibilities_hint", comment: ""))
                                    
                                    Text(NSLocalizedString("field_responsibilities_tip", comment: "")).font(.subheadline).foregroundStyle(Color.textAdditional).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.bottom)
                                    
                                    Text(NSLocalizedString("field_additional_params", comment: "")).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)
                                    
                                    ToggleInputView(isSelected: $viewModel.remote, icon: "wave.3.right.circle.fill", text: NSLocalizedString("field_remote", comment: ""))
                                    
                                    ToggleInputView(isSelected: $viewModel.partTime, icon: "clock.badge.checkmark.fill", text: NSLocalizedString("field_part_time", comment: "")).padding(.bottom)
                                }
                                
                            }.padding()
                            
                        }.alert(NSLocalizedString("delete_work_header", comment: ""), isPresented: $viewModel.deleteAlertShown) {
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
                
            }.navigationTitle(isCollapsed ? NSLocalizedString("work_experience", comment: "") : "").navigationBarTitleDisplayMode(.inline).toolbar {
                
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
}

#Preview {
    WorkAddingView()
}
