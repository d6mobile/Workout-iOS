//
//  BaseNaviController.swift
//  Workout
//
//  Created by ntq on 7/15/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import UIKit

protocol BaseNaviControllerProtocol {
    
}

class BaseNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNaviController()
    }
    
    private func setupNaviController() {
        navigationBar.isTranslucent = true
        navigationBar.prefersLargeTitles = true
    }
}
