//
//  EditorDesignViewModel.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 29.11.2024.
//

import Foundation

class EditorDesignViewModel: ObservableObject {
    
    let cvBuilder = CVBuilder()
    
    var cv: CVEntity?
    
    @Published var styles: [Style] = []
    @Published var colors: [ColorItem] = []
    @Published var fontHeaders: String?
    @Published var fontText: String?
    @Published var headersSize = 1
    @Published var textSize = 1
    @Published var marginsSize = 1
    
    var initialFontId = -1
    var fontType = 0
    @Published var fontSheetShown = false
    
    var parentViewModel: EditorViewModel?
    
    func updateData (parentViewModel: EditorViewModel) {
        self.parentViewModel = parentViewModel
        self.cv = parentViewModel.cv
        getData()
    }
    
    private func getData () {
        Task {
            await updateStylesList()
        }
        updateColorsList()
        updateFonts()
        updateMargins()
    }
    
    @MainActor
    private func updateStylesList () async {
        let styles: [Style] = PreloadedDatabase.getStyles()
        
        if let cv {
            let position = getStylePosition(id: cv.style, list: styles)
            if position != -1 {
                styles[position].isSelected = true
            }
        }
        
        self.styles = styles
    }
    
    private func updateColorsList () {
        var colors: [ColorItem] = []
        
        if let cv {
            let currentStyle = PreloadedDatabase.getStyleId(id: cv.style)
            
            for i in 0..<currentStyle.palettes.count {
                let palette = currentStyle.palettes[i]
                colors.append(ColorItem(id: 0, palette: palette, isSelected: cv.mainColor == palette.mainColor))
            }
        }
        
        self.colors = colors
    }
    
    private func updateFonts () {
        if let cv {
            let headersFont = PreloadedDatabase.getFontId(id: cv.headersFont)
            let textFont = PreloadedDatabase.getFontId(id: cv.textFont)
            
            fontHeaders = NSLocalizedString(headersFont.name, comment: "")
            fontText = NSLocalizedString(textFont.name, comment: "")
            
            self.headersSize = cv.headersSize
            self.textSize = cv.textSize
        }
    }
    
    private func updateMargins () {
        if let cv {
            self.marginsSize = cv.marginsSize
        }
    }
    
    func selectStyle (index: Int) {
        if let cv {
            let style = styles[index]
            if style.id != cv.style {
                
                let position = getStylePosition(id: cv.style, list: styles)
                if position != -1 {
                    styles[position].isSelected = false
                }
                
                style.isSelected = true
                
                updateStyle(cv: cv, style: style)
            }
        }
    }
    
    private func updateStyle (cv: CVEntity, style: Style) {
        cvBuilder.updateCvStyle(cv: cv, style: style)
        updatePreview()
        getData()
    }
    
    func selectColor (index: Int) {
        if index >= 0 && index < colors.count {
            if let cv {
                let color = colors[index]
                
                cvBuilder.updateCvPalette(cv: cv, palette: color.palette)
                
                for color in colors {
                    if color.palette.mainColor == cv.mainColor {
                        color.isSelected = true
                    } else {
                        color.isSelected = false
                    }
                }
                
                updatePreview()
            }
        }
    }
    
    func showFontSheet (type: Int) {
        if let cv {
            fontType = type
            if type == 0 {
                initialFontId = cv.headersFont
            } else if type == 1 {
                initialFontId = cv.textFont
            }
            fontSheetShown = true
        }
    }
    
    func handleFontSelection (id: Int) {
        if let cv {
            if fontType == 0 {
                if cv.headersFont != id {
                    cv.headersFont = id
                    updatePreview()
                    updateFonts()
                }
            } else if fontType == 1 {
                if cv.textFont != id {
                    cv.textFont = id
                    updatePreview()
                    updateFonts()
                }
            }
        }
    }
    
    func handleHeaderSizeChanged () {
        if let cv {
            cv.headersSize = headersSize
            updatePreview()
        }
    }
    
    func handleTextSizeChanged () {
        if let cv {
            cv.textSize = textSize
            updatePreview()
        }
    }
    
    func handleMarginsSizeChanged () {
        if let cv {
            cv.marginsSize = marginsSize
            updatePreview()
        }
    }
    
    private func updatePreview () {
        DatabaseBox.saveContext()
        if let parentViewModel {
            parentViewModel.updatePreview()
        }
    }
    
    func back() {
        if let parentViewModel {
            parentViewModel.updateState(state: 0)
        }
    }
    
    private func getStylePosition (id: Int, list: [Style]) -> Int {
        for i in 0..<list.count {
            let style = list[i]
            if style.id == id {
                return i
            }
        }
        return -1
    }
}
