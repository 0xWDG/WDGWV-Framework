//
//  NSAttributedString.swift
//  WDGFramework
//
//  Created by Wesley de Groot on 27-05-17.
//  Copyright © 2017 WDGWV. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit

    public extension NSMutableAttributedString {
        @discardableResult public func bold(_ text: String) -> NSMutableAttributedString {
            let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)]
            let boldString = NSMutableAttributedString(string: "\(text)", attributes: attrs)
            self.append(boldString)
            return self
        }

        @discardableResult public func normal(_ text: String) -> NSMutableAttributedString {
            let normal = NSAttributedString(string: text)
            self.append(normal)
            return self
        }
    }
#endif
