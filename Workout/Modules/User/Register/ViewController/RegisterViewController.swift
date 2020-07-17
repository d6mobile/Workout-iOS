//
//  RegisterViewController.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit
import Alamofire

final class RegisterViewController: UIViewController {
    
    let presenter = RegisterPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configPresenter()
    }
    
    func configPresenter() {
        self.presenter.attachView(view: self)
        self.presenter.registerRequest = RegisterRequest(iUsername: "workout", iEmail: "duy.dang@ntq-solution.com.vn", iPassword: "123456", iGender: 1, iUserType: 11, iPasswordConfirmation: "123456")
        self.presenter.register()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegisterViewController: RegisterViewProtocol {
    func didFinishRegister(message: String?, error: ServiceError?) {
        // error register
        if let err = error {
            print(err.reason ?? "register failed")
            return
        }
        
        print("register: \(message ?? "success")")
    }
}
