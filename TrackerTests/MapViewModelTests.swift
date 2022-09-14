//
//  MapViewModelTests.swift
//  TrackerTests
//
//  Created by Bartosz Kulasiewicz on 13/09/2022.
//

import Foundation
import XCTest
import MapKit
import RxSwift
@testable import Tracker

class MapViewModelTests: XCTestCase {
    func test_init() {
        let sut = makeSUT()
        
        let data = makeFakeData()
        
        expect(sut, expectedValue: data.presentable) {
            sut.display(for: data.coordinates)
        }
    }
}


//MARK: Helpers
extension MapViewModelTests {
    func expect(_ sut: MapViewModel, expectedValue: PresentableGPX, when: () -> Void) {
        let disposeBag = DisposeBag()
        
        let exp = expectation(description: "Waiting for the event")
        
        sut.presentableGPX
            .subscribe(onNext: { receivedValue in
                XCTAssertEqual(receivedValue.start.coordinate, expectedValue.start.coordinate)
                XCTAssertEqual(receivedValue.end.coordinate, expectedValue.end.coordinate)
                XCTAssertEqual(receivedValue.line.coordinate, expectedValue.line.coordinate)
                
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        when()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func makeSUT() -> MapViewModel{
        let sut = MapViewModel()
   
        trackForMemoryLeaks(sut)
        
        return sut
    }
    
    func makeFakeData() -> (coordinates:[CLLocationCoordinate2D], presentable: PresentableGPX) {
        let coordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 23.2, longitude: 24.2),
                                                     CLLocationCoordinate2D(latitude: 24.2, longitude: 21.2),
                                                     CLLocationCoordinate2D(latitude: 25.2, longitude: 20.2)]
        
        let polyLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        guard let startCoordinate = coordinates.first,
              let endCoordinate = coordinates.last else { fatalError() }
        
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = startCoordinate
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = endCoordinate
        
        let presentableGPX = PresentableGPX(line: polyLine, start: startAnnotation, end: endAnnotation)
        
        return (coordinates, presentableGPX)
    }
}




