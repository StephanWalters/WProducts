//
//  ProductsDataResponse.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

class ProductsDataResponse: Codable {
    var products: [Product]?
    var totalProducts = 0
    var pageNumber = 0
    var pageSize = 0
    var statusCode = 0
}
