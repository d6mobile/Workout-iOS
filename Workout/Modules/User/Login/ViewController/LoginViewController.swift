//
//  LoginViewController.swift
//  Workout
//
//  Created by ntq on 7/14/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit
 
final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var txflogin: UITextField!
    @IBOutlet private weak var txfPassword: UITextField!
    @IBOutlet private weak var imgkeepLogin: UIImageView!
    
    let presenter = LoginPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configPresenter()
    }
    
    func configPresenter() {
        self.presenter.attachView(view: self)
    }
    
    private func validateInput() -> Bool {
        var isValid = true
        
        if let login = txflogin.text, login.trim().isEmpty {
            isValid = false
        }
        
        if let password = txfPassword.text, password.trim().isEmpty {
            isValid = false
        }
        
        if !isValid {
            AlertView.shared.showAlert(title: "", message: "error_email_or_password_incorrect".localizable, handerLeft: nil, handerRight: nil, title_btn_left: nil, title_btn_right: "OK", viewController: self)
        }
        
        return isValid
    }
    
    // MARK: IBAction
    @IBAction private func loginDidPress() {
        guard validateInput() else {
            return
        }
        
        self.presenter.loginRequest = LoginRequest(iLogin: txflogin.text!, iPassword: txfPassword.text!, iDeviceId: UIDevice.uniqueDeviceIdentifier, iOs: "iOS")
        self.presenter.login()
    }
    
    @IBAction private func keepLoginDidPress() {
        AppCenter.shared.userSession.saveKeepLogin(isSave: !AppCenter.shared.userSession.getKeepLogin())
        imgkeepLogin.image = AppCenter.shared.userSession.getKeepLogin() ? UIImage(named: "check_on") : UIImage(named: "check_off")
    }
}

//MARK: LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func didFinishLogin(error: ServiceError?) {
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        AppCenter.shared.mainFrame.makeMainScreen(window: appDelegate().window ?? UIWindow())

    }
}
