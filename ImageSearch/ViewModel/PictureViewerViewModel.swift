//
//  PictureViewerViewModel.swift
//  ImageSearch
//
//  Created by Meet on 2/9/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import Foundation

class PictureViewerViewModel {
    
    var queryString = "" {
        didSet {
            if prevQuery == queryString {
                nextPage += 1
                getQueryResults(ForQuery: queryString, andPage: self.nextPage)
            }else{
                prevQuery = queryString
                getQueryResults(ForQuery: queryString)
            }
        }
    }
    
    var prevQuery = ""
    
    var nextPageAvailable = true
    
    var nextPage = 1
    
    var pictures: Bind<[Picture]?> =  Bind(nil)
    
    let queryService = QueryService()
    
    fileprivate func getQueryResults(ForQuery q:String, andPage page:Int = 1) {
        if nextPageAvailable {
            queryService.getSearchResults(searchTerm: q, page: page) {[weak self] (pictures, error, nextPage) in
                self?.nextPageAvailable = nextPage
                self?.pictures.value = pictures
            }
        }
    }
}
