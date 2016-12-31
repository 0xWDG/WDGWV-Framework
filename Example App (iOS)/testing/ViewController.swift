//
//  ViewController.swift
//  testing
//
//  Created by Wesley de Groot on 31-12-15.
//  Copyright © 2015 Wesley de Groot. All rights reserved.
//
// OK

import UIKit
import WDGWVFramework

class ViewController: UIViewController {
    let framework = WDGWVFramework(true);
    let secure = WDGWVFrameworkHash();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if framework.loaded() {
            framework.log("Hi, welcome to \(framework.product) version \(framework.version)")
        } else {
            print("Missing framework")
        }
        
//        let data = "https://www.wdgwv.com/conditions_nl/noHTML".load();
//        print(data)

//        print("Smile :) Be not angy :@ or depressed :( (bL)(NL)".smile())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

