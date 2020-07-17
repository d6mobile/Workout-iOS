//
//  RegisterPresenter.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import Alamofire

struct RegisterRequest {
    
    var username       = ""
    var email          = ""
    var password       = ""
    var gender         = 0
    var userType      = 11
    var passwordConfirmation = ""
    
    init(iUsername: String, iEmail: String, iPassword: String, iGender: Int, iUserType: Int, iPasswordConfirmation: String) {
        username       = iUsername
        email          = iEmail
        password       = iPassword
        gender         = iGender
        userType       = iUserType
        passwordConfirmation = iPasswordConfirmation
    }
    
    func makeParamsRequest() -> Parameters {
        return [APIKey.username: username,
                APIKey.email: email,
                APIKey.password: password,
                APIKey.password_confirmation: passwordConfirmation,
                APIKey.gender: gender,
                APIKey.user_type: userType]
    }
}

final class RegisterPresenter: RegisterPrensterProtocol {
    
    weak private var viewPresenter: RegisterViewProtocol?
    var registerRequest: RegisterRequest?
    
    func attachView(view: RegisterViewProtocol?) {
        viewPresenter = view
    }
    
    func register() {
        guard let model = self.registerRequest else { return }
        let service = WebServiceManager(params: model.makeParamsRequest(), endPointUrl: APIPath.register, method: .post, encoding: JSONEncoding.default)
        ProgressHUD.show()
        service.executeQuery { [weak self] (result: Result<APIParser<EmptyEntity>,Error>)  in
            ProgressHUD.hide()
            switch result {
            case .success(let model):
                self?.viewPresenter?.didFinishRegister(message: model.message ?? "", error: nil)
            case .failure(let error):
                self?.viewPresenter?.didFinishRegister(message: nil, error: ServiceError(error))
            }
        }
    }
}
