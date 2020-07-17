//
//  ProgressHUD.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
}

private var loadingCount = 0
struct ProgressHUD {

    static func show() {
        loadingCount += 1
        let size = CGSize(width: 20, height: 20)
        UIViewController().startAnimating(size, type: .lineSpinFadeLoader, color: .gray, backgroundColor: .clear)
    }
    
    static func hide() {
        loadingCount -= 1
        if loadingCount <= 0 {
            UIViewController().stopAnimating()
        }
    }
}
