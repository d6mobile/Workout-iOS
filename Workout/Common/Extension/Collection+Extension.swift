//
//  Collection+Extension.swift
//  Workout
//
//  Created by ntq on 7/17/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

