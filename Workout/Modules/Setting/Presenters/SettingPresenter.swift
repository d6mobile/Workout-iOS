//
//  SettingPresenter.swift
//  Workout
//
//  Created by ntq on 7/16/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import Alamofire

final class SettingPresenter: SettingPresenteProtocol {
    
    weak private var viewPresenter: SettingViewProtocol?
    
    func attachView(view: SettingViewProtocol?) {
        viewPresenter = view
    }
}
