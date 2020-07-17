//
//  DatabaseManager.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

protocol DatabaseObjectProtocol: class, NSCoding {
    static var databaseKey: String { get }
}

extension DatabaseObjectProtocol {
    @discardableResult
    func saveToDB() -> Bool {
        return DatabaseManager.shared.save(self)
    }
    
    static func loadFromDB() -> Self? {
        return DatabaseManager.shared.load()
    }
}

class DatabaseManager {
    private let db = UserDefaults.standard
    init() {}
    static let shared = DatabaseManager()
}

extension DatabaseManager {
    @discardableResult
    func save<T: DatabaseObjectProtocol>(_ object: T) -> Bool {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
        db.set(encodedData, forKey: T.databaseKey)
        return db.synchronize()
    }
    
    func load<T: DatabaseObjectProtocol>() -> T? {
        guard let decoded  = db.data(forKey: T.databaseKey) else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? T
    }
}

//extension DatabaseManager {
//    /// clear Authorization infomation
//    @discardableResult
//    func logout() -> Bool {
//        db.removeObject(forKey: Authorization.databaseKey)
//        let result = db.synchronize()
//        ObserCenter.shared.post(key: .userDidLoginOrLogout, object: nil)
//        return result
//    }
//    
//    @discardableResult
//    func clear() -> Bool {
//        guard let bundleID = Bundle.main.bundleIdentifier else { return false }
//        db.removePersistentDomain(forName: bundleID)
//        return true
//    }
//}

