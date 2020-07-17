//
//  CreateProductViewController.swift
//  Workout
//
//  Created by ntq on 7/16/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

enum ProductType: Int {
    case create
    case edit
}

final class CreateProductViewController: UIViewController {
    
    @IBOutlet weak private var txName: UITextField!
    @IBOutlet weak private var txPrice: UITextField!
    @IBOutlet weak private var txQuantity: UITextField!
    @IBOutlet weak private var btnDelete: UIButton!
    
    let presenter = CreateProductPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupViewController()
    }
    
    private func setupViewController() {
        configPresenter()
        if presenter.type == .edit {
            fillData()
            self.btnDelete.isHidden = false
        }
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelDidPress(sender:)))
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveDidPress(sender:)))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
        self.navigationItem.title = "Product"
    }
    
    private func fillData() {
        guard let product = self.presenter.product else { return }
        self.txName.text = product.name
        self.txPrice.text = (product.price != nil) ? "\(product.price ?? 0)" : ""
        self.txQuantity.text = (product.quantity != nil) ? "\(product.quantity ?? 0)" : ""
    }
    
    private func configPresenter() {
        presenter.attachView(view: self)
    }
    
    @objc private func saveDidPress(sender: UIBarButtonItem) {
        presenter.createProductRequest = CreateProductRequest(iName: txName.text ?? "", iPrice: Int(txPrice.text!) ?? 0, iQuantity: Int(txQuantity.text!) ?? 0)
        switch presenter.type {
        case .create:
            presenter.createProduct()
        case .edit:
            guard let id = self.presenter.product?.id else { return }
            presenter.updateProduct(id: id)
        }
    }
    
    @objc private func cancelDidPress(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func deleteProductDidPress() {
        guard let id = self.presenter.product?.id else { return }
        presenter.deleteProduct(id: id)
    }
}

extension CreateProductViewController: CreateProductViewProtocol {
    
    func didFinishDeleteProduct(error: ServiceError?) {
        if let err = error, let ms = err.reason {
            AlertView.shared.showAlert(title: "", message: ms, handerLeft: nil, handerRight: {
                self.dismiss(animated: true, completion: nil)
            }, title_btn_left: nil, title_btn_right: "title_Ok".localizable, viewController: self)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFinishUpdateProduct(message: String?, error: ServiceError?) {
        var ms = message
        if let err = error {
            ms = err.reason
        }
            
        AlertView.shared.showAlert(title: "", message: ms, handerLeft: {
            self.dismiss(animated: true, completion: nil)
        }, handerRight: nil, title_btn_left: "title_Ok".localizable, title_btn_right: nil, viewController: self)
    }
    
    func didFinishCreateProduct(message: String?, error: ServiceError?) {
        var ms = message
        if let err = error {
            ms = err.reason
        }
            
        AlertView.shared.showAlert(title: "", message: ms, handerLeft: {
            self.dismiss(animated: true, completion: nil)
        }, handerRight: nil, title_btn_left: "title_Ok".localizable, title_btn_right: nil, viewController: self)
    }
}

extension CreateProductViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case txPrice, txQuantity:
            let numbersOnly = CharacterSet(charactersIn: "0123456789")
            let characterSetFromTextField = CharacterSet(charactersIn: textField.text ?? "")
            let stringIsValid = numbersOnly.isSuperset(of: characterSetFromTextField)
            return stringIsValid
        default:
            return true
        }
    }
}
