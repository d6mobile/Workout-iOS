//
//  Language.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import UIKit

protocol StringConvertable {
    var stringValue: String { get }
}

enum Language: String {
    private static let databaseKey: String = "Language_Key"
    static let `default`: Language = .english
    
    case english = "en"
    case vietnamese = "vi"
    case chinese = "zh"
    
    init(_ value: String?) {
        let value = (value as NSString?)?.substring(to: 2) ?? ""
        self = Language(rawValue: value) ?? Language.default
    }
    
    static var current: Language {
        guard let identifier = UserDefaults.standard.string(forKey: Language.databaseKey) else {
            return Language(Locale.preferredLanguages.first)
        }
        return Language(identifier)
    }
}

// MARK: - Output
extension Language: StringConvertable {
    var identifier: String { rawValue }
    
    var resourceFile: String {
        switch self {
        case .chinese:
            return "zh-Hant"
        default:
            return rawValue
        }
    }
    
    var stringValue: String {
        switch self {
        case .english:
            return "english_title".localizable
        case .vietnamese:
            return "vietnamese_title".localizable
        case .chinese:
            return "chinese_title".localizable
        }
    }
}

extension Language {
    @discardableResult
    func setToAppLanguage() -> Bool {
        guard self != Language.current else { return true }
        UserDefaults.standard.set(self.rawValue, forKey: Language.databaseKey)
        return UserDefaults.standard.synchronize()
    }
}

