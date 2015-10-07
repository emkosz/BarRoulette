//
//  request.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 10/7/15.
//  Copyright © 2015 Emma Koszinowski. All rights reserved.
//

import Foundation
import CoreLocation


// requests to  https://sandbox-api.uber.com/<version>


let ApiHostUber = "https://sandbox-api.uber.com/v1/sandbox"

extension UBUberAPI {
    func requestRide(currentLocation: CLLocation, bar: Bar, product: UBProduct, callback: ([String: AnyObject]?, NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        //?product_id=\(product.productId)&start_latitude=\(currentLocation.coordinate.latitude)&start_longitude=\(currentLocation.coordinate.longitude)&end_latitude=\(bar.coordinate.latitude)&end_longitude=\(bar.coordinate.longitude)
        let URL = NSURL(string: self.hostname + "v1/requests")!
        let request = NSMutableURLRequest(URL: URL, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 60)
        request.HTTPMethod = "POST"
//        [request addValue:[NSString stringWithFormat:@"Token %@", self.serverToken] forHTTPHeaderField:@"Authorization"];
        
        request.addValue("Token \(self.serverToken)", forHTTPHeaderField: "Authorization")
        
        session.dataTaskWithRequest(request) { (data, response, error) -> Void in
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
