//
//  User.swift
//  Workout
//
//  Created by ntq on 7/14/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

class User: Codable {
    var userInfo: UserInfo?
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case userInfo = "user"
        case token
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userInfo, forKey: .userInfo)
        try container.encode(token, forKey: .token)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        userInfo = try? values?.decode(UserInfo.self, forKey: .userInfo)
        token = try? values?.decode(String.self, forKey: .token)
    }
}

class UserInfo: Codable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var gender: Int?
    var birthday: String?
    var userType: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, username, email, gender, birthday, id
        case userType = "user_type"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(gender, forKey: .gender)
        try container.encode(birthday, forKey: .birthday)
        try container.encode(userType, forKey: .userType)
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decode(Int.self, forKey: .id)
        name = try? values?.decode(String.self, forKey: .name)
        username = try? values?.decode(String.self, forKey: .username)
        email = try? values?.decode(String.self, forKey: .email)
        gender = try? values?.decode(Int.self, forKey: .gender)
        birthday = try? values?.decode(String.self, forKey: .birthday)
        userType = try? values?.decode(Int.self, forKey: .userType)
    }
    
    static var codingKey: String {
        return "user"
    }
}

enum Gender: Int {
    case other
    case male
    case female
}
