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
            LibDemoInfo(title: "YYGlobalTimerDemo", desc: "全局定时器", controllerName: "YYGlobalTimerDemo"),
            LibDemoInfo(title: "GoodsDetailContainerController", desc: "仿淘宝商品详情", controllerName: "GoodsDetailContainerController"),
            LibDemoInfo(title: "YYNoDataViewDemo", desc: "无数据展示的通用控件", controllerName: "YYNoDataViewDemo"),
            LibDemoInfo(title: "YYRefreshDemo", desc: "上下左右4个方向的刷新控件", controllerName: "YYRefreshDemo"),
            LibDemoInfo(title: "UsefulExperienceDemo", desc: "一些实用经验技巧", controllerName: "UsefulExperienceDemo"),
        ]
    }
}
