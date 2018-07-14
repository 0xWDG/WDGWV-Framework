//
//  ImageSlider
//  WDGFramework
//
//  Created by Wesley de Groot on 21-05-17.
//  Copyright © 2017 WDGWV. All rights reserved.
//

import Foundation
import UIKit

// REMOVE AFTER DEBUG
public extension Int {
    /// SwiftRandom extension
    public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

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

open class ImageSlider {
    var images: [UIImage] = []
    var imageHeight: Int
    var pageControl: UIPageControl
    var scrollView: UIScrollView
    var colors: [UIColor] = [UIColor.red, UIColor.orange, UIColor.green, UIColor.yellow, UIColor.gray, UIColor.cyan, UIColor.clear, UIColor.brown, UIColor.black]
    
    public init(images: [UIImage?], view: UIViewController, pageControl: UIPageControl, scrollView: UIScrollView, height: Int? = Int.max) {
        self.images = images as! [UIImage]
        self.imageHeight = height!
        self.pageControl = pageControl
        self.scrollView = scrollView
        
        // Screen width.
        let imageSizeAsInt = Int.init(scrollView.frame.size.width)
        let imageSizeAsFloat = scrollView.frame.size.width
        
        // Content size
        scrollView.contentSize = CGSize.init(width: CGFloat(imageSizeAsInt * images.count), height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
//        scrollView.clipsToBounds = false
        scrollView.delegate = view as? UIScrollViewDelegate
        pageControl.numberOfPages = 0
        var xPos:CGFloat = 0.0;
        
        print("Scrollview Size: x:\(scrollView.frame.origin.x) y:\(scrollView.frame.origin.y) w:\(scrollView.frame.size.width) h:\(scrollView.frame.size.height)")
        for image in images {
            let imageView = UIImageView.init(frame: CGRect(x: xPos, y: 0.0, width: imageSizeAsFloat, height: scrollView.frame.size.height))
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.clipsToBounds = true
            imageView.layer.masksToBounds = true
            imageView.image = image?.imageResize(sizeChange: CGSize(width: imageSizeAsFloat, height: scrollView.frame.size.height))
            imageView.backgroundColor = colors[Int.random(lower: 0, colors.count-1)]
            print("image Size x:\(imageView.frame.origin.x) y:\(imageView.frame.origin.y) w:\(imageView.frame.size.width) h:\(imageView.frame.size.height)")
            scrollView.addSubview(imageView)
            
            xPos += imageSizeAsFloat
            pageControl.numberOfPages += 1
//            scrollView.contentInset = UIEdgeInsets.zero// UIEdgeInsetsZero
        }
        
        // Fix scroll to bottom
        scrollView.contentSize = CGSize.init(width: scrollView.contentSize.width, height: 0);
    }
    
    public func scroll(scrollView: UIScrollView, view: UIViewController, pageControl: UIPageControl) {
        let currentPage: Int = Int.init(floor(scrollView.contentOffset.x / view.view.frame.size.width))
//        print("CurrentPage=\(currentPage) x:\(scrollView.contentOffset.x)")
        pageControl.currentPage = currentPage
    }
}
