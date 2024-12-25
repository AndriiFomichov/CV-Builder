//
//  FreeTrialWorksView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.12.2024.
//

import SwiftUI

struct FreeTrialWorksView: View {
    
    @Binding var freeTrialStateTwoDay: String
    @Binding var freeTrialStateThreeDay: String
    @Binding var chargeDate: String
    
    var body: some View {
        VStack {
            
            Text(NSLocalizedString("how_free_trial_works", comment: "")).font(.title2).bold().foregroundColor(Color.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding()
            
            HStack {
                
                ZStack (alignment: .top) {
                    Rectangle().fill(Color.windowColored).frame(maxHeight: .infinity).padding(.top, 24)
                    
                    Image(systemName: "lock.open.fill")
                        .resizable().scaledToFit()
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundColor(Color.white).padding(12).background(){
                            Circle().fill(Color.accent)
                        }
                    
                }.frame(width: 36)
                
                Spacer(minLength: 16)
                
                VStack {
                    Text(NSLocalizedString("free_trial_today", comment: "")).font(.title2).bold().foregroundColor(Color.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).padding(.bottom, 4)
                    Text(NSLocalizedString("free_trial_today_description", comment: "")).font(.subheadline).foregroundColor(Color.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).padding(.bottom, 24)
                }
            }.padding(.horizontal).padding(.bottom, -16)
            
            HStack {
                
                ZStack (alignment: .top) {
                    Rectangle().fill(Color.windowColored).frame(maxHeight: .infinity)
                    
                    Image(systemName: "bell.fill")
                        .resizable().scaledToFit()
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundColor(Color.white).padding(12).background(){
                            Circle().fill(Color.accent)
                        }
                    
                }.frame(width: 36)
                
                Spacer(minLength: 16)
                
                VStack {
                    Text(freeTrialStateTwoDay).font(.title2).bold().foregroundColor(Color.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).padding(.bottom, 4)
                    Text(NSLocalizedString("free_trial_day_five_description", comment: "")).font(.subheadline).foregroundColor(Color.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).padding(.bottom, 24)
                }
            }.padding(.horizontal).padding(.bottom, -16)
            
            HStack {
                
                ZStack (alignment: .top) {
                    
                    LinearGradient(gradient: Gradient(colors: [.windowColored, .windowColored, .window]), startPoint: .top, endPoint: .bottom).frame(maxHeight: .infinity)
                    
                    Image(systemName: "crown.fill")
                        .resizable().scaledToFit()
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundColor(Color.white).padding(12).background(){
                            Circle().fill(Color.accent)
                        }
                    
                }.frame(width: 36)
                
                Spacer(minLength: 16)
                
                VStack {
                    Text(freeTrialStateThreeDay).font(.title2).bold().foregroundColor(Color.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).padding(.bottom, 4)
                    Text(NSLocalizedString("free_trial_day_seven_description_own", comment: "") + " " + chargeDate + ". " + NSLocalizedString("free_trial_day_seven_description_two", comment: "") ).font(.subheadline).foregroundColor(Color.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).padding(.bottom, 16)
                }
            }.padding(.horizontal).padding(.bottom)
            
        }.background() {
            RoundedRectangle(cornerRadius: 24.0).fill(Color.window)
        }.frame(height: 400)
    }
}

#Preview {
    FreeTrialWorksView(freeTrialStateTwoDay: .constant("5"), freeTrialStateThreeDay: .constant("7"), chargeDate: .constant("12.10"))
}
