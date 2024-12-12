//
//  CertificatesCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation

class CertificatesCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var certificatesList: [CertificateItem] = []
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        Task {
            await updateList()
        }
    }
    
    @MainActor
    private func updateList () async {
        var list: [CertificateItem] = []
        
        if let profile, let certificates = profile.certificatesList {
            for certificate in certificates {
                list.append(CertificateItem(entity: certificate))
            }
        }
        
        certificatesList = list.sorted(by: { $0.position < $1.position })
    }
    
    func addCertificate () {
        if let profile {
            let certificate = profileManager.saveCertificate(profile: profile)
            let item = CertificateItem(entity: certificate)
            certificatesList.append(item)
        }
    }
    
    func deleteCertificate (index: Int) {
        if let profile, index != -1 {
            let certificate = certificatesList[index]
            profileManager.deleteCertificate(profile: profile, certificate: certificate.entity)
            certificatesList.remove(at: index)
        }
    }
    
    func handleItemsMoved () {
        if certificatesList.count > 1 {
            for i in 0..<certificatesList.count {
                let certificate = certificatesList[i]
                certificate.position = i
                certificatesList[i] = certificate
            }
        }
    }
    
    func save () {
        for item in certificatesList {
            profileManager.updateCertificate(certificate: item.entity, name: item.name, position: item.position)
        }
    }
}
