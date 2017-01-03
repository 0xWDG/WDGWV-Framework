//
//  Extension-Bundle.swift
//  WDGFramework
//
//  Created by Wesley de Groot on 03-01-17.
//  Copyright © 2017 WDGWV. All rights reserved.
//

import Foundation

extension Bundle {
    public var releaseVersionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
}
