//
//  UIImageView+Extension.swift
//  ImageSearch
//
//  Created by Meet on 2/9/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import Foundation

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func cacheImage(urlString: String, completion: @escaping ((UIImage?, String) -> Void)){
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(imageFromCache, urlString)
            return
        }
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                imageCache.setObject(image, forKey: urlString as AnyObject)
                completion(image, urlString)
            }
            }.resume()
    }
}
