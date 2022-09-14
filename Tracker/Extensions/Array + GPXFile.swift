//
//  Array + GPXFileContent.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 14/09/2022.
//

import Foundation

extension Array where Element == FilesViewModel.GPXFile {
    func cellViewModel() -> [FileCellViewModel] {
        map {
            FileCellViewModel(fileName: $0.fileName,
                              averageSpeed: "\($0.content.averageSpeed.format2Decimals()) km/h")
        }
    }
}
