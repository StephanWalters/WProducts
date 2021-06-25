//
//  DataResponse.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation


class PaginatedDataResponse: DataResponse {
    var pageNumber = 0
    var pageSize = 0
}

class DataResponse {
    var statusCode = 0
}
