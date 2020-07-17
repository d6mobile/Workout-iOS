//
//  Connectivity.swift
//  CoffeeFloat
//
//  Created by ntq on 8/22/18.
//  Copyright © 2018 NTQ. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
