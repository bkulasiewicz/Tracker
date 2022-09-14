//
//  MapViewModel.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 09/09/2022.
//

import Foundation
import RxSwift
import MapKit

struct PresentableGPX {
    let line: MKPolyline
    let start: MKPointAnnotation
    let end: MKPointAnnotation
}

protocol MapCommander {
    func display(for coordinates: [CLLocationCoordinate2D])
}

protocol MapFeeder {
    var presentableGPX: Observable<PresentableGPX> { get }
}

class MapViewModel: MapCommander, MapFeeder {
    var internalPresentableGPX = PublishSubject<PresentableGPX>()
    
    func display(for coordinates: [CLLocationCoordinate2D]) {
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        guard let startCoordinate = coordinates.first,
              let endCoordinate = coordinates.last else { return }
        
        let startAnnotation = MKPointAnnotation()
        startAnnotation.title = "Start"
        startAnnotation.coordinate = startCoordinate
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.title = "End"
        endAnnotation.coordinate = endCoordinate
        
        internalPresentableGPX.onNext(PresentableGPX(
            line: polyline,
            start: startAnnotation,
            end: endAnnotation))
    }
}

extension MapViewModel {
    var presentableGPX: Observable<PresentableGPX> {
        internalPresentableGPX.asObservable()
    }
}
