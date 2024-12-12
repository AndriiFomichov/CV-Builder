//
//  WorkCategoryViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 26.11.2024.
//

import Foundation

class WorkCategoryViewModel: ObservableObject {
    
    let profileManager = ProfileManager()
    var profile: ProfileEntity?
    
    @Published var workList: [WorkItem] = []
    @Published var selectedWork: WorkEntity?
    @Published var workAddingSheetShown = false
    
    @Published var guideSheetShown = false
    
    func updateData (profile: ProfileEntity?) {
        self.profile = profile
        updateWorkList()
    }
    
    func updateWorkList () {
        var list: [WorkItem] = []
        
        if let profile, let worksList = profile.worksList {
            for work in worksList {
                list.append(WorkItem(entity: work))
            }
        }
        
        workList = list.sorted(by: { $0.position < $1.position })
    }
    
    func deleteWork (work: WorkEntity?, index: Int) {
        if let profile, let work {
            profileManager.deleteWork(profile: profile, work: work)
            workList.remove(at: index)
        }
    }
    
    func handleItemsMoved () {
        if workList.count > 1 {
            for i in 0..<workList.count {
                let item = workList[i]
                item.position = i
                workList[i] = item
                
                item.entity.position = item.position
            }
            DatabaseBox.saveContext()
        }
    }
    
    func showWorkAdding (work: WorkEntity?) {
        selectedWork = work
        workAddingSheetShown = true
    }
    
    func showGuide () {
        guideSheetShown = true
    }
}
