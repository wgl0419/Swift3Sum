//
//  UsefulExperienceDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/29.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class UsefulExperienceDemo: YYBaseDemoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "NestedScrollViewDemo", desc: "2个嵌套的ScrollView响应事件", controllerName: "NestedScrollViewDemo"),
        ]
    }
}
