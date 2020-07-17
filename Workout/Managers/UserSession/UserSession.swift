//
//  UserSession.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit
import KeychainAccess
import UserNotifications

protocol UserSessionProtocol {
    
}

final class UserSession: UserSessionProtocol {
    
    struct KeychainKey {
        
        static let AccessToken = "AccessToken"
        static let UserId = "UserId"
        static let Login = "Login"
        static let password = "Password"
    }
    
    init() {
        if let saveUser = UserDefaults.standard.object(forKey: UserDefaultKey.user) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: saveUser) {
                self.user = loadedUser
            }
        }
    }

    var isAuthenticated: Bool {
        return accessToken() != nil
    }

    let keychain = Keychain(service: AppInfo.bundleId())
    private(set) var user: User? {
        didSet {
            if let user = user {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(user) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: UserDefaultKey.user)
                }
            } else {
                UserDefaults.standard.removeObject(forKey: UserDefaultKey.user)
            }
            
            UserDefaults.standard.synchronize()
        }
    }


    func userId() -> Int? {
        if let keychainValue = keychain[KeychainKey.UserId], let value = Int(keychainValue) {
            return value
        }

        return nil
    }
    
//    func avatar() -> String? {
//        if let url = self.user?.userInfo?.avatar {
//            return url
//        }
//
//        return nil
//    }
    
    func loginId() -> String? {
        if let keychainValue = keychain[KeychainKey.Login] {
            return keychainValue
        }

        return nil
    }
    
//    func activeTemp() -> Bool? {
//        if let active = UserDefaults.standard.value(forKey: UserDefaultKey.dfActive) as? Bool {
//            return active
//        }
//
//        return nil
//    }
    
    
//    func password() -> String? {
//
//        if let keychainValue = keychain[KeychainKey.password] {
//
//            return keychainValue
//        }
//
//        return nil
//    }
    
//
    func accessToken() -> String? {
        return keychain[KeychainKey.AccessToken]
    }
    
//   
    func saveUser(_ user: User) {
        self.user = user
        self.saveToken(user.token ?? "")
        self.saveUserID(user.userInfo?.id ?? 0)
        self.saveUsername(user.userInfo?.username ?? "")

    }
    
    func saveKeepLogin(isSave: Bool) {
        UserDefaults.standard.set(isSave, forKey: UserDefaultKey.keepSessionLogin)
        UserDefaults.standard.synchronize()
    }
    
    func saveTouchIDForLogin(isSave: Bool) {
        UserDefaults.standard.set(isSave, forKey: UserDefaultKey.saveTouchIDLogin)
        UserDefaults.standard.synchronize()
    }
    
    func getTouchIDForLogin() -> Bool? {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.saveTouchIDLogin)
    }

    func getKeepLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.keepSessionLogin)
    }
//    
//    func savePassword(_ password: String) {
//        keychain[KeychainKey.password] = password
//    }
//    
    func logout() {
        
        guard let _ = accessToken() else { return }

        if getKeepLogin() {
            AppCenter.shared.userSession.saveKeepLogin(isSave: false)
        }
        
        if AppCenter.shared.userSession.isAuthenticated {
//            NotificationService().unRegisterDevice()
        }
        
        if let _ = accessToken() {
            WebServiceManager.logout()
        }

//        AppCenter.shared.chatManager.disconnect()
        
        user = nil
        keychain[KeychainKey.AccessToken] = nil
        keychain[KeychainKey.UserId] = nil
        
        if let touchID = getTouchIDForLogin(), touchID {
            // TODO: Later
        } else {
            keychain[KeychainKey.Login] = nil
            keychain[KeychainKey.password] = nil
        }
        
//        clearRemoteNotification()
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.keepSessionLogin)
        UserDefaults.standard.synchronize()

    }
//    
//    func clearDataActiveTemp() {
//        
//        UserDefaults.standard.removeObject(forKey: UserDefaultKey.dfActive)
//        UserDefaults.standard.synchronize()
//    }
//    
//    func clearData() {
//        
//        UserDefaults.standard.removeObject(forKey: UserDefaultKey.dfKeepSessionLogin)
//        UserDefaults.standard.removeObject(forKey: UserDefaultKey.dfSaveTouchIDLogin)
//        UserDefaults.standard.synchronize()
//    }
//
//    func logoutMenu() {
//        
//        guard let _ = accessToken() else { return }
//        
//        if let _ = accessToken() {
//            UserService().logout()
//        }
//        AppCenter.shared.chatManager.disconnect()
//        user = nil
//        keychain[KeychainKey.AccessToken] = nil
//        keychain[KeychainKey.UserId] = nil
//        keychain[KeychainKey.LoginId] = nil
//        keychain[KeychainKey.password] = nil
//        
//        UserDefaults.standard.removeObject(forKey: UserDefaultKey.dfKeepSessionLogin)
//        UserDefaults.standard.removeObject(forKey: UserDefaultKey.dfSaveTouchIDLogin)
//        UserDefaults.standard.synchronize()
//        clearRemoteNotification()
//    }
//    
    private func saveToken(_ token: String) {
        keychain[KeychainKey.AccessToken] = token
    }

    private func saveUserID(_ userID: Int) {
        keychain[KeychainKey.UserId] = "\(userID)"
    }
    
    private func saveUsername(_ login: String) {
        keychain[KeychainKey.Login] = login
    }
//    
//    func clearRemoteNotification() {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.removeAllDeliveredNotifications()
//    }
}

// MARK: - Process Role
//extension CFUserSession {
//
//    func isStaff() -> Bool {
//        guard let _ = self.user?.staffRole else { return false }
//        return true
//    }
//
//    func getStaff() -> StaffRoleModel? {
//        return user?.staffRole
//    }
//
//    func getStudent() -> StudentInfoModel? {
//        return user?.studentInfo
//    }
//
//    func getStaffRole() -> LoginStaffRole {
//        guard let staffModel = self.user?.staffRole else { return .justViewer }
//        return staffModel.eRole
//    }
//
//    func getStaffRoleMaster() -> LoginStaffRoleMaster {
//        guard let staffModel = self.user?.staffRole else { return .materMenuDisable }
//        return staffModel.eRole_master
//    }
//
//    func checkPermissionToDownload() -> Bool {
//        guard let staffModel = self.user?.staffRole else { return false }
//        return staffModel.eRole == .justB || staffModel.eRole == .justAdmin
//    }
//
//    func checkPermissionToDownload101() -> Bool {
//        guard let staffModel = self.user?.staffRole else { return false }
//        return staffModel.eRole == .justA || staffModel.eRole == .justB || staffModel.eRole == .justAdmin
//    }
//
//    func isStudent() -> Bool {
//        guard let type = self.user?.userType else { return false }
//
//        return type == .student || type == .remote_student
//    }
//
//}
