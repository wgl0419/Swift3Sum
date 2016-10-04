//
//  YYDim.swift
//  SwiftSum
//
//  Created by sihuan on 16/5/12.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit

public struct YYDimOpitions: OptionSet {
    public var rawValue = 0  // 因为RawRepresentable的要求
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static var dim = YYDimOpitions(rawValue: 1 << 0)//蒙版效果，黑色透明背景，否则为透明
    public static var modal = YYDimOpitions(rawValue: 1 << 1)//模态显示，禁止背后的view交互，否则不影响
    public static var dismissTaped = YYDimOpitions(rawValue: 1 << 2)//点击空白地方自动消失
}

public enum YYDimAnimation {
    case none
    case fade
    case zoom
}

extension YYDim {
    public static func show(withView view: UIView, options: YYDimOpitions = [], animationType: YYDimAnimation = .none, animations: (() -> Void)? = nil, completion: ((Bool) -> Void)? = nil) {
        
        let dim = YYDim()
        dim.addSubview(view)
        view.center = dim.center
        view.window!.addSubview(dim)
        
        YYAnimation.animate(withView: view, duration: 0.4, delay: 0, type: .none, completion: completion)
    }
    
    public func dismiss() {
        showView?.removeFromSuperview()
        self.removeFromSuperview()
    }
}

public class YYDim: UIView {
    
    // MARK: - Property
    
    weak var showView: UIView?
    
    var opitions: YYDimOpitions!
    
    // MARK: - Initialization
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            setupContext()
        }
        super.willMove(toSuperview: newSuperview)
    }

    func setupContext() {
        backgroundColor = UIColor.lightGray
        frame = UIScreen.main.bounds
    }
    
    // MARK: - Override
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.main.bounds
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: - Private

    
    // MARK: - Public
    
    
    // MARK: - Delegate
    
    
}
