//
//  SavedProducts.swift
//  WProducts
//
//  Created by Stephan Walters on 6/30/21.
//

import Foundation

class SavedProducts {
    private var userDefaults = UserDefaults.standard
    let productsKey = "products"
    
    var products: [Product]? {
        get {
            return self.userDefaults.array(forKey: productsKey) as? [Product]
        }
    }
    
    func add(_ product: Product) {
        if var products = self.userDefaults.array(forKey: productsKey) as? [Product] {
            products.append(product)
            self.userDefaults.setValue(products, forKey: product.productId)
        } else {
            self.userDefaults.setValue([product], forKey: product.productId)
        }
    }
    
    func remove(_ product: Product) -> Bool {
        guard var productsArray = self.userDefaults.array(forKey: productsKey) as? [Product] else {
            return false
        }
        
        productsArray.removeAll(where: { $0.productId == product.productId })
        
        self.userDefaults.setValue(productsArray, forKey: productsKey)
        return true
    }
    
    func isSaved(_ productId: String) -> Bool {
        guard let productsArray = self.userDefaults.array(forKey: productsKey) as? [Product] else {
            return false
        }
        
        return productsArray.first(where: {$0.productId == productId }) != nil
    }
}
