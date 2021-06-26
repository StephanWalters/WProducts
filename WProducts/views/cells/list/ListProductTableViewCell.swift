//
//  ListProductTableViewCell.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

protocol ProductConfigurationProtocol {
    func configure(_ product: Product)
}

class ListProductTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ListProductTableViewCell.self)
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addToCartButton.layer.cornerRadius = 10
    }
}

extension ListProductTableViewCell: ProductConfigurationProtocol {
    func configure(_ product: Product) {
        
        // Set title
        self.titleLabel.text = product.productName
        
        // Set description (if short description is nil, we should use the long description)
        if let description = product.shortDescription ?? product.longDescription, let htmlString = description.htmlString {
            self.descriptionLabel.attributedText = htmlString
        } else {
            self.descriptionLabel.text = product.shortDescription ?? product.longDescription
        }
        
        // Set price
        self.ratingLabel.text = product.price
        
        // Set product image
        if let productImage = product.productImage {
            
            ImageDataController.shared.getImage(for: productImage) { (image) in
                self.productImageView.image = image ?? UIImage(named: "Default Product Image")
            }
        }
        
        // Set In stock
        self.addToCartButton.isHidden = !product.inStock
    }
}
