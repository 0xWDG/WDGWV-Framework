//
//  WDGWVSyncTasks.swift
//  WDGFramework
//
//  Created by Wesley de Groot on 03-01-17.
//  Copyright © 2017 WDGWV. All rights reserved.
//

import Foundation

extension WDGFramework {
    public func run(background: @escaping () -> String, foreground: @escaping (String) -> ()) {
        // xxx
        DispatchQueue.global().async {
            let returning = background()
            
            DispatchQueue.main.async {
                foreground(returning)
            }
        }
    }
   
    public func runOn(main: @escaping (String) -> ()) {
        DispatchQueue.main.async {
            main("")
        }
    }
    
    public func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
