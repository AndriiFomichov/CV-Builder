//
//  PaywallView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 21.11.2024.
//

import SwiftUI

struct PaywallView: View {
    
    var benefitsId: Int
    var source: String
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = PaywallViewModel()
    
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    @State var subscriptionsLoading = false
    @State var subscriptionsVisible = false
    @State var freeTrialVisible = false
    @State var btnNextDesc = ""
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom) {
                
                LinearGradient(colors: [ .windowColored, .windowColored, .background, .background], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                ScrollView (showsIndicators: false) {
                    
                    VStack {
                        
                        ZStack {
                            
                            VStack {
                                Text(viewModel.header).font(.title).bold().foregroundStyle(.accent).foregroundLinearGradient(colors: [ .accentLight, .accent ], startPoint: .topLeading, endPoint: .bottomTrailing).frame(maxWidth: .infinity, alignment: .center).multilineTextAlignment(.center)

                            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 120).padding().padding(.bottom, 36).padding(.top, 104)
                            
                        }.background() {
                            ColorBackgroundView()
                        }.padding(.top, -120)
                        
                        VStack {
                            
                            Image("logo_1024_rounded").resizable().frame(width: 48, height: 48).clipShape(RoundedRectangle(cornerRadius: 12.0)).padding(.top, -48).padding(.bottom).shadow(color: .black.opacity(0.2), radius: 20)
                            
                            Text(viewModel.description).font(.subheadline).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding(.bottom).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            
                            if subscriptionsLoading {
                                
                                ProgressView().tint(.accent).padding()
                                
                            } else if subscriptionsVisible {
                                
                                ForEach(viewModel.subscriptionsList.indices, id: \.self) { index in
                                    SubscriptionView(subscription: $viewModel.subscriptionsList[index], clickHandler: {
                                        viewModel.selectSubscription(position: index)
                                    })
                                }
                                
                                Text(viewModel.tip).font(.subheadline).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 48)
                            }
                            
                            HStack {
                                Image("logo_1024_rounded").resizable().frame(width: 24, height: 24).clipShape(RoundedRectangle(cornerRadius: 8.0))
                                
                                Text(NSLocalizedString("pro_access_includes", comment: "")).font(.headline).foregroundColor(.text).frame(alignment: .leading).multilineTextAlignment(.leading)
                                
                            }.padding(.bottom, 16)
                            
                            BenefitsView(benefitsId: benefitsId).padding(.bottom, 36)
                            
                            if freeTrialVisible {
                                FreeTrialWorksView(freeTrialStateTwoDay: $viewModel.freeTrialStateTwoDay, freeTrialStateThreeDay: $viewModel.freeTrialStateThreeDay, chargeDate: $viewModel.chargeDate).padding(.bottom)
                            }
                            
                            AiLimitsView().padding(.bottom, 36)
                            
                            Text(NSLocalizedString("have_more_questions", comment: "")).font(.title2).bold().foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding(.bottom, 4)
                            
                            Text(NSLocalizedString("have_more_questions_desc", comment: "")).font(.subheadline).foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
                            
                            ActionButtonView(icon: "paperplane.fill", text: NSLocalizedString("contact_us", comment: ""), clickHandler: {
                                let email = "enpowerapps.presentationmaker@gmail.com"
                                if let url = URL(string: "mailto:\(email)") {
                                  if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url)
                                  } else {
                                    UIApplication.shared.openURL(url)
                                  }
                                }
                            }, addArrow: true).padding(.bottom, 36)
                            
                            Text(NSLocalizedString("additional_links", comment: "")).font(.title2).bold().foregroundColor(.text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center).padding(.bottom)
                            
                            ActionButtonView(icon: "checkmark.shield.fill", text: NSLocalizedString("terms_of_use", comment: ""), clickHandler: {
                                if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                                       UIApplication.shared.open(url)
                                }
                            }, addArrow: true).padding(.bottom, 8)
                            
                            ActionButtonView(icon: "shield.lefthalf.fill", text: NSLocalizedString("privacy_policy", comment: ""), clickHandler: {
                                if let url = URL(string: "https://enpowerappspresent.wixsite.com/presentation-maker/privacy") {
                                       UIApplication.shared.open(url)
                                }
                            }, addArrow: true).padding(.bottom, 36)
                            
                            ActionButtonView(icon: "arrow.uturn.left.circle", text: NSLocalizedString("restore_purchases", comment: ""), clickHandler: {
                                viewModel.restorePurchases()
                            }, addArrow: true).padding(.bottom, 8).padding(.bottom, 120)

                        }.padding().background() {
                            RoundedRectangle(cornerRadius: 20.0).fill(Color.background)
                        }.padding(.top, -24)
                    }
                    
                }.sheet(isPresented: $viewModel.errorDialogShown, onDismiss: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    PurchaseErrorView().presentationDetents([.medium])
                }.sheet(isPresented: $viewModel.successDialogShown, onDismiss: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    PurchaseSuccessView().presentationDetents([.medium])
                }.sheet(isPresented: $viewModel.connectionDialogShown, onDismiss: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    CheckConnectionView(allowOffline: false, type: 1).presentationDetents([.medium])
                }
                
                LinearGradient(gradient: Gradient(colors: [.background.opacity(0.0), .background.opacity(0.8), .background]), startPoint: .top, endPoint: .bottom).frame(height: 160).padding(.bottom, -40).ignoresSafeArea()
                
                VStack {

                    MainButtonView(isSelected: $viewModel.btnMainSelected, progressVisible: $viewModel.purchaseLoading, text: viewModel.btnNextText, clickHandler: {
                        viewModel.startPurchase()
                    })
                    
                    if !btnNextDesc.isEmpty {
                        Text(btnNextDesc).font(.subheadline).foregroundColor(.accent).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).multilineTextAlignment(.center)
                    }
                    
                }.padding(.bottom, 8)
                
            }.onAppear() {
                
                viewModel.updateData(purchaseManager: purchaseManager, benefitsId: benefitsId, source: source)
                
            }.navigationBarTitleDisplayMode(.inline).toolbarBackground(.windowColored).toolbar {
                    
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(NSLocalizedString("close", comment: "")).foregroundColor(.accent)
                    }
                }
                    
                ToolbarItem(placement: .principal) {
                    LabelView(text: NSLocalizedString("pro_access", comment: ""), backColor: .windowColored, textColor: .accent, alignLeft: false)
                }
                
            }.onChange(of: purchaseManager.isPremium) {
                viewModel.handlePurchaseUpdate()
            }.onChange(of: purchaseManager.isCanceled) {
                viewModel.handlePurchaseCanceled()
            }.onChange(of: purchaseManager.isPurchaseError) {
                viewModel.handlePurchaseError()
            }.onChange(of: viewModel.dismissed) {
                presentationMode.wrappedValue.dismiss()
            }.onChange(of: viewModel.plansLoading) {
                withAnimation {
                    subscriptionsLoading = viewModel.plansLoading
                }
            }.onChange(of: viewModel.subscriptionsShown) {
                withAnimation {
                    subscriptionsVisible = viewModel.subscriptionsShown
                }
            }.onChange(of: viewModel.freeTrialVisible) {
                withAnimation {
                    freeTrialVisible = viewModel.freeTrialVisible
                }
            }.onChange(of: viewModel.btnNextDescription) {
                withAnimation {
                    btnNextDesc = viewModel.btnNextDescription
                }
            }
            
        }.tint(.white)
    }
}

#Preview {
    PaywallView(benefitsId: 0, source: "Default").environmentObject(PurchaseManager())
}
