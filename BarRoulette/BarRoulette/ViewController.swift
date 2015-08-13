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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressYesButton(sender: UIButton) {
        println("you pressed the yes button")
    }

}

