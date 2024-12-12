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
    
    @Published var visualizationList: [VisualizationItem] = []
    @Published var currentPage = 0
    @Published var isGenerating = false
    @Published var isLoading = false
    @Published var btnMainSelected = false
    
    @Published var isConnectionAvailable = true
    
    @Published var header = ""
    @Published var description = ""
    @Published var btnMainText = ""
    
    @Published var errorDialogShown = false
    @Published var goBackDialogShown = false
    @Published var tipDialogShown = false
    
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
        checkConnection()
        btnMainText = NSLocalizedString("continue", comment: "")
        header = NSLocalizedString("generating_your_cv", comment: "")
        description = NSLocalizedString("couple_minutes_save_hours", comment: "")
        
        await deleteOldCv()
        await createCv()
    }
    
    private func checkConnection () {
        isConnectionAvailable = Reachability.isConnectedToNetwork()
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
            
            if isConnectionAvailable {
//                AiManager.useAttempt()
            }
            
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
            for wrapper in wrappers {
                list.append(VisualizationItem(wrapper: wrapper))
            }
            
            let position = getWrapperPosition(id: visualization, list: list)
            if position != -1 {
                list[position].isSelected = true
                currentPage = visualization
            }
            
            visualizationList = list
            
            isGenerating = false
            isLoading = false
            btnMainSelected = true
            btnMainText = NSLocalizedString("select", comment: "")
            header = NSLocalizedString("select_visualization_header", comment: "")
            description = NSLocalizedString("select_visualization_description", comment: "")
            
        } else {
            errorDialogShown = true
        }
    }
    
    func selectStyle (id: Int) {
        if id != visualization {
            for i in 0...visualizationList.count-1 {
                let wrapper = visualizationList[i]
                if i == id {
                    wrapper.isSelected = true
                } else {
                    wrapper.isSelected = false
                }
                visualizationList[i] = wrapper
            }
            visualization = id
        }
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
