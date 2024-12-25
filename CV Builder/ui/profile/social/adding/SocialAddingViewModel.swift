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
    @Published var mediaName = ""
    @Published var medias: [MenuItem] = []
    
    @Published var dismissed = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateMediaList()
    }
    
    func updateMediaList () {
        var list: [MenuItem] = []
        let media = PreloadedDatabase.getSocialMedia()
        for m in media {
            list.append(MenuItem(id: m.id, name: m.name))
        }
        medias = list
    }
    
    func handleLinkChange () {
        if link.lowercased().contains("linkedin") {
            selectMedia(index: 0)
        } else if link.lowercased().contains("facebook") {
            selectMedia(index: 1)
        } else if link.lowercased().contains("instagram") {
            selectMedia(index: 2)
        } else if link.lowercased().contains("youtube") {
            selectMedia(index: 3)
        } else if link.lowercased().contains("tiktok") {
            selectMedia(index: 4)
        } else if link.lowercased().contains("snapchat") {
            selectMedia(index: 5)
        } else if link.lowercased().contains("x.com") || link.contains("twitter") {
            selectMedia(index: 6)
        } else if link.lowercased().contains("thread") {
            selectMedia(index: 7)
        }
    }
    
    func selectMedia (index: Int) {
        if medias.count > index {
            let menu = medias[index]
            selectedMedia = menu.id
            mediaName = menu.name
        }
    }
    
    func selectMedia (item: MenuItem) {
        selectedMedia = item.id
        mediaName = item.name
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
