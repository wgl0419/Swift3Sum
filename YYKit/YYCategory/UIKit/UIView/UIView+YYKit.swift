//
//  UIView+YYKit.swift
//  SwiftSum
//
//  Created by sihuan on 16/3/31.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit


extension UIView {
    // MARK: - 根据xib生成对象
    public static func newInstanceFromNib() -> UIView? {
        let view = Bundle(for: self).loadNibNamed(self.className, owner: nil, options: nil).first as? UIView
        return view
    }
    
    // MARK: - 设为圆形
    public func setToRounded(radius: CGFloat? = nil) {
        let r = radius ?? min(self.frame.size.width, self.frame.size.height)/2;
        self.layer.cornerRadius = r
        self.clipsToBounds = true
    }
}

extension UIView {
    /**
     添加填满父view的约束
     */
    public func addConstraintFillSuperView() {
        if let superview = superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0)
            let left = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0)
            let right = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: 0)
            superview.addConstraints([top, left, bottom, right])
        }
    }
}














