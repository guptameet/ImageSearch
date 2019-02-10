//
//  QueryService.swift
//  ImageSearch
//
//  Created by Meet on 2/10/19.
//  Copyright © 2019 Meet. All rights reserved.
//

import Foundation

// Runs query data task, and stores results in array of Tracks
class QueryService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Picture]?, String, Bool) -> ()
    
    let defaultSession = URLSession(configuration: .default)

    var dataTask: URLSessionDataTask?
    var pictures: [Picture] = []
    var errorMessage = ""
    var currentPage = 1
    var nextPageAvailable = true
    
    func getSearchResults(searchTerm: String, page: Int = 1, completion: @escaping QueryResult) {

        dataTask?.cancel()
        
        self.currentPage = page
        
        if let urlComponents = self.getSearchURL(withQuery: searchTerm, andPage: page) {

            guard let url = urlComponents.url else { return }
            
            
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }

                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateSearchResults(data)

                    DispatchQueue.main.async {
                        completion(self.pictures, self.errorMessage, self.nextPageAvailable)
                    }
                }
            }

            dataTask?.resume()
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        if currentPage == 1 {
            pictures.removeAll()
        }
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let photos = response!["photos"] as? [String:Any], let photoArray = photos["photo"] as? [Any] else {
            errorMessage += "Dictionary does not contain photos key\n"
            return
        }
        if photoArray.count == 0 {
            self.nextPageAvailable = false
        }
        for photoDictionary in photoArray {
            if let photoDictionary = photoDictionary as? JSONDictionary,
                let id = photoDictionary["id"] as? String,
                let title = photoDictionary["title"] as? String,
                let secret = photoDictionary["secret"] as? String,
                let farm = photoDictionary["farm"] as? Int,
                let server = photoDictionary["server"] as? String {
                pictures.append(Picture(withTitle: title, ServerName: server, Identifier: id, FarmIdentifier: farm, andSecret: secret))
            } else {
                errorMessage += "Problem parsing photoDictionary\n"
            }
        }
    }
    
    func getSearchURL(withQuery query:String, andPage page:Int) -> URLComponents? {
        var urlC = URLComponents(string: "https://api.flickr.com/services/rest/")
        urlC?.query = "method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=\(query)&page=\(page)"
        return urlC
    }
    
}

