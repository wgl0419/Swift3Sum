//
//  SwiftLearnDemo.swift
//  SwiftSum
//
//  Created by sihuan on 15/11/3.
//  Copyright © 2015年 sihuan. All rights reserved.
//

import UIKit

typealias DataResultBlock = (_ result: String, _ data: AnyObject?, _ errorMsg: String?) -> Void

protocol Api {
    func get(_ name: String)
    func get(_ name: String, dict: [String: AnyObject])
}

extension Api {
    func get(_ name: String, dict: [String: AnyObject]) {
        print(name, dict)
    }
    func get(_ name: String) {
//        self.get(name: name, dict: ["key":"value"])
    }
}

/*
 You are getting this issue because the function you are calling returns a value but you are ignoring the result.
 
 There are two ways to solve this issue:
 
 1. Ignore the result by adding _ = in front of the function call
 2. Add @discardableResult to the declaration of the function to silence the compiler
 */

class SwiftLearnDemo: YYBaseDemoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "TheBasicsDemo", desc: "基础部分", controllerName: "TheBasicsDemo"),
        ]
    }
    
}


