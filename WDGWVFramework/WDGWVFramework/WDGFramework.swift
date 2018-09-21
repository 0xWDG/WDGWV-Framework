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
    public static let sharedInstance = WDGFramework(true)
    public static let shared = WDGFramework(true)
    
    /**
     The version of WDGWVFramework
     - Parameter version: The version of WDGWVFramework
     */
    public let version = "0.1a"//WDGFrameworkVersionNumber
    
    /**
     The product name
     - Parameter product: The product name
     */
    public let product = "WDGWV Framework"
    
    public var debug = false

    /**
     This will setup iCloud sync!
     NSUserDefaults to iCloud & Back.
     */
    public init(_ silent:Bool = false) {
        self.debug = silent
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
            
            WDG_Loaded = true
        }
    }

    public func printif(_ str: Any, file: String = #file, line: Int = #line, function: String = #function) {
        if (debug) {
            let x: String = (file.split("/").last)!.split(".").first!
            Swift.print("[DEBUG] \(x):\(line) \(function):\n \(str)\n")
        }
    }
    
    /**
     ?
     */
    @discardableResult
    open func log(_ message: String, file: String = #file, line: Int = #line, function: String = #function) -> Bool {
        if (debug) {
            let x: String = (file.split("/").last)!.split(".").first!
            Swift.print("[DEBUG] \(x):\(line) \(function):\n \(message)\n")
        }

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
