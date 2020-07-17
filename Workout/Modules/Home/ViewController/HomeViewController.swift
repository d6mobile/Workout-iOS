//
//  HomeViewController.swift
//  Workout
//
//  Created by ntq on 7/15/20.
//  Copyright © 2020 Duy Dang. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    let presenter = HomePresenter()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProgressHUD.show()
        presenter.fetchProductList()
    }
    
    private func configPresenter() {
        presenter.attachView(view: self)
    }
    
    private func configTableView() {
        let cellNib = UINib(nibName: HomeTableViewCell.className, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "homeTableCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViewController() {
        self.configTableView()
        self.configPresenter()
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logoutDidPress(sender:)))
        self.navigationItem.leftBarButtonItem = logoutBarButtonItem
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addDidPress(sender:)))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        presenter.fetchProductList()
    }
    
    @objc private func addDidPress(sender: UIBarButtonItem) {
        let createProductVC = CreateProductViewController(nibName: CreateProductViewController.className, bundle: nil)
        let naviVC = BaseNaviController(rootViewController: createProductVC)
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true, completion: nil)
    }
    
    @objc private func logoutDidPress(sender: UIBarButtonItem) {
        AppCenter.shared.userSession.logout()
    }
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        if let model = presenter.products?[safe: indexPath.row] {
            cell.fillDataToCell(model: model)
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let createProductVC = CreateProductViewController(nibName: CreateProductViewController.className, bundle: nil)
        createProductVC.presenter.product = self.presenter.products?[safe: indexPath.row]
        createProductVC.presenter.type = .edit
        let naviVC = BaseNaviController(rootViewController: createProductVC)
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true, completion: nil)
    }
}

// MARK: HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
    func didFinishFetchProductList(error: ServiceError?) {
        if let err = error {
            AlertView.shared.showAlert(title: "", message: err.reason, handerLeft: nil, handerRight: nil, title_btn_left: "title_Ok".localizable, title_btn_right: nil, viewController: self)
            return
        }
        
        ProgressHUD.hide()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}
