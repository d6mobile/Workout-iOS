//
//  HomeProtocol.swift
//  Workout
//
//  Created by ntq on 7/15/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

protocol HomePresenteProtocol: class {
    func attachView(view: HomeViewProtocol?)
    func fetchProductList()
}

protocol HomeViewProtocol: class {
    func didFinishFetchProductList(error: ServiceError?)
}
