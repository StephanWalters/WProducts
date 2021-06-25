//
//  Product.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

class Product: Codable {
    let productId: String
    let productName : String
    var shortDescription : String?
    var longDescription : String?
    var price : String?
    var productImage : String?
    var reviewRating : Float?
    var reviewCount = 0
    var inStock = false
    
    init(_ productId: String, productName: String) {
        self.productId = productId
        self.productName = productName
    }
}
