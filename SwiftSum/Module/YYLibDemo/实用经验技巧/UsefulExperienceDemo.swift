//
//  UsefulExperienceDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/29.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

//实现多代理的转换层
class WeakObjectBridge {
    weak var object: AnyObject?
    init(object: AnyObject?) {
        self.object = object
    }
}

class UsefulExperienceDemo: YYBaseDemoController {
    //实现多代理
    var delegates = [WeakObjectBridge]()
    
    func addDelegate(_ delegate: AnyObject) {
        var exist = false
        for (index, delegate) in delegates.enumerated() {
            if let weakDelegate = delegate.object {
                if weakDelegate === delegate {
                    exist = true
                    break
                }
            } else {
                //说明代理被释放了，删除WeakObjectBridge
                delegates.remove(at: index)
            }
            
            if exist == false {
                delegates.append(WeakObjectBridge(object: delegate))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "NestedScrollViewDemo", desc: "2个嵌套的ScrollView响应事件", controllerName: "NestedScrollViewDemo"),
        ]
    }
}
