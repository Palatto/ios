//
//  PromotionListViewController.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 10/20/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import UIKit

class PromotionListViewController: UIViewController {
    
    // Custom data source and delegate for our tableView. These two contain the important
    // methods that we have to override to change the default behaviour of the tableView.
    // We create separate files to declare them.
    fileprivate var dataSource = PromotionListDataSource()
    fileprivate var delegate = PromotionListDelegate()
    
    // Username, set in with information about the user logged
    var username = ""
    
    // Basically lazily initializes the controller - only instantiates it,
    // "wasting" memory to do it, when the controller is used for the first time.
    // Search more to understand better.
    fileprivate lazy var promotionListController: PromotionListController = {
        
        // see that we give self as parameter as the promotionListProtocol because this
        // viewController implements this, and so the controller can use it.
        return PromotionListController(username: username, promotionListProtocol: self)
    }()
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            navigationBar.tintColor = PlateColors.mainWhite
            navigationBar.isTranslucent = false
            navigationBar.barTintColor = PlateColors.mainRed
            navigationBar.backgroundColor = PlateColors.mainRed
        }
    }
    
    // Loading outlet
    @IBOutlet weak var loading: UIActivityIndicatorView! {
        didSet {
            loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            loading.color = PlateColors.mainRed // UIColor(red: 0.79, green: 0.23, blue: 0.20, alpha: 1.0)
        }
    }
    
    // TableView outlet
    @IBOutlet fileprivate weak var promotionTable: UITableView!
    
    @IBAction func addButtonAction(_ sender: Any) {
        promotionListController.respondToPlusButtonClick()
    }
    
    // var refreshControl: UIRefreshControl!
    
    // Uses this part of the lifecycle of the view to initialize the promotionsList, one
    // located in the controller, initialized there as well, later used to load the
    // tableView.
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        
        //refresh properties
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = PlateColors.mainWhite
        refreshControl.backgroundColor = PlateColors.mainRed
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        promotionTable.refreshControl = refreshControl
        
        //promotionTable initialization
        //        promotionTable.tableFooterView = UIView()
        promotionListController.initializePromotionList(username: username)
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        promotionListController.promotionList.clearPromotions()
        promotionListController.initializePromotionList(username: username)
        reloadTable()
        refreshControl.endRefreshing()
    }
    
    // Understand if we need this or not - has to do with custom the statusBar
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    //    }
}

// Extension for organization - all the functions, just as the view, are passive and just
// obey the controller.
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
    
    // Method that we will use later to present an alert with two actions, cancel or
    // confirm that you clicked in the "No food left" button.
    func showAlert(title : String, message: String, arrayOfActions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        arrayOfActions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    // Method that runs after the promotionsList in the controller is filled with
    // information from the database.
    func loadTable() {
        // self.dataSource and self.delegate reference to our global variables
        // instantiated before. The self.dataSource.promotionListController is basically a
        // reference in the dataSource to our promotionListController, one that we need to
        // access the promotionsList from there (see the file PromotionListDataSource).
        self.dataSource.promotionListController = self.promotionListController
        promotionTable.dataSource = self.dataSource
        promotionTable.delegate = self.delegate
        
        // Block of code that registers our xib, followed by reload data, to finally put
        // the data saved in the promotionsList in the tableView. 
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
