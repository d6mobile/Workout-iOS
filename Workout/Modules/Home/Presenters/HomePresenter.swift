//
//  HomePresenter.swift
//  Workout
//
//  Created by ntq on 7/15/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import Foundation
import Alamofire

final class HomePresenter: HomePresenteProtocol {
    
    weak private var viewPresenter: HomeViewProtocol?
    var products: [Product]?
    
    func attachView(view: HomeViewProtocol?) {
        viewPresenter = view
    }
    
    func fetchProductList() {
        let service = WebServiceManager(endPointUrl: APIPath.products, method: .get, encoding: URLEncoding.default)
        service.executeQuery { [weak self] (result: Result<APIParser<[Product]>,Error>)  in
            switch result {
            case .success(let model):
                self?.products = model.data
                self?.viewPresenter?.didFinishFetchProductList(error: nil)
            case .failure(let error):
                self?.viewPresenter?.didFinishFetchProductList(error: ServiceError(error))
            }
        }
    }
}
