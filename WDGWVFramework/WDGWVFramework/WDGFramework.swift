/**
 Copyright (c) 2016 Wesley de Groot (http://www.wesleydegroot.nl), WDGWV (http://www.wdgwv.com)
 
 Variable prefixes:
 WDGS = WDG.Framework Shared
 WDGT = WDG.Framework Tests (internal)
 WDGI = WDG.Framework Internal
 WDGU = WDG.Framework Unspecified
 
 ---------------------------------------------------
 File:    WDGFramework.swift
 Created: 18-FEB-2016
 Creator: Wesley de Groot | g: @wdg | t: @wesdegroot
 Issue:   #
 Prefix:  N/A
 ---------------------------------------------------
 */

import Foundation
import CommonCrypto

#if os(iOS)
    import UIKit
#endif
#if os(OSX)
    import AppKit
#endif

private var WDG_Loaded:Bool = false

open class WDGFramework {
    /**
     The shared instance of the "WDGWVFramework"
     - Parameter sharedInstance: The "WDGWVFramework" shared instance
     */
    open static let sharedInstance = WDGFramework(true)
    
    /**
     The version of WDGWVFramework
     - Parameter version: The version of WDGWVFramework
     */
    open let version = "0.1a"//WDGFrameworkVersionNumber
    
    /**
     The product name
     - Parameter product: The product name
     */
    open let product = "WDGWV Framework"
    
    /**
     This will setup iCloud sync!
     NSUserDefaults to iCloud & Back.
     */
    public init(_ silent:Bool = false) {
        if (!WDG_Loaded) {
            let iCloud : WDGFrameworkiCloudSync = WDGFrameworkiCloudSync()
                iCloud.startSync()
            
            if (!silent) {
                print("WDGWV Framework \(self.version) loaded")
                #if os(iOS)
                    print("Hello iOS")
                #elseif os(OSX)
                    print("Hello OS X")
                #elseif os(watchOS)
                    print("Hello  Watch")
                #elseif os(tvOS)
                    print("Hello  TV")
                #endif
            }
            
            WDG_Loaded=true
        }
    }
    
    /**
     ?
     */
    open func log(_ message: String) -> Bool {
        print(message)
        return true
    }

    /**
     Is the framework loaded
     - Returns: loaded or not (Bool)
     */
    open func loaded() -> Bool {
        return WDG_Loaded
    }
    
    
    /**
     Is the framework loaded
     - Returns: loaded or not (Bool)
     */
    open func load() -> Bool {
        return self.loaded()
    }
}

open class WDGWVFramework : WDGFramework { }
open class WDGWV : WDGWVFramework { }
open class WDG : WDGFramework { }
