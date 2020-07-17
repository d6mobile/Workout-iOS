//
//  AppCenter.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

protocol AppCenterProtocol {
    
}

final class AppCenter: AppCenterProtocol {
    
    /// For static instance
    static let shared = AppCenter()
    
    private (set) var mainFrame: MainFrame!
    private (set) var userSession: UserSession!
//    private (set) var apiClient: WebServiceManager!
//    private (set) var chatManager: ChatManagers!
//    private (set) var badgeManager: BadgeManager!
    
    init() {
        
        setupAppCenter()
    }
    
    // MARK: - Private methods
    private func setupAppCenter() {
        
        userSession = UserSession()
        mainFrame = MainFrame()
//        apiClient = WebServiceManager()
//        chatManager = ChatManagers()
//        badgeManager = BadgeManager()
    }
}
