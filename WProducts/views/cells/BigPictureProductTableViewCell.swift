//
//  BigPictureProductTableViewCell.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

class BigPictureProductTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: BigPictureProductTableViewCell.self)
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addToCartButton.layer.cornerRadius = 10
    }
}


extension BigPictureProductTableViewCell: ProductConfigurationProtocol {
    func configure(_ product: Product) {
        
        // Set title
        self.titleLabel.text = product.productName
        
        // Set description (if long description is nil, we should use the short description)
        if let description = product.longDescription ?? product.shortDescription, let htmlString = description.htmlString {
            self.descriptionLabel.attributedText = htmlString
        } else {
            self.descriptionLabel.text = product.longDescription ?? product.shortDescription
        }
        
        // Set price
        self.priceLabel.text = product.price
        
        if product.reviewCount > 0 {
            self.ratingLabel.text = "\(product.reviewCount) Review(s)"
        } else {
            self.ratingLabel.text = nil
        }
        // Set product image
        if let productImageUrl = product.productImage {
            
            let controller = ImageDataController(productImageUrl)
            controller.getImage(for: productImageUrl) { (image) in
                self.productImageView.image = image ?? UIImage(named: "Default Product Image")
            }
        }
        
        // Set In stock
        self.addToCartButton.isHidden = !product.inStock
    }
}
