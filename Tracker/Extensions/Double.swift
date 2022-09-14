//
//  Double.swift
//  Tracker
//
//  Created by Bartosz Kulasiewicz on 13/09/2022.
//

import Foundation

extension Double {
    func format2Decimals() -> String {
        return String(format: "%.02f", self)
    }
}
