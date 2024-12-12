//
//  ExportedFile.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 28.11.2024.
//

import Foundation

class ExportedFile {
    
    var format: Int
    var fileName: String
    var fileIcon: String
    var url: URL?
    
    init(format: Int, fileName: String, fileIcon: String, url: URL? = nil) {
        self.format = format
        self.fileName = fileName
        self.fileIcon = fileIcon
        self.url = url
    }
    
    static func getDefault () -> ExportedFile {
        return ExportedFile(format: 0, fileName: "File name", fileIcon: "icon_pdf")
    }
}
