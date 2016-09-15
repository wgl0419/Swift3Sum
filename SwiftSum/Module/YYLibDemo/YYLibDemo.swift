//
//  YYLibDemo.swift
//  Swift3Sum
//
//  Created by sihuan on 2016/6/19.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class YYLibDemo: YYBaseDemoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "YYRefreshDemo", desc: "上下左右4个方向的刷新控件", controllerName: "YYRefreshDemo"),
        ]
    }
}
