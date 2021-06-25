//
//  ProductsDataController.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

class ProductsDataController: PaginatedDataController {
    
    var products = [Product]()
    
    convenience init() {
        self.init("walmartproducts")
        self.pageSize = 30
    }
    
    func isFirstItemOnPage(_ index: Int) -> Bool {
        return index % self.pageSize == 0
    }
}

extension ProductsDataController: ExtractorProtocol {
    func extract(_ data: Data) -> Bool {
        let decoder = JSONDecoder()
        
        do {
            self.response = try decoder.decode(ProductsDataResponse.self, from: data)
            guard let productResponse = self.response as? ProductsDataResponse, let products = productResponse.products else {
                return false
            }
            
            self.products.append(contentsOf: products)
        } catch {
            print("JSONDecoder error")
            return false
        }
        
        return true
    }
}
