/**
 Copyright (c) 2016 Wesley de Groot (http://www.wesleydegroot.nl), WDGWV (http://www.wdgwv.com)
 
 Variable prefixes:
 WDGS = WDG.Framework Shared
 WDGT = WDG.Framework Tests (internal)
 WDGI = WDG.Framework Internal
 WDGU = WDG.Framework Unspecified
 
 ---------------------------------------------------
 File:    iCloudSync.swift
 Created: 18-FEB-2016
 Creator: Wesley de Groot | g: @wdg | t: @wesdegroot
 Issue:   #
 Prefix:  N/A
 ---------------------------------------------------
 */

import Foundation
import CloudKit

private var WDGIiCloudSyncInProgress: Bool = false

open class WDGFrameworkiCloudSync {
    public static let shared:WDGFrameworkiCloudSync = WDGFrameworkiCloudSync()
    
    public init () {
        if (WDGIiCloudSyncInProgress == false) {
            // Start the sync!
            self.startSync()
        }
    }
    
    open func startSync ( ) {
        if (NSUbiquitousKeyValueStore.default.isKind(of: NSUbiquitousKeyValueStore.self)) {
            NotificationCenter.default.addObserver(self, selector: #selector(WDGFrameworkiCloudSync.fromCloud), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(WDGFrameworkiCloudSync.toCloud), name: UserDefaults.didChangeNotification, object: nil)
            if (NSUbiquitousKeyValueStore.default.dictionaryRepresentation.count == 0) {
                self.toCloud()
            }
            self.fromCloud()
            
            // Say i'm syncing
            WDGIiCloudSyncInProgress = true
        } else {
            // Say i'm not syncing :'(
            WDGIiCloudSyncInProgress = false
            print("Can't start sync!")
        }
    }
    
    @objc private func fromCloud () {
//        print("Getting from iCloud")
        // iCloud to a Dictionary
        let dict: NSDictionary = NSUbiquitousKeyValueStore.default.dictionaryRepresentation as NSDictionary
        
        // Disable ObServer temporary...
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
        
        // Enumerate & Duplicate
        dict.enumerateKeysAndObjects(options: []) { (key, value, pointer) -> Void in
            UserDefaults.standard.set(value, forKey: key as! String)
        }
        
        // Sync!
        UserDefaults.standard.synchronize()
        
        // Enable ObServer
        NotificationCenter.default.addObserver(self, selector: #selector(WDGFrameworkiCloudSync.toCloud), name: UserDefaults.didChangeNotification, object: nil)
        
        // Post a super cool notification.
        NotificationCenter.default.post(name: Notification.Name(rawValue: "MKiCloudSyncDidUpdateToLatest"), object: nil)
    }
    
    @objc private func toCloud() {
//        print("Going to iCloud")
        // NSUserDefaults to a dictionary
        let dict: NSDictionary = UserDefaults.standard.dictionaryRepresentation() as NSDictionary
        
        // Disable ObServer temporary...
        NotificationCenter.default.removeObserver(self, name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
        
        // Enumerate & Duplicate
        dict.enumerateKeysAndObjects() { (key, value, pointer) -> Void in
            NSUbiquitousKeyValueStore.default.set(value, forKey: key as! String)
        }
        
        // Sync!
        NSUbiquitousKeyValueStore.default.synchronize()
        
        // Enable ObServer
        NotificationCenter.default.addObserver(self, selector: #selector(WDGFrameworkiCloudSync.fromCloud), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
    }
    
    fileprivate func unset ( ) {
        // Say i'm not syncing anymore
        WDGIiCloudSyncInProgress = false
        
        // Disable ObServers
        NotificationCenter.default.removeObserver(self, name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
    
    open func sync ( ) {
        // If not started (impossible, but ok)
        if (WDGIiCloudSyncInProgress == false) {
            // Just for starting.
            self.startSync()
        } else {
            // Sync!
            NSUbiquitousKeyValueStore.default.synchronize()
        }
    }
    
    deinit {
        // Remove it all
        self.unset()
    }
}
