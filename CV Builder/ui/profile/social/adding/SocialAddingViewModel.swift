//
//  SocialAddingViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 27.11.2024.
//

import Foundation

class SocialAddingViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    
    var profile: ProfileEntity?
    
    var selectedMedia = -1
    @Published var link = ""
    @Published var list: [SocialMedia] = []
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateMediaList()
    }
    
    private func updateMediaList () {
        list = PreloadedDatabase.getSocialMedia()
    }
    
    func handleLinkChange () {
        if link.lowercased().contains("linkedin") {
            selectMedia(id: 0)
        } else if link.lowercased().contains("facebook") {
            selectMedia(id: 1)
        } else if link.lowercased().contains("instagram") {
            selectMedia(id: 2)
        } else if link.lowercased().contains("youtube") {
            selectMedia(id: 3)
        } else if link.lowercased().contains("tiktok") {
            selectMedia(id: 4)
        } else if link.lowercased().contains("snapchat") {
            selectMedia(id: 5)
        } else if link.lowercased().contains("x.com") || link.contains("twitter") {
            selectMedia(id: 6)
        } else if link.lowercased().contains("thread") {
            selectMedia(id: 7)
        }
    }
    
    func selectMedia (id: Int) {
        if id != selectedMedia {
            for i in 0...list.count-1 {
                let item = list[i]
                if i == id {
                    item.isSelected = true
                } else {
                    item.isSelected = false
                }
                list[i] = item
            }
            selectedMedia = id
        }
    }
    
    func save () {
        if let profile {
            if !link.isEmpty {
                profileManager.saveSocialMedia(profile: profile, link: link, media: selectedMedia, qrCodeId: -1)
            }
        }
        dismissed = true
    }
}
