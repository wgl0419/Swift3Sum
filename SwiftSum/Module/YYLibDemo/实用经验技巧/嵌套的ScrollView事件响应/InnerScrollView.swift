//
//  InnerScrollView.swift
//  ScrollViewDemo
//
//  Created by yangyuan on 2016/9/29.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

class InnerScrollView: UIScrollView , UIGestureRecognizerDelegate{

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.view != self {
            return true
        }
        
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            if contentOffset.y >= contentSize.height - bounds.height && pan.direction == .up {
                return false
            }
            
            if contentOffset.y <= 0 && pan.direction == .down {
                return false
            }
        }

        return true
    }

}
