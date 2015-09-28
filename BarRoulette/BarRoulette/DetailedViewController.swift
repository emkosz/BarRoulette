//
//  DetailedViewController.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 8/13/15.
//  Copyright (c) 2015 Emma Koszinowski. All rights reserved.
//

import UIKit
import CoreLocation

class DetailedViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var bar: Bar?
    @IBOutlet weak var snippetTextLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        print(CLLocationManager.locationServicesEnabled())
        locationManager.startMonitoringSignificantLocationChanges()
        print(locationManager.location)
//        locationManager.requestLocation()
        
        // check the location again
//        if let location = locationManager.location { … }
    }
    
    func searchFromLocation(location: CLLocation) {
        APISample2.search({ (JSON, error) -> Void in
            if let JSON = JSON, businesses = JSON["businesses"] as? [AnyObject], business = businesses[random() % businesses.count] as? [String: AnyObject] where businesses.count > 0 {
                //                println(business)
                let location = business["location"] as? [String: AnyObject]
                let JSONCoordinate = location?["coordinate"] as? [String: AnyObject]
                let coord = Coordinate.create(latitude: JSONCoordinate?["latitude"] as? Double, longitude: JSONCoordinate?["longitude"] as? Double)
                let imageURL = (business["image_url"] as? String).flatMap {
                    NSURL(string: $0)
                }
                if let bar = Bar.create(snippet: business["snippet_text"] as? String, imageURL: imageURL, coordinate: coord) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.snippetTextLabel.text = bar.snippet
                    }
                }
                
                //                business["snippet_text"].map(println)
                //                business["image_url"].map(println)
            } else {
                print("we didn't get any businesses in \(JSON)")
            }
            //            println(JSON)
        })

        // Do any additional setup after loading the view.
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // delegate.locationManager(self, didUpdateLocations: […])
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("got status \(status.rawValue)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            searchFromLocation(locations[0])
        }
    }
}
