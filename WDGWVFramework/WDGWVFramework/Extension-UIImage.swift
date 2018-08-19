//
//  Extension-UIImage.swift
//  WDGFramework
//
//  Created by Wesley de Groot on 13/08/2018.
//  Copyright © 2018 WDGWV. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
extension UIImage {
    func imageResize (sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}
#endif
