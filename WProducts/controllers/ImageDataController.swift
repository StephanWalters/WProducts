//
//  ImageDataController.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

// Image cache singleton to cache product images
class ImageDataCache {
    static let shared = ImageDataCache()
    let cache = NSCache<NSString, UIImage>()
}

class ImageDataController: DataController {
    
    let cache = ImageDataCache.shared.cache
    
    func getImage(_ completion: @escaping (UIImage?) -> Void) {
        let path = self.path as NSString
        
        guard let image = self.cache.object(forKey: path) else {
            
            self.request { (success, error) in
                if success {
                    completion(self.cache.object(forKey: path))
                } else {
                    completion(nil)
                }
            }
            return
        }
        
        completion(image)
    }
    
    func set(_ image: UIImage, for key: NSString) {
        self.cache.setObject(image, forKey: key)
    }
    
    func clear() {
        self.cache.removeAllObjects()
    }
}

extension ImageDataController: ExtractorProtocol {
    func extract(_ data: Data) -> Bool {

        guard let image = UIImage(data: data) else { return false }

        self.set(image, for: self.path as NSString)
        return true
    }
}

