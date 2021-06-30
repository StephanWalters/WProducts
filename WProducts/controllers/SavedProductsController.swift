//
//  SavedProductsController.swift
//  WProducts
//
//  Created by Stephan Walters on 6/30/21.
//

import Foundation

/// Simple SavedProductsController that lives in memory. Ideally, i would persist this list to disk or to a database.

class SavedProductsController {
    static let shared = SavedProductsController()
    var products = [Product]()
    
    func isSaved(productId: String) -> Bool {
        return self.products.first(where: { $0.productId == productId }) != nil
    }
    
    func add(_ product: Product) {
        self.products.append(product)
    }
    
    func remove(_ productId: String) {
        self.products.removeAll(where: { $0.productId == productId })
    }
}
