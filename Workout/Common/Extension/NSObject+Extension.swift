//
//  NSObject+Extension.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
    
    // For Instance of class get name
    var className: String {
        return String(describing: type(of: self))
    }
}

