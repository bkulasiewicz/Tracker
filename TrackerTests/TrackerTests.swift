////
////  TrackerTests.swift
////  TrackerTests
////
////  Created by Bartosz Kulasiewicz on 08/09/2022.
////
//
//import XCTest
//@testable import Tracker
//
//class TrackerTests: XCTestCase {
//    func test_emptyResult() {
//        let sut = makeSUT(fileName: "wrong-fileName")
//       
//        expectError(sut)
//    }
//    
//    func expectError(_ sut: FilesViewModel) {
//        switch sut.loadData() {
//        case let .failure(error):
//            XCTAssertNotNil(error)
//            
//        case let .success(value):
//            
//            break
//            
//
//        }
//    }
//
//    func makeSUT(fileName: String) -> FilesViewModel{
//        let filesDataSource = FilesDataSource(fileNames: [fileName])
//        let gpxReader = GPXFileReader()
//        let mapViewModel = MapViewModel()
//        let sut = FilesViewModel(filesDataSource: filesDataSource,
//                                 gpxReader: gpxReader,
//                                 mapCommander: mapViewModel)
//        
//        return sut
//    }
//}
//
////class GPXReaderSpy: GPXReader {
////    func read(_ data: Data) -> GPXFileReader.GPXData? {
////        return GPXFileReader.GPXData(coordinates: <#T##[GPXFileReader.GPXData.Coordinate]#>,
////                                     speed: <#T##[String]#>)    }
////}
