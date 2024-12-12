//
//  GuideView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct GuideView: View {
    
    let guideId: Int
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = GuideViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack (spacing: 0) {
                    
                    TopBarView(header: $viewModel.header, description: .constant(""), progress: .constant(0.0), isLoading: .constant(false), isCollapsed: .constant(false), lineIllustration: "small_line_two_illustration", illustration: viewModel.illustration, maxHeight: 180)

                    VStack {
                        
                        ScrollView (showsIndicators: false) {
                            
                            LazyVStack {
                                
                                Text(viewModel.description).font(.subheadline).foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.bottom)
                                
                                switch guideId {
                                case 0:
                                    GuideOneView()
                                case 1:
                                    GuideTwoView()
                                case 2:
                                    GuideThreeView()
                                case 3:
                                    GuideFourView()
                                case 4:
                                    GuideFiveView()
                                case 5:
                                    GuideSixView()
                                default:
                                    HStack{}
                                }
                                
                            }.padding()
                            
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).background() {
                        RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                    }.padding(.top, -24)
                    
                    MainButtonView(isSelected: .constant(true), text: NSLocalizedString("continue", comment: ""), clickHandler: {
                        dismiss()
                    }).padding(.vertical)
                }
                
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(Color.accent)
                    }
                }
                
            }.onAppear() {
                viewModel.updateData(guide: guideId)
            }
            
        }.tint(.accent).interactiveDismissDisabled(true)
    }
}

struct GuideOneView: View {
    var body: some View {
        VStack {
            GuideItemView(item: GuideItem(header: NSLocalizedString("general_data_tip_one_header", comment: ""), description: NSLocalizedString("general_data_tip_one_description", comment: ""), tip: NSLocalizedString("general_data_tip_one_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("general_data_tip_two_header", comment: ""), description: NSLocalizedString("general_data_tip_two_description", comment: ""), tip: NSLocalizedString("general_data_tip_two_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0)).padding(.bottom)
            
            Text(NSLocalizedString("some_tips", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("general_data_tip_three_header", comment: ""), description: NSLocalizedString("general_data_tip_three_description", comment: ""), tip: NSLocalizedString("general_data_tip_three_source", comment: ""), illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("general_data_tip_four_header", comment: ""), description: NSLocalizedString("general_data_tip_four_description", comment: ""), tip: "", illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0)).padding(.bottom)
        }
    }
}

struct GuideTwoView: View {
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                GuideItemView(item: GuideItem(header: NSLocalizedString("education_tip_one_header", comment: ""), description: NSLocalizedString("education_tip_one_description", comment: ""), tip: NSLocalizedString("education_tip_one_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
                
                GuideItemView(item: GuideItem(header: NSLocalizedString("education_tip_two_header", comment: ""), description: NSLocalizedString("education_tip_two_description", comment: ""), tip: NSLocalizedString("education_tip_two_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            }
            HStack (alignment: .top) {
                GuideItemView(item: GuideItem(header: NSLocalizedString("education_tip_three_header", comment: ""), description: NSLocalizedString("education_tip_three_description", comment: ""), tip: NSLocalizedString("education_tip_three_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
                
                GuideItemView(item: GuideItem(header: NSLocalizedString("education_tip_four_header", comment: ""), description: NSLocalizedString("education_tip_four_description", comment: ""), tip: NSLocalizedString("education_tip_four_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            }.padding(.bottom)
            
            Text(NSLocalizedString("some_tips", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("education_tip_five_header", comment: ""), description: NSLocalizedString("education_tip_five_description", comment: ""), tip: "", illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("education_tip_six_header", comment: ""), description: NSLocalizedString("education_tip_six_description", comment: ""), tip: "", illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0)).padding(.bottom)
        }
    }
}

struct GuideThreeView: View {
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                GuideItemView(item: GuideItem(header: NSLocalizedString("work_tip_one_header", comment: ""), description: NSLocalizedString("work_tip_one_description", comment: ""), tip: NSLocalizedString("work_tip_one_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
                
                GuideItemView(item: GuideItem(header: NSLocalizedString("work_tip_two_header", comment: ""), description: NSLocalizedString("work_tip_two_description", comment: ""), tip: NSLocalizedString("work_tip_two_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            }
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("work_tip_three_header", comment: ""), description: NSLocalizedString("work_tip_three_description", comment: ""), tip: NSLocalizedString("work_tip_three_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0)).padding(.bottom)
            
            Text(NSLocalizedString("some_tips", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("work_tip_four_header", comment: ""), description: NSLocalizedString("work_tip_four_description", comment: ""), tip: "", illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("work_tip_five_header", comment: ""), description: NSLocalizedString("work_tip_five_description", comment: ""), tip: "", illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("work_tip_six_header", comment: ""), description: NSLocalizedString("work_tip_six_description", comment: ""), tip: "", illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("work_tip_seven_header", comment: ""), description: NSLocalizedString("work_tip_seven_description", comment: ""), tip: "", illustration: "", lineIllustration: "small_line_one_illustration", isHeaderHighlighted: false, isHeaderLarge: false, alignment: 0)).padding(.bottom)
        }
    }
}

struct GuideFourView: View {
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                GuideItemView(item: GuideItem(header: NSLocalizedString("job_specific_tip_one_header", comment: ""), description: NSLocalizedString("job_specific_tip_one_description", comment: ""), tip: NSLocalizedString("job_specific_tip_one_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: true, isHeaderLarge: true, alignment: 0))
                
                GuideItemView(item: GuideItem(header: NSLocalizedString("job_specific_tip_two_header", comment: ""), description: NSLocalizedString("job_specific_tip_two_description", comment: ""), tip: NSLocalizedString("job_specific_tip_two_source", comment: ""), illustration: "", lineIllustration: "small_line_two_illustration", isHeaderHighlighted: true, isHeaderLarge: true, alignment: 0))
            }
            
            Text(NSLocalizedString("allow_ai_to_optimize_cv", comment: "")).font(.title2).bold().foregroundStyle(Color.text).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("job_specific_tip_three_header", comment: ""), description: NSLocalizedString("job_specific_tip_three_description", comment: ""), tip: "", illustration: "tip_job_speicific_one_illustration", lineIllustration: "", isHeaderHighlighted: true, isHeaderLarge: false, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("job_specific_tip_four_header", comment: ""), description: NSLocalizedString("job_specific_tip_four_description", comment: ""), tip: "", illustration: "tip_job_speicific_two_illustration", lineIllustration: "", isHeaderHighlighted: true, isHeaderLarge: false, alignment: 1))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("job_specific_tip_five_header", comment: ""), description: NSLocalizedString("job_specific_tip_five_description", comment: ""), tip: "", illustration: "tip_job_speicific_three_illustration", lineIllustration: "", isHeaderHighlighted: true, isHeaderLarge: false, alignment: 0)).padding(.bottom)
        }
    }
}

struct GuideFiveView: View {
    var body: some View {
        VStack {

            GuideItemView(item: GuideItem(header: NSLocalizedString("essential_info_tip_one_header", comment: ""), description: NSLocalizedString("essential_info_tip_one_description", comment: ""), tip: NSLocalizedString("essential_info_tip_one_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("essential_info_tip_two_header", comment: ""), description: NSLocalizedString("essential_info_tip_two_description", comment: ""), tip: NSLocalizedString("essential_info_tip_two_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("essential_info_tip_three_header", comment: ""), description: NSLocalizedString("essential_info_tip_three_description", comment: ""), tip: NSLocalizedString("essential_info_tip_three_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0)).padding(.bottom)
        }
    }
}

struct GuideSixView: View {
    var body: some View {
        VStack {

            GuideItemView(item: GuideItem(header: NSLocalizedString("skills_tip_one_header", comment: ""), description: NSLocalizedString("skills_tip_one_description", comment: ""), tip: NSLocalizedString("skills_tip_one_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("skills_tip_two_header", comment: ""), description: NSLocalizedString("skills_tip_two_description", comment: ""), tip: NSLocalizedString("skills_tip_two_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0))
            
            GuideItemView(item: GuideItem(header: NSLocalizedString("skills_tip_three_header", comment: ""), description: NSLocalizedString("skills_tip_three_description", comment: ""), tip: NSLocalizedString("skills_tip_three_source", comment: ""), illustration: "", lineIllustration: "small_line_four_illustration", isHeaderHighlighted: false, isHeaderLarge: true, alignment: 0)).padding(.bottom)
        }
    }
}

#Preview {
    GuideView(guideId: 5)
}
