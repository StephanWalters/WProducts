//
//  Extension.swift
//  WProducts
//
//  Created by Stephan Walters on 6/25/21.
//

import Foundation

extension String {
    var htmlString: NSAttributedString? {
        get {
            guard let data = self.data(using: .utf8) else {
                return nil
            }
            
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [.documentType : NSAttributedString.DocumentType.html]
            return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        }
    }
}
