//
//  CoreAnimationDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/1.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit

class CoreAnimationDemo: YYBaseDemoController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "2-寄宿图相关", desc: "BackingImageDemo", controllerName: "BackingImageDemo"),
            LibDemoInfo(title: "3-图层几何学", desc: "LayerGeometryDemo", controllerName: "LayerGeometryDemo"),
            LibDemoInfo(title: "4-视觉效果", desc: "VisualEffectsDemo", controllerName: "VisualEffectsDemo"),
            LibDemoInfo(title: "5-转换", desc: "TransformDemo", controllerName: "TransformDemo"),
            LibDemoInfo(title: "7-隐式动画", desc: "ImplicitAnimationsDemo", controllerName: "ImplicitAnimationsDemo"),
            LibDemoInfo(title: "8-显式动画", desc: "ExpliciteAnimationDemo", controllerName: "ExpliciteAnimationDemo"),
            LibDemoInfo(title: "9-图层时间", desc: "LayerTimerDemo", controllerName: "LayerTimerDemo"),
            LibDemoInfo(title: "10-缓冲", desc: "EasingDemo", controllerName: "EasingDemo"),
            LibDemoInfo(title: "11-定时器的动画", desc: "TimerAnimationDemo", controllerName: "TimerAnimationDemo"),
            
        ]
    }
}

