//
//  WDGWVFrameworkHash.swift
//  WDGWVFramework
//
//  Created by Wesley de Groot on 08-01-16.
//  Copyright © 2016 WDGWV. All rights reserved.
//

import Foundation
// Need to check this one
// #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

public class WDGWVFrameworkHash {
    let STR_PAD_LEFT  = 1
    let STR_PAD_RIGHT = 1
    
    public init () {
        //Just for fun
        // | = 124 :)
        //        print(str2bin("|"))
        //        print(decbin(124)) // Fail
        //        print(decbin_fix(124)) // Fixed!
    }
    
    /**
     String to binary
     
     - Parameter str: the string to convert
     
     - Returns: the binary string
     */
    public func str2bin(let str : String) -> String {
        let characterString: String = str
        var numbers: [String] = Array<String>()
        for character in characterString.utf8 {
            // To number
            var stringSegment: String = "\(character)"
            
            // Fix
            stringSegment = decbin_fix(Int(stringSegment)!)
            
            // Add to array
            numbers.append(stringSegment)
        }
        
        return numbers.joinWithSeparator("|") // | = TEMP
    }
    
    /**
     Binary to String
     
     - Parameter str: the binary String
     
     - Returns: the human readable string
     */
    private func bin2str(let str : String) -> String {
        return str
    }
    
    //function bin2str($bin) {
    //    $array = str_split($bin,8);
    //    $str = '';
    //    foreach($array as $chr) {
    //    $str.=chr(bindec($chr));
    //    }
    //    return $str;
    //}
    
    /**
     Hexidecimal to Binary
     
     - Parameter str: the Hexidecimal string
     
     - Returns: the binary string
     */
    private func livc_hex2bin(let str: String) -> String {
        return str
    }
    //    function livc_hex2bin($hex) {
    //    $hex = str_split($hex,1);
    //    $bin = '';
    //    foreach($hex as $h) {
    //    $bin.=str_pad(base_convert($h,16,2),4,'0',STR_PAD_LEFT);
    //    }
    //    return $bin;
    //    }
    
    /**
     Binary Encrypt
     
     - Parameter str: The string
     - Parameter pwd: The hash
     
     - Returns: the encoded Binary
     */
    private func bin_encrypt(let str : String, let pwd : String) -> String {
        return str
    }
    //    function bin_encrypt($bin,$password) {
    //    if($password == '') {
    //    return $bin;
    //    }
    //    $password = livc_hex2bin(md5($password));
    //    $bin = str_split($bin,1);
    //    $password = str_split($password,1);
    //    $pcp = 0;
    //    $bcp = 0;
    //    while($bcp<count($bin)) {
    //    if($pcp<count($password)) {
    //    $pcp ++;
    //    } else {
    //    $pcp = 0;
    //    }
    //    if(@$password[$pcp]=='1' && $bin[$bcp]=='0') {
    //    $bin[$bcp] = '1';
    //    } elseif(@$password[$pcp]=='1' && $bin[$bcp]=='1') {
    //    $bin[$bcp] = '0';
    //    }
    //    $bcp ++;
    //    }
    //    $bin = array_reduce($bin,'merge');
    //    return $bin;
    //    }
    
    /**
     Merge
     
     - Parameter str0: String1
     - Parameter str1: String2
     
     - Returns: the merged string
     */
    private func merge(str0: String, str1: String) -> String {
        return str0.stringByAppendingString(str1)
    }
    //    function merge($a,$b) {
    //    return $a.$b;
    //    }
    
    /**
     String Encrypt
     
     - Parameter str: the string
     - Parameter pwd: the hash
     
     - Returns: the encoded String
     */
    private func str_encrypt(let str : String, let pwd : String) -> String {
        return str
    }
    //    function str_encrypt($str,$password) {
    //    return bin2str(bin_encrypt(str2bin($str),$password));
    //    }
    
    /**
     Fixes Decimal 2 Binary function
     
     - Parameter str: the IP Address
     
     - Returns: the encoded IP Address
     */
    private func decbin_fix(let str : Int, _ length:Int!=8) -> String {
        return str_pad(decbin(str), toSize: length!)
    }
    
    /**
     Binary decode
     
     - Parameter str: the binary
     
     - Returns: the decoded String
     */
    private func bindec(let str : String) -> String {
        return String(strtoul(str, nil, 2))
    }
    
    /**
     Decode decimalbinary
     
     - Parameter str: the dec (see: chr())
     
     - Returns: String
     */
    private func decbin(let str : Int) -> String {
        return String(str, radix: 2)
    }
    
    /**
     Append padding to a string
     
     - Parameter str: The string
     - Parameter toSize: Wich size
     - Parameter width: With what character
     - Parameter padding: (bool=true)
     
     - Returns: the string with padding
     */
    private func str_pad(string: String, toSize: Int, with:String="0", padding:Bool=true) -> String {
        var padded = string
        for _ in 0..<toSize - string.characters.count {
            padded = with + padded
        }
        return padded
    }
    
    /**
     Encode a ip Address
     
     - Parameter str: the IP Address
     
     - Returns: the encoded IP Address
     */
    public func encodeIP(str: String) -> String {
        let ipSplit = str.componentsSeparatedByString(".")
        if (ipSplit.count == 4) {
            return "\(chr(ipSplit[0]))\(chr(ipSplit[1]))\(chr(ipSplit[2]))\(chr(ipSplit[3]))"
        }
        else {
            return str
        }
    }
    
    /**
     Decode a ip Address
     
     - Parameter str: the encoded IP Address
     
     - Returns: the IP Address
     */
    public func decodeIP(str: String) -> String {
        if (str.characters.count == 4) {
            return "\(ord(str[0])).\(ord(str[1])).\(ord(str[2]))..\(ord(str[3]))" // .. Fixes swift bug...
        }else{
            return str
        }
    }
    
    //    function ipencode($ip) {
    //    $ip=explode(".",$ip);
    //    return chr($ip[0]).chr($ip[1]).chr($ip[2]).chr($ip[3]);
    //    }
    //    
    //    /**
    //    * Special encoding class for IP (Dec)
    //    *
    //    * @internal
    //    * @ignore
    //    *
    //    * @param string $ip "THE IP"
    //    */
    //    function ipdecode($ip) {
    //    if ( @ord($ip[0]) && @ord($ip[1]) && ord($ip[2]) && @ord($ip[3]) )
    //    return ord($ip[0]).'.'.ord($ip[1]).'.'.ord($ip[2]).'.'.ord($ip[3]);
    //    Else
    //    return $ip;
    //    }
}

/**
 Encode a string using Base64
 
 - Parameter s: the plain string
 
 - Returns: the encoded string
 */
public func base64_encode(s: String) -> String {
    guard let plainData = (s as NSString).dataUsingEncoding(NSUTF8StringEncoding) else {
        fatalError()
    }
    
    let base64String = plainData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    return base64String
    
}

/**
 Decode a string using Base64
 
 - Parameter s: the encoded string
 
 - Returns: the decoded string
 */
public func base64_decode(s: String) -> String {
    if let decodedData = NSData(base64EncodedString: s, options: NSDataBase64DecodingOptions(rawValue: 0)),
        let decodedString = NSString(data: decodedData, encoding: NSUTF8StringEncoding) {
        return decodedString as String
    }
    return "Failed"
}

/**
 Return ASCII value of character
 
 - Parameter s: the character
 
 - Returns: the ascii number of the character
 */
public func ord(s: String) -> String {
    return String(s.unicodeScalars.first!.value) // With? will crash chr()
}

/**
 Return a specific character
 
 - Parameter s: the chr's number
 
 - Returns: the character as given in ascii
 */
public func chr(s: String) -> String {
    guard let newS:Int = Int(s) else {
        return s
    }
    return String(UnicodeScalar(newS))
}

// IF BRIDGING HEADER WORKS
//
///**
// Return MD5 String
//
//    - Parameter string: the string to encode
//
// - Returns: the md5 String
//*/
//func md5(string: String) -> String {
//    var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
//    if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
//        CC_MD5(data.bytes, CC_LONG(data.length), &digest)
//    }
//    
//    var digestHex = ""
//    for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
//        digestHex += String(format: "%02x", digest[index])
//    }
//    
//    return digestHex
//}