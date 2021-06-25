//
//  ProductsDataResponse.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

class ProductsDataResponse: PaginatedDataResponse, Codable {
    var products: [Product]?
    var totalProducts = 0
}
