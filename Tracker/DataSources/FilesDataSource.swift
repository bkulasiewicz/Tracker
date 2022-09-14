//
//  FilesDataSource.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 08/09/2022.
//

import Foundation

protocol FilesDataSourceFeeder {
    typealias Result = [FilesDataSource.ReadFileResult]
    
    func getFiles() -> Result
}

class FilesDataSource: FilesDataSourceFeeder {
    let fileManager = FileManager.default
    
    struct ReadFileResult {
        let fileName: String
        let data: Data
    }
    
    let fileNames: [String]
    init(fileNames: [String]) {
        self.fileNames = fileNames
    }
    
    func getFiles() -> [ReadFileResult] {
        fileNames
            .compactMap{Bundle.main.url(forResource: $0, withExtension: "gpx")}
            .compactMap{fileManager.contents(atPath: $0.relativePath)}
            .enumerated()
            .map({ReadFileResult(fileName: fileNames[$0], data: $1)})
    }
}
