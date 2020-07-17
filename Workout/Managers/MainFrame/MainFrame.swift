//
//  MainFrame.swift
//  Workout
//
//  Created by ntq on 7/13/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import UIKit

protocol MainFrameProtocol {
    
    func makeMainScreen(window: UIWindow)
}

final class MainFrame: MainFrameProtocol {
    
    
    func makeMainScreen(window: UIWindow) {
        let tabbar = UITabBarController()
        let homeVC: HomeViewController = HomeViewController(nibName: HomeViewController.className, bundle: nil)
        let naviHome = BaseNaviController(rootViewController: homeVC)
        let tabbarItemHome = UITabBarItem(title: "screen_home".localizable, image: nil, selectedImage: nil)
        naviHome.tabBarItem = tabbarItemHome
        naviHome.navigationBar.topItem?.title = "screen_home".localizable
        tabbar.viewControllers = [naviHome]
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
    }
    
    func makeMainScreenAuthorization(window: UIWindow) {
        if AppCenter.shared.userSession.isAuthenticated, AppCenter.shared.userSession.getKeepLogin() {
            makeMainScreen(window: window)
        } else {
            let loginVC: LoginViewController = LoginViewController(nibName: LoginViewController.className, bundle: nil)
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }
}

