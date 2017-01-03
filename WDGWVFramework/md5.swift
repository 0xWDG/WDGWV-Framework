/**
 Copyright (c) 2016 Wesley de Groot (http://www.wesleydegroot.nl), WDGWV (http://www.wdgwv.com)
 
 Variable prefixes:
 WDGS = WDG.Framework Shared
 WDGT = WDG.Framework Tests (internal)
 WDGI = WDG.Framework Internal
 WDGU = WDG.Framework Unspecified
 
 ---------------------------------------------------
 File:    md5.swift
 Created: 18-FEB-2016
 Creator: Wesley de Groot | g: @wdg | t: @wesdegroot
 Issue:   #
 Prefix:  N/A
 ---------------------------------------------------
 */

import Foundation
import CommonCrypto

///**
// MD5Hashing
// 
// A real native Swift 2
// MD5 function
// 
// Created by Wesley de Groot. (Twitter: @wesdegroot)
// 
// GitHub: @wdg
// 
// © 2016 WDGWV/Wesley de Groot. All rights reserved.
// 
// Free to use, but leave this header intact.
// 
// Thanks for using!
// */
//
//private class MD5Hashing {
//    fileprivate let shift : [UInt32] = [7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10, 15, 21]
//    fileprivate let table: [UInt32] = (0 ..< 64).map {UInt32(0x100000000 * abs(sin(Double($0 + 1))))}
//    
//    /**
//     MD5 Generator Function.
//     
//     - Parameter str: The string what needs to be encoded.
//     - Returns: MD5 hashed string
//     */
//    fileprivate func md5(_ str: String) -> String {
//        
//        var message: [UInt8] = [UInt8](str.utf8)
//        
//        var messageLenBits = UInt64(message.count) * 8
//        message.append(0x80)
//        while message.count % 64 != 56 {
//            message.append(0)
//        }
//        
//        let lengthBytes = [UInt8](repeating: 0, count: 8)
//        var lengthBytesPointer: UnsafeMutablePointer<UInt64> = messageLenBits.littleEndian.UnsafeMutablePointer
//
//        message += lengthBytes
//        
//        var a : UInt32 = 0x67452301
//        var b : UInt32 = 0xEFCDAB89
//        var c : UInt32 = 0x98BADCFE
//        var d : UInt32 = 0x10325476
//        
//        for chunkOffset in stride(from: 0, to: message.count, by: 64) {
//            let chunk = UnsafePointer<UInt32>(UnsafePointer<UInt8>(message) + chunkOffset)
//            let originalA = a
//            let originalB = b
//            let originalC = c
//            let originalD = d
//            for j in 0 ..< 64 {
//                var f : UInt32 = 0
//                var bufferIndex = j
//                let round = j >> 4
//                switch round {
//                case 0:
//                    f = (b & c) | (~b & d)
//                case 1:
//                    f = (b & d) | (c & ~d)
//                    bufferIndex = (bufferIndex * 5 + 1) & 0x0F
//                case 2:
//                    f = b ^ c ^ d
//                    bufferIndex = (bufferIndex * 3 + 5) & 0x0F
//                case 3:
//                    f = c ^ (b | ~d)
//                    bufferIndex = (bufferIndex * 7) & 0x0F
//                default:
//                    assert(false)
//                }
//                let sa = shift[(round << 2) | (j&3)]
//                let tmp = a &+ f &+ UInt32(littleEndian: chunk[bufferIndex]) &+ table[j]
//                a = d
//                d = c
//                c = b
//                b = b &+ (tmp << sa | tmp >> (32 - sa))
//            }
//            a = a &+ originalA
//            b = b &+ originalB
//            c = c &+ originalC
//            d = d &+ originalD
//        }
//        
//        let result = [UInt8](repeating: 0, count: 16)
//        
//        for (i, n) in [0: a, 1: b, 2: c, 3: d] {
//            UnsafeMutablePointer<UInt32>(result) [i] = n.littleEndian
//        }
//        
//        return "".join(result.map {String(format: "%02x", $0)})
//    }
//}

extension String  {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
}

func md5(_ str: String) -> String {
    return str.md5
}

//
//extension String {
//    /**
//     Make a MD5 Hash for the string.
//     
//     - Returns: MD5 hashed string
//     */
//    public var md5: String {
//        get {
//            return MD5Hashing().md5(self)
//        }
//    }
//}
//
///**
// md5 Function.
// 
// - Parameter str: The string what needs to be encoded.
// - Returns: MD5 hashed string
// */
//func md5(_ str: String) -> String {
//    return str.md5
//}
