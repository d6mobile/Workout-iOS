//
//  APIParser.swift
//  Workout
//
//  Created by ntq on 7/10/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

struct APIParser<T: Decodable>: Decodable {
    let data: T?
    let code: Int?
    let message: String?
    private enum Keys: String, CodingKey {
        case data = "data"
        case code = "code"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        message = try? container.decode(String.self, forKey: .message)
        code = try? container.decode(Int.self, forKey: .code)
        data = try? container.decode(T.self, forKey: .data)
    }
}

/// For example Decodeable
struct EmptyEntity: Decodable {
    private enum Keys: String, CodingKey {
        case oneKey = "key"
    }
    
    init(from decoder: Decoder) throws {
        /** example code
        let container = try decoder.container(keyedBy: Keys.self)
        // optional value
        let value = try? container.decode(String.self, forKey: .oneKey)*/
    }
}
