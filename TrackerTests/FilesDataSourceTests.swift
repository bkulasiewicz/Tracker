//
//  FilesDataSourceTests.swift
//  TrackerTests
//
//  Created by Bartosz Kulasiewicz on 13/09/2022.
//

import XCTest
@testable import Tracker

class FilesDataSourceTests: XCTestCase {
    enum FileNames {
        static var proper = "test-gpx-file"
        static var wrong = "wrong-fileName"
    }
    
    func test_emptyResult_onWrongFileName() {
        let sut = makeSUT(fileName: FileNames.wrong)
       
        expect(sut, expectedValue: [])
    }
    
    func test_notEmptyResult_onProperFileName() {
        let sut = makeSUT(fileName: FileNames.proper)
       
        expectNotNil(sut)
    }
}

//MARK: Helpers
extension FilesDataSourceTests {
    func expect(_ sut: FilesDataSource, expectedValue: [FilesDataSource.ReadFileResult]) {
        let receivedValues = sut.getFiles()
        
        XCTAssertEqual(receivedValues, expectedValue)
    }
    
    func expectNotNil(_ sut: FilesDataSource) {
        let receivedValues = sut.getFiles()
        
        XCTAssertNotNil(receivedValues)
    }
    
    func makeSUT(fileName: String) -> FilesDataSource{
        let sut = FilesDataSource(fileNames: [fileName])
        
        trackForMemoryLeaks(sut)
        
        return sut
    }
}


