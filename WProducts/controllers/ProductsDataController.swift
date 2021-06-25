//
//  ProductsDataController.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

class ProductsDataController: PaginatedDataController {
    
    var products = [Product]()
    var response: ProductsDataResponse?
    
    convenience init(_ pageSize: UInt = 30) {
        self.init("walmartproducts")
        
        self.pageSize = pageSize
        self.pageSize = pageSize <= 30 ? pageSize : 30
    }
    
    func isFirstItemOnPage(_ index: Int) -> Bool {
        return index % Int(self.pageSize) == 0
    }
    
    func canLoadMore() -> Bool {
        guard let response = self.response else { return false }
        
        /* The current pageNumber * pageSize equals the maximum number of products that have been loaded.
         This is a max because a page may not be all the way full
        */
        let totalProductsLoadedMaximum = response.pageNumber * response.pageSize
        return response.totalProducts > totalProductsLoadedMaximum
    }
}

extension ProductsDataController: ExtractorProtocol {
    func extract(_ data: Data) -> Bool {
        let decoder = JSONDecoder()
        
        do {
            self.response = try decoder.decode(ProductsDataResponse.self, from: data)
            guard let response = self.response, let products = response.products else {
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
