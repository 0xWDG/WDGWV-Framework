/**
 Copyright (c) 2016 Wesley de Groot (http://www.wesleydegroot.nl), WDGWV (http://www.wdgwv.com)
 
 Variable prefixes:
 WDGS = WDG.Framework Shared
 WDGT = WDG.Framework Tests (internal)
 WDGI = WDG.Framework Internal
 WDGU = WDG.Framework Unspecified
 
 ---------------------------------------------------
 File:    Extension-Array.swift
 Created: 18-FEB-2016
 Creator: Wesley de Groot | g: @wdg | t: @wesdegroot
 Issue:   #
 Prefix:  N/A
 ---------------------------------------------------
 */

import Foundation

extension Array {
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort {(_, _) in arc4random() < arc4random()}
        }
    }
}
