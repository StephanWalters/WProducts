//
//  ProductDetailDescriptionTableViewCell.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

class ProductDetailDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
}

extension ProductDetailDescriptionTableViewCell: ProductConfigurationProtocol {
    func configure(_ product: Product) {
        if let productDescription = product.longDescription ?? product.shortDescription, let productHTML = productDescription.htmlString {
            self.descriptionLabel.attributedText = productHTML
        } else {
            self.descriptionLabel.text = product.longDescription ?? product.shortDescription
        }
    }
}
