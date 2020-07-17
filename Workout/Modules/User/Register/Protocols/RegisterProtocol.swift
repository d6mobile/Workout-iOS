//
//  RegisterProtocol.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

//MARK: RegisterInputProtocol
protocol RegisterPrensterProtocol: class {
    func register()
    func attachView(view: RegisterViewProtocol?)
}

//MARK: RegisterOutputProtocol
protocol RegisterViewProtocol: class {
    func didFinishRegister(message: String?, error: ServiceError?)
}
