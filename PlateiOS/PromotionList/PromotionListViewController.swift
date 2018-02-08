//
//  PromotionListViewController.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 10/20/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//
//rennerzao ousado

import UIKit

class PromotionListViewController: UIViewController {
    
    fileprivate var dataSource = PromotionListDataSource()
    fileprivate var delegate = PromotionListDelegate()
    
    var username = ""
    
    fileprivate lazy var promotionListController: PromotionListController = {
        return PromotionListController(username: username, promotionListProtocol: self)
    }()
    
    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.tintColor = PlateColors.mainWhite
            navigationBar.isTranslucent = false
            navigationBar.barTintColor = PlateColors.mainRed
            navigationBar.backgroundColor = PlateColors.mainRed
        }
    }
    
    @IBOutlet weak var loading: UIActivityIndicatorView! {
        didSet {
            loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            loading.color = PlateColors.mainRed // UIColor(red: 0.79, green: 0.23, blue: 0.20, alpha: 1.0)
        }
    }
    
    @IBOutlet fileprivate weak var promotionTable: UITableView!
    
    @IBAction func addButtonAction(_ sender: Any) {
        promotionListController.respondToPlusButtonClick()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = PlateColors.mainWhite
        refreshControl.backgroundColor = PlateColors.mainRed
        refreshControl.addTarget(self, action: #selector(refreshFunction), for: .valueChanged)
        promotionTable.refreshControl = refreshControl
        
        promotionListController.initializePromotionList(username: username)
    }
    
    @objc func refreshFunction(refreshControl: UIRefreshControl) {
        promotionListController.promotionList.clearPromotions()
        promotionListController.initializePromotionList(username: username)
        reloadTable()
        refreshControl.endRefreshing()
    }
}

extension PromotionListViewController: PromotionListProtocol {
    
    func showErrorMessage(title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func reloadTable() {
        promotionTable.reloadData()
    }
    
    func showLoading() {
        loading.startAnimating()
        loading.alpha = 1
    }
    
    func hideLoading() {
        loading.stopAnimating()
        loading.alpha = 0
    }
    
    func showAlert(title : String, message: String, arrayOfActions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        arrayOfActions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    func loadTable() {
        self.dataSource.promotionListController = self.promotionListController
        promotionTable.dataSource = self.dataSource
        promotionTable.delegate = self.delegate
        
        let nibName = UINib(nibName: "PromotionCell", bundle: nil)
        promotionTable.register(nibName, forCellReuseIdentifier: "PromotionCell")
        promotionTable.reloadData()
    }
    
    func openViewController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.show(controller, sender: nil)
        }
    }
    
    func presentViewController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }
}
