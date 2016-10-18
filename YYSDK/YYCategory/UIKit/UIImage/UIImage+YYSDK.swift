//
//  UIImage+YYKit.swift
//  SwiftSum
//
//  Created by sihuan on 2016/7/20.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit
import CoreGraphics

// MARK: - Image Info
extension UIImage {
    /**
     Whether this image has alpha channel.
     */
    public var hasAlphaChannel: Bool {
        guard let cgImage = cgImage else {
            return false
        }
        let alpha = cgImage.alphaInfo
        return (alpha == .first ||
        alpha == .last ||
        alpha == .premultipliedFirst ||
        alpha == .premultipliedLast )
    }
}

extension UIImage {
    
    public func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    public func fitSize(in view: UIView? = nil) -> CGSize {
        let imageWidth = self.size.width
        let imageHeight = self.size.width
        let containerWidth = view != nil ? view!.bounds.size.width : UIScreen.main.bounds.size.width
        let containerHeight = view != nil ? view!.bounds.size.height : UIScreen.main.bounds.size.height
        
        let overWidth = imageWidth > containerWidth
        let overHeight = imageHeight > containerHeight
        
        let timesThanScreenWidth = imageWidth / containerWidth
        let timesThanScreenHeight = imageHeight / containerHeight
        
        var fitSize = CGSize(width: imageWidth, height: imageHeight)
        
        if overWidth && overHeight {
            fitSize.width = timesThanScreenWidth > timesThanScreenHeight ? containerWidth : imageWidth / timesThanScreenHeight
            fitSize.height = timesThanScreenWidth > timesThanScreenHeight ? imageHeight / timesThanScreenWidth : containerHeight
        } else {
            if overWidth && !overHeight {
                fitSize.width = containerWidth
                fitSize.height = containerHeight / timesThanScreenWidth
            } else if (!overWidth && overHeight) {
                //fitSize.width = containerWidth / timesThanScreenHeight
                fitSize.height = containerHeight
            }
        }
        return fitSize
    }
}

extension UIImage {
    /**
     Create and return a pure color image with the given color and size.
     
     @param color  The color.
     @param size   New image's type. default 1x1 point size
     */
    public static func image(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


























