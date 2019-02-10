//
//  Bind.swift
//  ImageSearch
//
//  Created by Meet on 2/10/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import Foundation

class Bind<T> {
    typealias Listner = (T) -> Void
    var listner: Listner?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(listner: Listner?) {
        self.listner = listner
        listner?(value)
        
    }
}
