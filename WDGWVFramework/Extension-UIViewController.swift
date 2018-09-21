//
//  Extension-UIViewController.swift
//  WDGFramework-iOS
//
//  Created by Wesley de Groot on 21/09/2018.
//  Copyright © 2018 WDGWV. All rights reserved.
//

//(UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?
#if os(iOS)
import UIKit

extension UIViewController {
    public func canPerformSegue(withIdentifier id: String) -> Bool {
        guard let segues = UIApplication.shared.delegate?.window??.rootViewController?.value(forKey: "storyboardSegueTemplates") as? [NSObject] else { return false }
        return segues.first { $0.value(forKey: "identifier") as? String == id } != nil
    }
    
    /// Performs segue with passed identifier, if self can perform it.
    public func performSegueIfPossible(id: String?, sender: AnyObject? = nil) {
        guard let id = id, canPerformSegue(withIdentifier: id) else { return }
        UIApplication.shared.delegate?.window??.rootViewController?.performSegue(withIdentifier: id, sender: sender)
    }
}
#endif
