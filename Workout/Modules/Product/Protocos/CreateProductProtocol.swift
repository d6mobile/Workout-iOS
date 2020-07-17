//
//  CreateProductProtocol.swift
//  Workout
//
//  Created by ntq on 7/16/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation

protocol CreateProductPresenteProtocol: class {
    func attachView(view: CreateProductViewProtocol?)
    func createProduct()
    func updateProduct(id: Int)
    func deleteProduct(id: Int)
}

protocol CreateProductViewProtocol: class {
    func didFinishCreateProduct(message: String?, error: ServiceError?)
    func didFinishUpdateProduct(message: String?, error: ServiceError?)
    func didFinishDeleteProduct(error: ServiceError?)
}

