//
//  PresentableGPX.swift
//  TrackerTests
//
//  Created by Bartosz Kulasiewicz on 14/09/2022.
//

import Foundation
@testable import Tracker

extension PresentableGPX: Equatable {
    public static func == (lhs: PresentableGPX, rhs: PresentableGPX) -> Bool {
        lhs.line == rhs.line
    }
}
