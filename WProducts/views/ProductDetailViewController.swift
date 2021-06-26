//
//  ProductDetailViewController.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

enum ProductDetailType: String {
    case name = "ProductDetailNameTableViewCell"
    case description = "ProductDetailDescriptionTableViewCell"
    case price = "ProductDetailPriceTableViewCell"
    case reviews = "ProductDetailReviewTableViewCell"
}

class ProductDetailViewController: UIViewController {
    
    /* I DON'T use normally implicity unwrapped optionals. (Just demonstrating the use)
    (Because I can guarentee product won't be nil at the time, as a product is necessary to segue to this vc) */
    var product: Product!
    var productInfo: [ProductDetailType] = [.name, .description, .price, .reviews]
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.product.price
        
        self.setup()
        self.setProductImage()
        
        self.addToCartButton.layer.cornerRadius = 10
        self.addToCartButton.isHidden = !self.product.inStock
    }
    
    func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        
        for info in self.productInfo {
            self.tableView.register(UINib(nibName: info.rawValue, bundle: Bundle.main), forCellReuseIdentifier: info.rawValue)
        }
    }
    
    func setProductImage() {
        guard let productImage = self.product.productImage else { return }
        let controller = ImageDataController(productImage)
        controller.getImage { image in
            self.productImageView.image = image ?? UIImage(named: "Default Product Image")
        }
        
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    
}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = self.productInfo[indexPath.row].rawValue
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if let productCell = cell as? ProductConfigurationProtocol {
            productCell.configure(self.product)
        }
        
        return cell ?? UITableViewCell()
    }
}
