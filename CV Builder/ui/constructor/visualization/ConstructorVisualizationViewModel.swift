//
//  ConstructorVisualizationViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 23.11.2024.
//

import Foundation

class ConstructorVisualizationViewModel: ObservableObject {
    
    let cvBuilder = CVBuilder()
    let cvVisualizationBuilder = CVVisualizationBuilder()
    
    var profile: ProfileEntity?
    var style = 0
    var cv: CVEntity?
    var jobTitle = ""
    var company = ""
    var visualization = 0
    
    @Published var wrapper: CVEntityWrapper?
    
    @Published var visualizationList: [VisualizationItem] = []
    @Published var visualizationShown = false
    @Published var isGenerating = false
    @Published var isLoading = false
    @Published var btnMainSelected = false
    
    @Published var header = ""
    @Published var description = ""
    @Published var btnMainText = ""
    
    @Published var errorDialogShown = false
    @Published var goBackDialogShown = false
    @Published var tipDialogShown = false
    
    var previewPage = 0
    @Published var previewSheetShown = false
    
    var parentViewModel: ConstructorViewModel?
    
    func updateData (parentViewModel: ConstructorViewModel) {
        self.parentViewModel = parentViewModel
        getData()
        AnalyticsManager.saveEvent(event: Events.CONSTRUCTOR_VISUALIZATION_OPENED)
        
        Task {
            await startGeneration()
        }
    }
    
    private func getData () {
        if let parentViewModel {
            profile = parentViewModel.profile
            style = parentViewModel.style
            cv = parentViewModel.cv
            jobTitle = parentViewModel.jobTitle
            company = parentViewModel.company
        }
    }
    
    @MainActor
    private func startGeneration () async {
        isGenerating = true
        isLoading = true
        btnMainText = NSLocalizedString("continue", comment: "")
        header = NSLocalizedString("generating_your_cv", comment: "")
        description = NSLocalizedString("couple_minutes_save_hours", comment: "")
        
        await deleteOldCv()
        await createCv()
    }
    
    @MainActor
    private func deleteOldCv () async {
        if let cv {
            cvBuilder.deleteCv(cv: cv)
        }
    }
    
    @MainActor
    private func createCv () async {
        if let profile {
            cv = await cvBuilder.buildCv(profile: profile, styleId: style, targetJob: jobTitle, targetInstitution: company, isFirst: false)
            saveNewCv()
            
//                AiManager.useAttempt()
            
            await createVisualization()
            
        } else {
            errorDialogShown = true
        }
    }
    
    private func saveNewCv () {
        if let parentViewModel {
            parentViewModel.cv = cv
        }
    }
    
    @MainActor
    private func createVisualization () async {
        if let cv {
            let wrappers = cvVisualizationBuilder.createVisualizationsList(style: PreloadedDatabase.getStyleId(id: style), cv: cv)
            
            var list: [VisualizationItem] = []
            if wrappers.count > 0 {
                list.append(VisualizationItem(id: 0, wrapper: wrappers[0], name: wrappers[0].wrapperName, icon: "checkmark.seal.fill", isSelected: true))
            }
            if wrappers.count > 1 {
                list.append(VisualizationItem(id: 1, wrapper: wrappers[1], name: wrappers[1].wrapperName, icon: "checkmark.shield.fill", isSelected: false))
            }
            if wrappers.count > 2 {
                list.append(VisualizationItem(id: 2, wrapper: wrappers[2], name: wrappers[2].wrapperName, icon: "briefcase.fill", isSelected: false))
            }
            if wrappers.count > 3 {
                list.append(VisualizationItem(id: 3, wrapper: wrappers[3], name: wrappers[3].wrapperName, icon: "graduationcap.fill", isSelected: false))
            }
            if wrappers.count > 4 {
                list.append(VisualizationItem(id: 4, wrapper: wrappers[4], name: wrappers[4].wrapperName, icon: "lightbulb.max.fill", isSelected: false))
            }
            
            let position = getWrapperPosition(id: visualization, list: list)
            if position != -1 {
                list[position].isSelected = true
                wrapper = list[position].wrapper
            }
            
            visualizationList = list
            visualizationShown = true
            
            isGenerating = false
            isLoading = false
            btnMainSelected = true
            btnMainText = NSLocalizedString("save_and_edit", comment: "")
            description = NSLocalizedString("explore_visualization", comment: "")
            
        } else {
            errorDialogShown = true
        }
    }
    
    func selectVisualization (id: Int) {
        if id != visualization {
            for i in 0...visualizationList.count-1 {
                let wrapper = visualizationList[i]
                if i == id {
                    wrapper.isSelected = true
                    self.wrapper = wrapper.wrapper
                } else {
                    wrapper.isSelected = false
                }
                visualizationList[i] = wrapper
            }
            visualization = id
        }
    }
    
    func showPreview (page: Int) {
        previewPage = page
        previewSheetShown = true
    }
    
    func backStep () {
        goBackDialogShown = true
    }
    
    func nextStep () {
        if !isLoading && !isGenerating {
            btnMainSelected = false
            isLoading = true
            let position = getWrapperPosition(id: visualization, list: visualizationList)
            if position != -1 {
                saveWrapperToCv(wrapper: visualizationList[position].wrapper)
                close()
            } else {
                errorDialogShown = true
            }
        }
    }
    
    private func saveWrapperToCv (wrapper: CVEntityWrapper) {
        if let cv {
            self.cv = cvBuilder.saveWrapperPagesToEntity(wrapper: wrapper, cv: cv)
            saveNewCv()
        }
    }
    
    private func close () {
        if let parentViewModel {
            parentViewModel.closeSheet()
        }
    }
    
    func showAiTip () {
        tipDialogShown = true
    }
    
    private func getWrapperPosition (id: Int, list: [VisualizationItem]) -> Int {
        for i in 0..<list.count {
            let wrapper = list[i]
            if wrapper.id == id {
                return i
            }
        }
        return -1
    }
}
