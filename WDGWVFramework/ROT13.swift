/**
 Copyright (c) 2016 Wesley de Groot (http://www.wesleydegroot.nl), WDGWV (http://www.wdgwv.com)
 
 Variable prefixes:
 WDGS = WDG.Framework Shared
 WDGT = WDG.Framework Tests (internal)
 WDGI = WDG.Framework Internal
 WDGU = WDG.Framework Unspecified
 
 ---------------------------------------------------
 File:    ROT13.swift
 Created: 18-FEB-2016
 Creator: Wesley de Groot | g: @wdg | t: @wesdegroot
 Issue:   #
 Prefix:  N/A
 ---------------------------------------------------
 */

import Foundation

/**
 **PHP.Framework** \
 *PHP In Swift*

 ROT13 calculator class
 */
class ROT13 {
	/**
	 Encrypt function for ROT13

	 - Parameter str: the string what needs to be encoded

	 - Returns: ROT13 encoded string
	 */
	func encrypt(_ str: String) -> String {
		return self.crypt(str, rotateAmount: 13)
	}
	
	/**
	 Decrypt function for ROT13

	 - Parameter str: the string what needs to be decoded

	 - Returns: ROT13 decoded string
	 */
	func decrypt(_ str: String) -> String {
		return self.crypt(str, rotateAmount: -13)
	}
	
	/**
	 ROT13 Calculator

	 - Parameter str: the string what needs to be decoded
	 - Parameter rotateAmount: the rotation amount

	 - Returns: ROT13 en/decoded string
	 */
	func crypt(_ str: String, rotateAmount: Int) -> String {
		return "".join(str.map {
				(char) -> String in
				let num = String(char).unicodeScalars
				let characterIntVal = num.first!.value
				var rotatedIntVal = 0
				
				if (Int(characterIntVal) + rotateAmount > 126) {
					// To high..
					rotatedIntVal = ((Int(characterIntVal) + rotateAmount) - 26)
				} else {
					// Well done.
					rotatedIntVal = Int(characterIntVal) + rotateAmount
				}
				
				return String(describing: UnicodeScalar(rotatedIntVal))
			}
		)
	}
}
