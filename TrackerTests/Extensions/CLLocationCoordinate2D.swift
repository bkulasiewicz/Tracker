//
//  CLLocation2Coordinate .swift
//  TrackerTests
//
//  Created by Bartosz Kulasiewicz on 14/09/2022.
//

import Foundation
@testable import Tracker
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
