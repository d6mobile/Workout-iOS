//
//  CreateProductPresenter.swift
//  Workout
//
//  Created by ntq on 7/16/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import Alamofire

struct CreateProductRequest {
    
    var name       = ""
    var price      = Int()
    var quantity   = Int()
    
    init(iName: String, iPrice: Int, iQuantity: Int) {
        name       = iName
        price      = iPrice
        quantity   = iQuantity
    }
    
    func makeParamsRequest() -> Parameters {
        return [APIKey.name: name,
                APIKey.price: price,
                APIKey.quantity: quantity]
    }
}

final class CreateProductPresenter: CreateProductPresenteProtocol {

    weak private var viewPresenter: CreateProductViewProtocol?
    var createProductRequest: CreateProductRequest?
    var product: Product?
    var type: ProductType = .create
    
    func attachView(view: CreateProductViewProtocol?) {
        viewPresenter = view
    }
    
    func deleteProduct(id: Int) {
        let service = WebServiceManager(endPointUrl: APIPath.products + "/\(id)", method: .delete, encoding: JSONEncoding.default)
               ProgressHUD.show()
        service.executeQuery { [weak self] (result: Result<APIParser<EmptyEntity>,Error>)  in
            ProgressHUD.hide()
            switch result {
            case .success(let model):
                self?.viewPresenter?.didFinishDeleteProduct(error: nil)
            case .failure(let error):
                self?.viewPresenter?.didFinishDeleteProduct(error: ServiceError(error))
            }
        }
    }
    
    func updateProduct(id: Int) {
        guard let model = self.createProductRequest else { return }
        let service = WebServiceManager(params: model.makeParamsRequest(), endPointUrl: APIPath.products + "/\(id)", method: .put, encoding: JSONEncoding.default)
        ProgressHUD.show()
        service.executeQuery { [weak self] (result: Result<APIParser<Product>,Error>)  in
            ProgressHUD.hide()
            switch result {
            case .success(let model):
                self?.viewPresenter?.didFinishUpdateProduct(message: model.message ?? "", error: nil)
            case .failure(let error):
                self?.viewPresenter?.didFinishUpdateProduct(message: nil, error: ServiceError(error))
            }
        }
    }
    
    func createProduct() {
        guard let model = self.createProductRequest else { return }
        let service = WebServiceManager(params: model.makeParamsRequest(), endPointUrl: APIPath.products, method: .post, encoding: JSONEncoding.default)
        ProgressHUD.show()
        service.executeQuery { [weak self] (result: Result<APIParser<EmptyEntity>,Error>)  in
            ProgressHUD.hide()
            switch result {
            case .success(let model):
                self?.viewPresenter?.didFinishCreateProduct(message: model.message ?? "", error: nil)
            case .failure(let error):
                self?.viewPresenter?.didFinishCreateProduct(message: nil, error: ServiceError(error))
            }
        }
    }
}
