//
//  DataController.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

class PaginatedDataController: DataController {
    private var pageNumber = 1
    var pageSize: UInt = 0
    
    override func getFullPath() -> String {
        let qualifiedPath = "\(self.path)/\(self.pageNumber)/\(self.pageSize)"
        
        return qualifiedPath
    }
    
    func incrementPageNumber() {
        self.pageNumber += 1
    }
}

protocol ExtractorProtocol {
    func extract(_ data: Data) -> Bool
}

class DataController {
    var path = ""
    var host = "https://mobile-tha-server.firebaseapp.com/"
    
    var extractor: ExtractorProtocol?
    
    init(_ path: String) {
        self.path = path
        
        guard let extractor = self as? ExtractorProtocol else {
            fatalError("\(self) must implement ExtractorProtocol")
        }
        
        self.extractor = extractor
    }
    
    func request(_ completion: @escaping ((Data?, Error?) -> Void)) {
        let session = URLSession.shared
        let requestUrl = "\(self.host)\(getFullPath())"
        
        guard let url = URL(string: requestUrl) else {
            completion(nil, nil)
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            // Dispatch completion of data task on main thread
            DispatchQueue.main.async {
                guard let data = data, self.extractor?.extract(data) == true else {
                    completion(nil, error)
                    return
                }
                completion(data, nil)
            }
        }.resume()
    }
        
    func getFullPath() -> String {
        return self.path
    }
}

