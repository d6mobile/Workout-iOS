//
//  LoginProtocol.swift
//  Workout
//
//  Created by ntq on 7/14/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

protocol LoginPresenteProtocol: class {
    func login()
    func attachView(view: LoginViewProtocol?)
}

protocol LoginViewProtocol: class {
    func didFinishLogin(error: ServiceError?)
}
