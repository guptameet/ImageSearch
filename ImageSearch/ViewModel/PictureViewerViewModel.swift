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
            nextPage = 1
            getQueryResults()
        }
    }
    
    
    var nextPageAvailable = true
    
    var nextPage = 1
    
    var pictures: Bind<[Picture]?> =  Bind(nil)
    
    let queryService = QueryService()
    
    
    /// Method to load new image for query search
    fileprivate func getQueryResults() {
        queryService.getSearchResults(searchTerm: self.queryString) {[weak self] (pictures, error, nextPage) in
            self?.nextPageAvailable = nextPage
            self?.pictures.value = pictures
        }
    }
    
    
    /// To load next page. Exposed for VC to use.
    func loadNextPage() {
        if nextPageAvailable {
            self.nextPage += 1
            queryService.getSearchResults(searchTerm: self.queryString, page: self.nextPage) {[weak self] (pictures, error, nextPage) in
                self?.nextPageAvailable = nextPage
                self?.pictures.value = pictures
            }
        }
    }
}
