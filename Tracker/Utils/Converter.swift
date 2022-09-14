//
//  Converter.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 13/09/2022.
//

import Foundation

struct Converter {
    static func knots2kph(_ value: Double) -> Double {
        value * 1.85200
    }
}
