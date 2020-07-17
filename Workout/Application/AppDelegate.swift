//
//  AppDelegate.swift
//  Workout
//
//  Created by ntq on 7/9/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let wd = self.window {
            AppCenter.shared.mainFrame.makeMainScreenAuthorization(window: wd)
        }
        return true
    }
}

