//
//  SwiftTips.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/5.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 让人眼前一亮的初始化方式
//参考链接http://swift.gg/2016/09/23/swift-configuring-a-constant-using-shorthand-argument-names/
class Initss {
    
    /*
     声明常量后，在一个紧接着的闭包中进行初始化，而不是之后在 viewDidLoad 或其他类似的方法中进行设置，这在 Swift 中是很常见的写法（也确实是一种不错的写法！）。
     
     但是觉得在闭包中多命名一个 UIView 很难看，上面代码中有 purpleView 和 view 两个 UIView 实例，那么 view 是不是应该命名成 purpleView
     */
    let purpleView: UIView = {
        // 在此初始化 view
        // 直接叫 "view" 真的好吗？
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    // MARK: - 用位置参数（positional references）来初始化 Swift 常量
    let yellowView: UIView = {
        $0.backgroundColor = .yellow
        return $0
        // 确保下一行的括号内要传入 UIView()
    }(UIView())
    
    // MARK: - 有个叫 Then 的库更赞，能够写出可读性更好的代码：
    let lable = UILabel().then {
        $0.textColor = .black
        $0.text = "Hello, World!"
    }
}

public protocol Then {}
extension Then where Self: Any {
    public func then(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}
extension Then where Self: AnyObject {
    public func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
extension NSObject: Then{}
































