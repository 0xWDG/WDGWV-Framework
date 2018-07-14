////
////  SafariKeychainManager.swift
////  WDGFramework
////
////  Created by Wesley de Groot on 11-10-17.
////  Copyright © 2017 WDGWV. All rights reserved.
////
//import Foundation
//
//class SafariKeychainManager {
//    
//    class func checkSafariCredentialsWithCompletion(completion: @escaping ((_ username: String?, _ password: String?) -> Void)) {
//        
//        let domain: CFString = "bihappy.eu"
//        
//        SecRequestSharedWebCredential(domain, .none, {
//            (credentials: CFArray!, error: CFError?) -> Void in
//            
//            if let error = error {
//                print("error: \(error)")
//                completion(nil, nil)
//            } else if CFArrayGetCount(credentials) > 0 {
//                let unsafeCred = CFArrayGetValueAtIndex(credentials, 0)
//                let credential: CFDictionaryRef = unsafeBitCast(unsafeCred, CFDictionaryRef.self)
//                let dict: Dictionary<String, String> = credential as! Dictionary<String, String>
//                let username = dict[kSecAttrAccount as String]
//                let password = dict[kSecSharedPassword.takeRetainedValue() as! String]
//                dispatch_get_main_queue().async() {
//                    completion(username: username, password: password)
//                }
//            } else {
//                dispatch_get_main_queue().async() {
//                    completion(nil, nil)
//                }
//            }
//        });
//    }
//    
//    class func updateSafariCredentials(username: String, password: String) {
//        
//        let domain: CFString = "bihappy.eu" as CFString
//        
//        SecAddSharedWebCredential(domain,
//                                  username as CFString,
//                                  count(password) > 0 ? password as CFString : .None,
//                                  {(error: CFError!) -> Void in
//                                    prinn("error: \(error)")
//        });
//    }
//}

