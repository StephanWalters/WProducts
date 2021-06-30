//
//  ProductDetailReviewTableViewCell.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

class ProductDetailReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
}

extension ProductDetailReviewTableViewCell: ProductConfigurationProtocol {
    func configure(_ product: Product) {
        
        guard product.reviewCount > 0 else {
            self.ratingsLabel.text = nil
            self.reviewsLabel.text = nil
            return
        }
        
        if let rating = product.reviewRating {
            self.ratingsLabel.text = "Avg Rating: \(rating)"
        }
        
        self.reviewsLabel.text = "\(product.reviewCount) Review(s)"
    }
}
