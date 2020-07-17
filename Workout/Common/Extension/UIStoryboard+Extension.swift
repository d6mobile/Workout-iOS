//
//  UIStoryboard+Extension.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

protocol Storyboardable {
    static var storyboardName: String { get }
    static var identifier: String { get }
}

extension UIStoryboard {
    static func loadViewController<T: Storyboardable>(_ classType: T.Type) -> T {
        guard let vc = UIStoryboard(name: classType.storyboardName,
                                    bundle: nil).instantiateViewController(withIdentifier: classType.identifier) as? T else {
            fatalError("Cannot instantiate view controller: \(classType.identifier)")
        }
        return vc
    }
}

extension Storyboardable where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

