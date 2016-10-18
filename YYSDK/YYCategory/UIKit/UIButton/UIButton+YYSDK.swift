//
//  UIButton+Extension.swift
//  Sport
//
//  Created by sihuan on 15/1/26.
//  Copyright (c) 2015年 sihuan. All rights reserved.
//

import UIKit

extension UIButton {
    
    // MARK: - 设置背景色
    
    public func setColorSelected(color: UIColor) {
//        self.setBackgroundImage(Utils.createImageWithColor(color), forState: UIControlState.Selected)
    }
    
    public func setColorDisabled(color: UIColor) {
//        self.setBackgroundImage(Utils.createImageWithColor(color), forState: UIControlState.Disabled)
    }

}

// MARK: - Title
extension UIButton {
    // MARK: set
    
    public func setTitleAll(title: String?) {
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        setTitle(title, for: .disabled)
        setTitle(title, for: .selected)
    }
    
    public func setTitleNormal(title: String?) {
        setTitle(title, for: .normal)
    }
    
    public func setTitleHighlighted(title: String?) {
        setTitle(title, for: .highlighted)
    }
    
    public func setTitleDisabled(title: String?) {
        setTitle(title, for: .disabled)
    }
    
    public func setTitleSelected(title: String?) {
        setTitle(title, for: .selected)
    }
    
    // MARK: get
    
    public func titleNomal() -> String? {
        return title(for: .normal)
    }
    
    public func titleHighlighted() -> String? {
        return title(for: .highlighted)
    }
    
    public func titleDisabled() -> String? {
        return title(for: .disabled)
    }
    
    public func titleSelected() -> String? {
        return title(for: .selected)
    }
}

