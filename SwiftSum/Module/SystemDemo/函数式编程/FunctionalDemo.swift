//
//  FunctionalDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/11.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class FunctionalDemo: YYBaseDemoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "UIKitDemo", desc: "常用系统控件demo", controllerName: "UIKitDemo"),
            LibDemoInfo(title: "CoreAnimationDemo", desc: "核心动画高级技巧", controllerName: "CoreAnimationDemo"),
        ]
        
    }
    
}
