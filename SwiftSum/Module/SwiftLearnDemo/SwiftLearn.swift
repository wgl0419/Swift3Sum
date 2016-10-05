//
//  SwiftLearn.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/11.
//  Copyright © 2016年 huan. All rights reserved.
//

import Foundation

public struct YYAnyHashable {
    
}

fileprivate class AccessControlDemo {
    open var openStr = "open"
    public var publicStr = "public"
    internal var internalStr = "internal"
    fileprivate var fileprivateStr = "fileprivate"
    private var privateStr = "private"
    final var finalStr = "final"
    
    open func openFunc() {
        
    }
    public func publicFunc() {
        
    }
    internal func internalFunc() {
        
    }
    fileprivate func fileprivateFunc() {
        
    }
    private func privateFunc() {
        
    }
    final func finalFunc() {
    
    }
}

extension AccessControlDemo {
    func access() {
        print(fileprivateStr)
        
        //error: Use of unresolved identifier 'privateStr'
        //print(privateStr)
    }
}

fileprivate class AccessControlDemo2: AccessControlDemo {
    open override func openFunc() {
        
    }
    public override func publicFunc() {
        
    }
    override func internalFunc() {
        
    }
    fileprivate override func fileprivateFunc() {
        
    }
    private func privateFunc() {
        
    }
}



