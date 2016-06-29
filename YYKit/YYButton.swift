//
//  YYButton.swift
//  Swift3Sum
//
//  Created by sihuan on 2016/6/28.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

@IBDesignable
class YYButton: UIButton {

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
            self.layer.borderWidth = borderWidth
        }
    }
    //边框颜色
    @IBInspectable var borderColor: UIColor = UIColor.clear() {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

}
