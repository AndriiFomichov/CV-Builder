//
//  SideMenuView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 25.11.2024.
//

import SwiftUI
import UIKit
import StoreKit

struct SideMenuView: View {
    
    @Binding var userName: String
    @Binding var userPhoto: UIImage?
    @Binding var userProfileFill: CGFloat
    @Binding var isPremium: Bool
    
    @StateObject var viewModel = SideMenuViewModel()
    
    @Environment(\.requestReview) var requestReview
    
    @State var isPremiumState = false
    @State var nameState = ""
    @State var photoState: UIImage?
    @State var fillState: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            VStack (spacing: 0) {
                
                Button (action: {
                    viewModel.openProfileSheet()
                }) {
                    ZStack {
                        if isPremium {
                            LinearGradient(gradient: Gradient(colors: [.accentDarker, .accent]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                        } else {
                            Color.window.ignoresSafeArea()
                        }
                        
                        HStack (spacing: 0) {
                            
                            ZStack {
                                
                                Rectangle().fill(isPremiumState ? .accentLight : .window)
                                
                                if let photoState {
                                    Image(uiImage: photoState).centerCropped()
                                } else {
                                    Image(systemName: "photo").font(.headline).foregroundStyle(isPremiumState ? .white : .accent)
                                }
                                
                            }.clipShape(RoundedRectangle(cornerRadius: 16.0)).padding(6).background {
                                
                                RoundedRectangle(cornerRadius: 20.0).fill(isPremiumState ? .accent : .windowTwo)
                                
                            }.frame(width: 84, height: 84)
                            
                            VStack (spacing: 0) {
                                Text(nameState.isEmpty ? NSLocalizedString("user_name", comment: "") : nameState).font(.title2).bold().foregroundStyle(isPremiumState ? .white : .text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).lineLimit(1).padding(.horizontal, 3)
                                
                                HStack {
                                    Button (action: {
                                        viewModel.openSubscriptionsList()
                                    }) {
                                        LabelView(text: isPremiumState ? NSLocalizedString("premium_plan", comment: "") : NSLocalizedString("free_plan", comment: ""), backColor: isPremiumState ? .accent : .windowTwo, textColor: isPremiumState ? .white : .text)
                                    }
                                }.padding(.top, 8)
                                
                            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding(.horizontal, 8)
                            
                            CircleProgressView(progress: fillState, backColor: isPremiumState ? .white : .windowTwo, progressColor: .accent, textColor: isPremiumState ? .white : .text, font: .subheadline).frame(maxHeight: 64)
                            
                        }.padding()
                        
                    }
                }.frame(height: 120)
                
                Color.backgroundDark.frame(height: 2)
                
                ScrollView (showsIndicators: false) {
                    
                    VStack {
                        ActionButtonView(icon: "person.crop.circle", text: NSLocalizedString("edit_profile", comment: ""), clickHandler: {
                            viewModel.openProfileSheet()
                        }, addArrow: true).padding(.horizontal).padding(.top).padding(.bottom, 8)
                        
                        ActionButtonView(icon: "crown.fill", text: NSLocalizedString("manage_subscriptions", comment: ""), clickHandler: {
                            viewModel.openSubscriptionsList()
                        }, addArrow: true).padding(.horizontal).padding(.bottom, 8)
                        
                        ActionButtonView(icon: "checkmark.shield.fill", text: NSLocalizedString("privacy_policy", comment: ""), clickHandler: {
                            openLink(link: "https://enpowerappspresent.wixsite.com/presentation-maker/privacy")
                        }, addArrow: true).padding(.horizontal).padding(.bottom, 8)
                        
                        ActionButtonView(icon: "checkmark.seal.fill", text: NSLocalizedString("rights", comment: ""), clickHandler: {
                            viewModel.showRightsSheet()
                        }, addArrow: true).padding(.horizontal).padding(.bottom, 8)
                        
                        ShareLink(item: URL(string: "https://apps.apple.com/us/app/slidey-ai-presentation-slides/id6636490350")!) {
                            HStack (spacing: 0) {
                                
                                ZStack {
                                    
                                    Image(systemName: "square.and.arrow.up.fill").font(.headline).foregroundStyle(.accent)
                                    
                                }.frame(width: 42, height: 42).background() {
                                    RoundedRectangle(cornerRadius: 32.0).fill(.windowTwo)
                                }.padding(8)
                                
                                Text(NSLocalizedString("share_app", comment: "")).font(.subheadline).foregroundStyle(.text).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading).padding(.trailing, 4).padding(.vertical, 4).lineLimit(2)
                                
                                Image(systemName: "chevron.right").foregroundStyle(.textAdditional).font(.subheadline).padding(.trailing)
                                
                            }.frame(maxWidth: .infinity).background() {
                                RoundedRectangle(cornerRadius: 32.0).fill(Color.window)
                            }
                        }.padding(.horizontal).padding(.bottom, 8)
                        
                        ActionButtonView(icon: "paperplane.fill", text: NSLocalizedString("contact_us", comment: ""), clickHandler: {
                            let email = "enpowerapps.presentationmaker@gmail.com"
                            if let url = URL(string: "mailto:\(email)") {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url)
                                } else {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        }, addArrow: true).padding(.horizontal).padding(.bottom, 8)
                        
                        ActionButtonView(icon: "star.fill", text: NSLocalizedString("rate_us", comment: ""), clickHandler: {
                            requestReview()
                        }, addArrow: true).padding(.horizontal).padding(.bottom, 8)
                        
                        ActionButtonView(icon: "instagram_icon", text: NSLocalizedString("our_instagram", comment: ""), clickHandler: {
                            openLink(link: "https://www.instagram.com/enpower_apps")
                        }, addArrow: true, isIconSystem: false).padding(.horizontal).padding(.bottom, 8)
                        
                        ActionButtonView(icon: "facebook_icon", text: NSLocalizedString("our_facebook", comment: ""), clickHandler: {
                            openLink(link: "https://www.facebook.com/groups/921211245533804")
                        }, addArrow: true, isIconSystem: false).padding(.horizontal).padding(.bottom)
                        
                        Text(viewModel.version).font(.subheadline).foregroundStyle(Color.textAdditional).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                    }
                }
                
            }.sheet(isPresented: $viewModel.paywallSheetShown, onDismiss: {
                viewModel.handlePaywallSheetShown()
            }) {
                PaywallView(benefitsId: 0, source: "Side menu").presentationDetents([.large])
            }.sheet(isPresented: $viewModel.profileSheetShown, onDismiss: {
                viewModel.handleProfileSheetShown()
            }) {
                ProfileView().presentationDetents([.large])
            }.sheet(isPresented: $viewModel.rightsSheetShown) {
                RightsView().presentationDetents([.large])
            }.onAppear() {
                isPremiumState = isPremium
                nameState = userName
                photoState = userPhoto
                fillState = userProfileFill
            }.onChange(of: viewModel.isPremiumSide) {
                isPremium = viewModel.isPremiumSide
                withAnimation {
                    isPremiumState = isPremium
                }
            }.onChange(of: isPremium) {
                withAnimation {
                    isPremiumState = isPremium
                }
            }.onChange(of: viewModel.userNameSide) {
                userName = viewModel.userNameSide
                withAnimation {
                    nameState = userName
                }
            }.onChange(of: userName) {
                withAnimation {
                    nameState = userName
                }
            }.onChange(of: viewModel.userPhotoSide) {
                userPhoto = viewModel.userPhotoSide
                withAnimation {
                    photoState = userPhoto
                }
            }.onChange(of: userPhoto) {
                withAnimation {
                    photoState = userPhoto
                }
            }.onChange(of: viewModel.userFillSide) {
                userProfileFill = viewModel.userFillSide
                withAnimation {
                    fillState = userProfileFill
                }
            }.onChange(of: userProfileFill) {
                withAnimation {
                    fillState = userProfileFill
                }
            }
            
        }.onAppear() {
            viewModel.updateData()
        }
    }
    
    private func openLink (link: String) {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    SideMenuView(userName: .constant("Name"), userPhoto: .constant(nil), userProfileFill: .constant(0.2), isPremium: .constant(false))
}
