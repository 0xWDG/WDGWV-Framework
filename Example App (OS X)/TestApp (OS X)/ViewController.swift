//
//  ViewController.swift
//  TestApp (OS X)
//
//  Created by Wesley de Groot on 14-01-16.
//  Copyright © 2016 WDGWV. All rights reserved.
//

import Cocoa
import WDGWVFramework

class ViewController: NSViewController {
    let framework = WDGWVFramework(true);
    let secure = WDGWVFrameworkHash();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if framework.loaded() {
            framework.log("Hi, welcome to \(framework.product) version \(framework.version)")
        } else {
            print("Missing framework")
        }
        
//                let data = "https://www.wdgwv.com/conditions_nl/noHTML".load();
//                print(data)
        
        //        print("Smile :) Be not angy :@ or depressed :( (bL)(NL)".smile())
//        framework.setAppColor(NSColor.redColor())
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

