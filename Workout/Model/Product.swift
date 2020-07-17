//
//  Product.swift
//  Workout
//
//  Created by ntq on 7/16/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

class Product: Decodable {
    var id: Int?
    var name: String?
    var price: Int?
    var quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, quantity
    }
}
