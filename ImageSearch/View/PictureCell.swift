//
//  PictureCell.swift
//  ImageSearch
//
//  Created by Meet on 2/9/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loader.hidesWhenStopped = true
    }
    
    // MARK: - view update mehtods
    
    func updateCell(withImageURL urlString: String?) {        
        if let urlString = urlString {
            self.refreshView(withURL: urlString)
        }
    }
    
    fileprivate func refreshView(withURL urlString: String) {
        
        self.loader.startAnimating()
        self.imageView.cacheImage(urlString: urlString) { (image, url) in
            self.loader.stopAnimating()
            if urlString == url {
                self.imageView.image = image
            }
        }
    }
    
}
