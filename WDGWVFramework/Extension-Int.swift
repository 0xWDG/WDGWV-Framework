/**
 Copyright (c) 2016 Wesley de Groot (http://www.wesleydegroot.nl), WDGWV (http://www.wdgwv.com)
 
 Variable prefixes:
 WDGS = WDG.Framework Shared
 WDGT = WDG.Framework Tests (internal)
 WDGI = WDG.Framework Internal
 WDGU = WDG.Framework Unspecified
 
 ---------------------------------------------------
 File:    extension-int.swift
 Created: 18-FEB-2016
 Creator: Wesley de Groot | g: @wdg | t: @wesdegroot
 Issue:   #
 Prefix:  N/A
 ---------------------------------------------------
 */

import Foundation

extension Int {
    //func toString(x: Int) -> String {
    //    return String(format:"%2X", self)
    //}
    
    static var range: CountableRange<Int> {
        return CountableRange<Int>(Int.min...Int.max-1)
    }
    
    func toString(_ i: Int) -> String {
        if (i == 16) {// hexadecimal
            return String(format: "%2X", self).lowercased()
                .replacingOccurrences(of: " ", with: "")
        }
        else if (i == 8) {// octal
            return String(self, radix: 8, uppercase: false).lowercased()
                .replacingOccurrences(of: " ", with: "")
        }
        else if (i == 2) {// binary
            return String(self, radix: 2, uppercase: false).lowercased()
                .replacingOccurrences(of: " ", with: "")
        }
        else {
            return String(self)
        }
    }
}
