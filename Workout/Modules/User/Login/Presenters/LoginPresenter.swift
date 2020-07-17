//
//  LoginPresenter.swift
//  Workout
//
//  Created by ntq on 7/14/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import Alamofire

struct LoginRequest {
    var login       = ""
    var password    = ""
    var deviceId    = ""
    var os          = ""
    
    init(iLogin: String, iPassword: String, iDeviceId: String, iOs: String) {
        login       = iLogin
        password    = iPassword
        deviceId    = iDeviceId
        os          = iOs
    }
    
    func makeParamsRequest() -> Parameters {
        return [APIKey.login: login,
                APIKey.password: password,
                APIKey.deviceId: deviceId,
                APIKey.os: os]
    }
}

final class LoginPresenter: LoginPresenteProtocol {
    
    weak private var viewPresenter: LoginViewProtocol?
    var loginRequest: LoginRequest?
    var user: User?
    
    func attachView(view: LoginViewProtocol?) {
        viewPresenter = view
    }
    
    func login() {
        guard let model = self.loginRequest else { return }
        let service = WebServiceManager(params: model.makeParamsRequest(), endPointUrl: APIPath.login, method: .post, encoding: JSONEncoding.default)
        ProgressHUD.show()
        service.executeQuery { [weak self] (result: Result<APIParser<User>,Error>)  in
            ProgressHUD.hide()
            switch result {
            case .success(let user):
                self?.user = user.data
                if let data = user.data {
                    AppCenter.shared.userSession.saveUser(data)
                }
                self?.viewPresenter?.didFinishLogin(error: nil)
            case .failure(let error):
                self?.viewPresenter?.didFinishLogin(error: ServiceError(error))
            }
        }
    }
}
