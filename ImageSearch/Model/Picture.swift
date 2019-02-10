//
//  Image.swift
//  ImageSearch
//
//  Created by Meet on 2/9/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import Foundation


struct Picture {
    
    let farm: Int?
    
    let server: String?
    
    let id: String?
    
    let secret: String?
    
    let title: String?
    
    var imageURL: String = ""
    
    init(withTitle title:String, ServerName server:String, Identifier id:String, FarmIdentifier farm:Int, andSecret secret:String) {
        self.farm = farm
        self.server = server
        self.id = id
        self.title = title
        self.secret = secret
        
        self.imageURL = String(format:"https://farm%d.static.flickr.com/%@/%@_%@.jpg",farm,server,id,secret)
    }
}
