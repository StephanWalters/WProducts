//
//  ViewController.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        
        // Start activity indicator
        self.activityIndicator.startAnimating()
        self.controller.request { (data, error) in
            
            // stop activity indicator
            self.activityIndicator.stopAnimating()
            if data != nil {
                self.tableView.reloadData()
            }
        }
    }
    
    private func loadMoreProductsIfNecessary() {
        guard self.controller.canLoadMore() else { return }
        self.controller.incrementPageNumber()
        self.fetchContent()
    }
    
    @IBAction func listBarItemPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ViewToSavedList", sender: nil)
    }
    
    
    // MARK: - UISegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewToProductDetail",
           let vc = segue.destination as? ProductDetailViewController,
           let product = sender as? Product {
            vc.product = product
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.controller.isFirstItemOnPage(indexPath.row) ? 300 : 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.controller.products[indexPath.row]
        self.performSegue(withIdentifier: "ViewToProductDetail", sender: product)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let product = self.controller.products[indexPath.row]
        
        // Only allow sharing if a product iamge url exists
        guard let imageUrl = product.productImage else { return nil }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, view, completion) in
            
            self.activityIndicator.startAnimating()
            ImageDataController.shared.getImage(for: imageUrl) { (image) in
                var shareItems = [Any]()
                
                // Add Text
                let shareText = "Hey! Check out this \(product.productName) at Walmart!"
                shareItems.append(shareText)
                
                // Ad Image if applicable
                if let image = image {
                    shareItems.append(image)
                }
                
                let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
                
                controller.popoverPresentationController?.sourceView = self.view
                self.present(controller, animated: true, completion: {
                    self.activityIndicator.stopAnimating()
                })
            }
            
            completion(true)
        }
        
        shareAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [shareAction])
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
        
        // Check if we are at the last product in the table view and load more products if necessary
        if indexPath.row == self.controller.products.count - 1 {
            self.loadMoreProductsIfNecessary()
        }
        
        return cell
    }
}


