//
//  search.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 8/3/15.
//  Copyright (c) 2015 Emma Koszinowski. All rights reserved.
//

import Foundation
import CoreLocation


let APIHost = "api.yelp.com"
let searchPath = "/v2/search/"

struct APISample2 {
    static func search(location: CLLocation, callback: ([String: AnyObject]?, NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let latitude: Double = location.coordinate.latitude // 40.7159819101673
        let longitude: Double = location.coordinate.longitude //-73.9893277618757
        let params = [
            "term": "bar",
            "ll": "\(latitude),\(longitude)",
//            "category_filter": "bar"
        ]
        session.dataTaskWithRequest(NSURLRequest(host: APIHost, path: searchPath, params: params)) { (data, response, error) -> Void in
            if let data = data {
                if let decoded = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject] {
                    callback(decoded, nil)
                }
            } else {
                callback(nil, error)
            }
        }.resume()
    }
    
}

