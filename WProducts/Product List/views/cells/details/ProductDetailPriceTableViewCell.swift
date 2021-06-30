//
//  ProductDetailPriceTableViewCell.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

class ProductDetailPriceTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
}

extension ProductDetailPriceTableViewCell: ProductConfigurationProtocol {
    func configure(_ product: Product) {
        self.priceLabel.text = product.price
    }
}
