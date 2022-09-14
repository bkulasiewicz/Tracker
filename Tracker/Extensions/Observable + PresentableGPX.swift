//
//  Observable + PresentableGPX.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 13/09/2022.
//

import Foundation
import RxSwift
import MapKit

extension Observable where Element == PresentableGPX {
    func start(in action: @escaping (MKAnnotation) -> ()) -> Observable<PresentableGPX> {
        map { presentableGPX in
            action(presentableGPX.start)
            return presentableGPX
        }
    }
    func end(in action: @escaping (MKAnnotation) -> ()) -> Observable<PresentableGPX> {
        map { presentableGPX in
            action(presentableGPX.end)
            return presentableGPX
        }
    }
    
    func line(in action: @escaping (MKPolyline) -> ()) -> Observable<PresentableGPX> {
        map { presentableGPX in
            action(presentableGPX.line)
            return presentableGPX
        }
    }
}
