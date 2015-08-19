//
//  search.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 8/3/15.
//  Copyright (c) 2015 Emma Koszinowski. All rights reserved.
//

import Foundation

let APIHost = "api.yelp.com"
let searchPath = "/v2/search/"

class APISample2: NSObject {
    class func search(callback: ([String: AnyObject]?, NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let params = [
            "term": "bar",
            //"location": "New York, NY",
            "ll": "40.7159819101673,-73.9893277618757",
            "category_filter": "divebars"
        ]
        session.dataTaskWithRequest(NSURLRequest(host: APIHost, path: searchPath, params: params)) { (data, response, error) -> Void in
            if let data = data {
                var decodingError: NSError?
                if let decoded = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &decodingError) as? [String: AnyObject] {
                    callback(decoded, nil)
                } else {
                    callback(nil, decodingError)
                }
            } else {
                callback(nil, error)
            }
        }.resume()
    }
    
    class func search2(callback: ([String: AnyObject]?, NSError?) -> Void) {
        search { JSON, error in
            if let JSON = JSON, firstBusiness = (JSON["businesses"] as? [AnyObject])?.first as? [String: AnyObject] {
                firstBusiness["snippet_text"].map(println)
            }
            callback(JSON, error)
        }
    }
}

