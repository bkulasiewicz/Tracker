//
//  FilesDataSource.swift
//  TrackerTests
//
//  Created by Bartosz Kulasiewicz on 14/09/2022.
//

import Foundation
@testable import Tracker

extension FilesDataSource.ReadFileResult: Equatable {
    public static func == (lhs: FilesDataSource.ReadFileResult, rhs: FilesDataSource.ReadFileResult) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
