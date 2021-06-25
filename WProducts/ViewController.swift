//
//  ViewController.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let controller = ProductsDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setup()
        self.fetchContent()
    }
    
    private func setup() {
        
        self.tableView.register(UINib(nibName: ListProductTableViewCell.identifier,
                                      bundle: Bundle.main),
                                forCellReuseIdentifier: ListProductTableViewCell.identifier)
        
        self.tableView.register(UINib(nibName: BigPictureProductTableViewCell.identifier,
                                      bundle: Bundle.main),
                                forCellReuseIdentifier: BigPictureProductTableViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func fetchContent() {
        self.controller.request { (success, error) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.controller.isFirstItemOnPage(indexPath.row) ? 300 : 200
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = self.controller.isFirstItemOnPage(indexPath.row) ? BigPictureProductTableViewCell.identifier : ListProductTableViewCell.identifier
        let product = self.controller.products[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        
        if let productCell = cell as? ProductConfigurationProtocol {
            productCell.configure(product)
        }
        
        return cell
    }
}


