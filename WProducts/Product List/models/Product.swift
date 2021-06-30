//
//  Product.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

class Product: NSObject, Codable, NSCoding {
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
    
    func encode(with coder: NSCoder) {
        coder.encode(self.productId, forKey: "productId")
    }
    
    required convenience init?(coder: NSCoder) {
        guard let productId = coder.decodeObject(forKey: "productId") as? String,
              let productName = coder.decodeObject(forKey: "productName") as? String else { return nil }
        
        
        self.init(productId, productName: productName)
    }
}

