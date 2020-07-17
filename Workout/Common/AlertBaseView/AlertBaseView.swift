//
//  AlertBaseView.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import UIKit

class AlertView {
    static let shared = AlertView()
    typealias handler = () -> ()

    func genarateMessage(messages: [String]) -> String {
        var displayMessage = ""
        for (i, element) in messages.enumerated() {
            displayMessage = displayMessage + element
            if i < messages.count - 1 {
                
                displayMessage = displayMessage + "\n"
            }
        }
        
        return displayMessage
    }
    
    func showAlert(title: String? = nil, message: String? = nil, handerLeft: handler? = nil, handerRight: handler? = nil, title_btn_left: String? = nil, title_btn_right: String? = nil, viewController: UIViewController? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title_btn_left != nil {
            let okAction = UIAlertAction(title: title_btn_left, style: .default) { (action:UIAlertAction) in
                handerLeft?()
            }
            alertController.addAction(okAction)
        }
        
        if title_btn_right != nil {
            let cancelAction = UIAlertAction(title: title_btn_right, style: .default) { (action:UIAlertAction) in
                handerRight?()
            }
            alertController.addAction(cancelAction)
        }


        if viewController != nil {
            viewController?.present(alertController, animated: true, completion: nil)
        } else {
            appDelegate().window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

