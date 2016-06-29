//
//  YYLabel.swift
//  Swift3Sum
//
//  Created by sihuan on 2016/6/28.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class YYLabel: UILabel {

    // MARK: - IBDesignable
    //圆角
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    //边框宽度
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    //边框颜色
    @IBInspectable var borderColor: UIColor = UIColor.clear() {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    // MARK: UIEdgeInsets
    
    func updateContentInsets(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        let newInsets = UIEdgeInsets(top: top ?? contentEdgeInsets.top, left: left ?? contentEdgeInsets.left, bottom: bottom ?? contentEdgeInsets.bottom, right: right ?? contentEdgeInsets.right)
        if newInsets != contentEdgeInsets {
            contentEdgeInsets = newInsets
        }
    }
    
    @IBInspectable var contentEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    @IBInspectable var inserTop: CGFloat = 0 {
        didSet {
            updateContentInsets(top: inserTop)
        }
    }
    @IBInspectable var insetLeft: CGFloat = 0 {
        didSet {
            updateContentInsets(left: insetLeft)
        }
    }
    @IBInspectable var insetBottom: CGFloat = 0 {
        didSet {
            updateContentInsets(bottom: insetBottom)
        }
    }
    @IBInspectable var insetRight: CGFloat = 0 {
        didSet {
            updateContentInsets(right: insetRight)
        }
    }
    
    
    // MARK: - Override
    
    //如果不覆盖drawTextInRect方法，那么需要设置居中
    override func intrinsicContentSize() -> CGSize {
        var contentSize = super.intrinsicContentSize()
        if contentSize == CGSize.zero || contentEdgeInsets == UIEdgeInsets.zero {
            return contentSize
        }
        contentSize.width += contentEdgeInsets.left + contentEdgeInsets.right
        contentSize.height += contentEdgeInsets.top + contentEdgeInsets.bottom
        return contentSize
    }
    
    //需要和intrinsicContentSize配合使用，否则可能出现...
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, contentEdgeInsets))
    }

}















