//
//  YYGlobalTimerDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/23.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

class YYGlobalTimerDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        YYGlobalTimer.addTask(key: "task1") {
            yyLogInfo("task1  " + "\(Date())")
        }
        
        YYGlobalTimer.addTask(for: self, key: "task2", executedInMainThread: false) { 
            yyLogInfo("task2  " + "\(Date())")
        }
        
        YYGlobalTimer.addTask(for: self, key: "task3", executedInMainThread: true) {
            yyLogInfo("task3  " + "\(Date())")
        }
    }
    
    deinit {
        //移除掉默认 task1即可，task2和task3会因为自己释放而自动从YYGlobalTimer中移除
        YYGlobalTimer.removeTask(key: "task1")
    }

}


