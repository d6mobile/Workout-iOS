//
//  UIViewController+Extension.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import UIKit

typealias Block<T> = (T) -> Void

extension UIViewController {
    
    class func topMostViewController() -> UIViewController? {
        return UIViewController.topViewControllerForRoot(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    class func topViewControllerForRoot(rootViewController:UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        
        if rootViewController is UINavigationController {
            let navigationController:UINavigationController = rootViewController as! UINavigationController
            return UIViewController.topViewControllerForRoot(rootViewController: navigationController.viewControllers.last)
            
        } else if rootViewController is UITabBarController {
            let tabBarController:UITabBarController = rootViewController as! UITabBarController
            return UIViewController.topViewControllerForRoot(rootViewController: tabBarController.selectedViewController)
            
        } else if rootViewController.presentedViewController != nil {
            //            return rootViewController.presentedViewController
            return UIViewController.topViewControllerForRoot(rootViewController: rootViewController.presentedViewController)
        } else {
            return rootViewController
        }
    }
}


