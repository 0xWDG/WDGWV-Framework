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
private var WDGWVFrameworkWebDebug : Bool = false

extension WDGFramework {
    /**
     Get data as (plain) text
     
     - Parameter url: the URL of the file
     
     - Returns: the contents of the file
     */
    open func getDataAsText(_ url: String, _ post: Dictionary<String, String>? = ["nothing": "send"]) -> String {
        if let myURL = URL(string: url) {
            if (post == ["nothing": "send"]) {
            var error: NSError?
            
            if (String(describing: error) == "fuckswifterrors") {
                error = NSError(domain: "this", code: 89, userInfo: ["n":"o","n":"e"])
            }
            
            do {
                let myHTMLString = try NSString(contentsOf: myURL, encoding: String.Encoding.utf8.rawValue)
                return myHTMLString as String
            }
            catch let error as NSError {
                return "NSString Error: \(error.localizedDescription)"
            }
            }else {
                var waiting = true
                var data = ""
                var request = URLRequest(url: myURL)
                request.httpMethod = "POST"
                request.setValue("application/x-www-form-urlencoded",
                                 forHTTPHeaderField: "Content-Type")
                
                var httpBody = ""
                var idx = 0
                for (key, val) in post! {
                    if (idx == 0) {
                        httpBody.append(contentsOf:
                            "\(key)=\(val.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")
                    } else {
                        httpBody.append(contentsOf:
                            "&\(key)=\(val.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")
                    }
                    idx += 1
                }
                request.httpBody = httpBody.data(using: .utf8)
                
                let session = URLSession.shared
                session.dataTask(with: request) { (sitedata, response, error) in
                    if let sitedata = sitedata {
                        data = String(data: sitedata, encoding: .utf8)!
                        waiting = false
                    } else {
                        data = "Error"
                        waiting = false
                    }
                    
                    }.resume()
                
                while (waiting) {
//                    print("Waiting...")
                }
                
                return data
            }
        } else {
            return "Error: \(url) doesn't appear to be a URL"
        }
    }
    
    /**
     Get data as Data
     
     - Parameter url: the URL of the file
     
     - Returns: the contents of the file
     */
    open func getDataAsData(_ url: String, _ post: Dictionary<String, String>? = ["nothing": "send"]) -> Data {
        if let myURL = URL(string: url) {
            var error: NSError?
            
            if (String(describing: error) == "fuckswifterrors") {
                error = NSError(domain: "this", code: 89, userInfo: ["n":"o","n":"e"])
            }
            
            if (post == ["nothing": "send"]) {
                do {
                    let myHTMLString = try NSString(contentsOf: myURL, encoding: String.Encoding.utf8.rawValue)
                    return (myHTMLString as String).data(using: String.Encoding.utf8)!
                }
                catch let error as NSError {
                    return "Error: \(error.localizedDescription)".data(using: String.Encoding.utf8)!
                }
            } else {
                var waiting = true
                var data = "".data(using: .utf8)
                var request = URLRequest(url: myURL)
                request.httpMethod = "POST"
                request.setValue("application/x-www-form-urlencoded",
                                 forHTTPHeaderField: "Content-Type")
                
                var httpBody = ""
                var idx = 0
                for (key, val) in post! {
                    if (idx == 0) {
                        httpBody.append(contentsOf:
                            "\(key)=\(val.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")
                    } else {
                        httpBody.append(contentsOf:
                            "&\(key)=\(val.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")
                    }
                    idx += 1
                }
                request.httpBody = httpBody.data(using: .utf8)
                
                let session = URLSession.shared
                session.dataTask(with: request) { (sitedata, response, error) in
                    if let sitedata = sitedata {
                        data = sitedata
                        waiting = false
                    } else {
                        data = "Error".data(using: .utf8)
                        waiting = false
                    }
                    
                    }.resume()
                
                while (waiting) {
//                    print("Waiting...")
                }
                
                return data!
            }
        } else {
            return "Error: \(url) doesn't  URL".data(using: String.Encoding.utf8)!
        }
    }
    
    
    /**
     Remove all html elements from a string
     
     - Parameter html: The HTML String
     
     - Returns: the plain HTML String
     */
    open func removeHTML(_ html: String) -> String {
        do {
            let regex:NSRegularExpression = try NSRegularExpression(pattern: "<.*?>", options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, html.count)
            let htmlLessString :String = regex.stringByReplacingMatches(in: html, options: [], range:range, withTemplate: "")
            return htmlLessString
        }
        catch {
            print("Failed to parse HTML String")
            return html
        }
    }
    
    /**
     Newline to Break (br) [like-php]
     
     - Parameter html: the string
     
     - Returns: the string with <br /> tags
     */
    open func nl2br(_ html: String) -> String {
        return html.replacingOccurrences(of: "\n", with: "<br />")
    }
    
    /**
     Break (br) to Newline [like-php (reversed)]
     
     - Parameter html: the html string to convert to a string
     
     - Returns: the string with line-breaks
     */
    open func br2nl(_ html: String) -> String {
        return html.replacingOccurrences(of: "<br />", with: "\n") // html 4
            .replacingOccurrences(of: "<br/>", with: "\n") // invalid html
            .replacingOccurrences(of: "<br>", with: "\n") // html <=4
    }
    
    /**
     Set debug
     
     - Parameter debugVal: Debugmode on/off
     */
    open func setDebug(_ debugVal:Bool) {
        WDGWVFrameworkWebDebug = debugVal
    }
}
