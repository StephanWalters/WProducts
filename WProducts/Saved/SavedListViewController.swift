//
//  SavedListViewController.swift
//  WProducts
//
//  Created by Stephan Walters on 6/30/21.
//

import Foundation
import UIKit

class SavedListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let controller = SavedProductsController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: ListProductTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ListProductTableViewCell.identifier)
    }
}

extension SavedListViewController: UITableViewDelegate {
    
}

extension SavedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = self.controller.products[indexPath.row]
        let cellIdentifier = ListProductTableViewCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }
        
        if let configureCell = cell as? ProductConfigurationProtocol {
            configureCell.configure(product)
        }
        
        return cell
    }
}
 
