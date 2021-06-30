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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: ListProductTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ListProductTableViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavedListToProductDetail", let product = sender as? Product, let vc = segue.destination as? ProductDetailViewController {
            vc.product = product
        }
    }
}

extension SavedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.controller.products[indexPath.row]
        self.performSegue(withIdentifier: "SavedListToProductDetail", sender: product)
    }
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
 
