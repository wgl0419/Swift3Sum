//
//  ThirdLibDemo.swift
//  Swift3Sum
//
//  Created by sihuan on 2016/6/19.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class ThirdLibDemo: YYBaseDemoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "ReduxDemo", desc: "使用ReSwift实现Redux架构", controllerName: "ReduxDemo"),
        ]
    }
}

