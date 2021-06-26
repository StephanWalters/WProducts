//
//  ImageDataController.swift
//  Products
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation
import UIKit

class ImageDataController: DataController {
    
    convenience init() {
        self.init("")
    }
    
    static let shared = ImageDataController()
    
    let cache = NSCache<NSString, UIImage>()
    func getImage(for key: String, completion: @escaping (UIImage?) -> Void) {
        let path = key as NSString
        
        guard let image = self.cache.object(forKey: path) else {
            self.path = key
            self.request { (data, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.set(image, for: path)
                    completion(image)
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
        return true
    }
}

