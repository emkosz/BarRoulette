//
//  UberViewController.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 10/7/15.
//  Copyright © 2015 Emma Koszinowski. All rights reserved.
//

import UIKit
import CoreLocation
import Keys

class UberViewController: UIViewController {
    var bar :Bar?
    var location :CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make a request to uber from our location and to the bar's location
        let API = UBUberAPI.shared()
        API.hostname = kUberSandboxHostname
        API.serverToken = BarrouletteKeys().uberServerToken()
        
        if let location = location, bar = bar {
            API.getProductsFromLatitude(Float(location.coordinate.latitude), longitude: Float(location.coordinate.longitude), response: { (products, error) -> Void in
                print("hej", products)
                if let products = products {                    
                    UBUberAPI.shared().requestRide(location, bar: bar, product: products.first!, callback: { (response, error) -> Void in
                        print("hallo", response)
                        print("fel", error)
                    })
                }
            })
        }
    }
}
