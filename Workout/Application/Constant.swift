//
//  Constant.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

enum InfoPlistKey: String {
    case appName = "PRODUCT_NAME"
    case bundleIdentifier = "PRODUCT_BUNDLE_IDENTIFIER"
    case baseAPIUrl = "API_SERVER"
    case apiProtocol = "API_PROTOCOL"
    // MARK: - Config login social
    case facebookAppID = "FacebookAppID"
    case twitterConsumerKey = "TwitterConsumerKey"
    case twitterConsumerSecret = "TwitterConsumerSecret"
    case googleAppID = "GoogleAppID"
    case googleClientId = "GoogleClientId"
    case tencentAppID = "TencentAppID"
    case wechatAppID = "WechatAppID"
    case weiboAppID = "WeiboAppID"
    
    // get from .xcconfig
    var value: String? {
        return Bundle.main.infoDictionary?[self.rawValue] as? String
    }
}

struct UserDefaultKey {
    static let user                      =           "User"
    static let keepSessionLogin          =           "KeepSessionLogin"
    static let saveTouchIDLogin          =           "saveTouchIDLogin"
}

struct APIPath {
    static let register                  =           "register"
    static let login                     =           "login"
    static let logout                    =           "logout"
    static let products                  =           "products"
}

enum APIStatusCode: Int {

    case success = 200
    case invalidToken = 401
}

struct APIKey {
    static let locale                    =           "locale"
    static let authorization             =           "Authorization"
    static let content_Type              =           "Content-Type"
    static let timezone                  =           "timezone"
    static let token                     =           "token"
    static let name                      =           "name"
    static let username                  =           "username"
    static let email                     =           "email"
    static let password                  =           "password"
    static let messages                  =           "messages"
    static let password_confirmation     =           "password_confirmation"
    static let code                      =           "code"
    static let data                      =           "data"
    static let message                   =           "message"
    static let login                     =           "login"
    static let gender                    =           "gender"
    static let user_type                 =           "user_type"
    static let deviceId                  =           "device_id"
    static let os                        =           "os"
    static let price                     =           "price"
    static let quantity                  =           "quantity"
}
