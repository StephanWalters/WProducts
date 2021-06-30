//
//  ProductDetailNameTableViewCell.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

class ProductDetailNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
}

extension ProductDetailNameTableViewCell: ProductConfigurationProtocol {
    func configure(_ product: Product) {
        self.titleLabel.text = product.productName
    }
}
