//
//  ViewController.swift
//  BarRoulette
//
//  Created by Emma Koszinowski on 7/24/15.
//  Copyright (c) 2015 Emma Koszinowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yesButton: UIButton!
    
    override class func initialize() {
        srandomdev();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressYesButton(sender: UIButton) {
        APISample2.search { (JSON, error) -> Void in
            if let JSON = JSON, businesses = JSON["businesses"] as? [AnyObject], business = businesses[random() % businesses.count] as? [String: AnyObject] where businesses.count > 0 {
//                println(business)
                let location = business["location"] as? [String: AnyObject]
                let JSONCoordinate = location?["coordinate"] as? [String: AnyObject]
                let coord = Coordinate.create(latitude: JSONCoordinate?["latitude"] as? Double, longitude: JSONCoordinate?["longitude"] as? Double)
                let imageURL = (business["image_url"] as? String).flatMap {
                    NSURL(string: $0)
                }
                if let bar = Bar.create(snippet: business["snippet_text"] as? String, imageURL: imageURL, coordinate: coord) {
                    bar.snippet
                    println(bar)
                }

//                business["snippet_text"].map(println)
//                business["image_url"].map(println)
            } else {
                println("we didn't get any businesses in \(JSON)")
            }
//            println(JSON)
        }
    }

}

