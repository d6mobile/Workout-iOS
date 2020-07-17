//
//  Device.swift
//  Workout
//
//  Created by ntq on 7/15/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess
extension UIDevice {
    static var uniqueDeviceIdentifier: String = {
        let keychain = Keychain().accessibility(.always)
        
        let keyName = "UniqueDeviceIdentifier"
        
        if let uniqueDeviceIdentifier = keychain[keyName] {
            return uniqueDeviceIdentifier
        } else {
            let uniqueDeviceIdentifier = UUID().uuidString
            keychain[keyName] = uniqueDeviceIdentifier
            return uniqueDeviceIdentifier
        }
    }()
    
    static var isPad: Bool = {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
    }()
    
    static var isPhone3_5in: Bool = {
        return UIScreen.main.bounds.size.width == 320 && UIScreen.main.bounds.size.height == 480
    }()
    
    static var isPhone4in: Bool = {
        return UIScreen.main.bounds.size.width == 320 && UIScreen.main.bounds.size.height == 568
    }()
    
    static var isPhone4_7in: Bool = {
        return UIScreen.main.bounds.size.width == 375
    }()
    
    static var isPhone5_5in: Bool = {
        return UIScreen.main.bounds.size.width == 414
    }()
    
    static var isPhoneX: Bool = {
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width
        let height = screenSize.height
        return min(width, height) == 375 && max(width, height) == 812
    }()
}

