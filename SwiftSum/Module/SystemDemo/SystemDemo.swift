//
//  SystemDemo.swift
//  Swift3Sum
//
//  Created by sihuan on 2016/6/19.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class SystemDemo: YYBaseDemoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = [
            LibDemoInfo(title: "SystemDemo", desc: "SystemDemo", controllerName: "TheBasicsDemo"),
        ]
        print(App.uniqueDeviceId)
    }
    
}

// MARK: - How Do You Do UIView<SomeProtocol> in Swift
protocol MyProtocol: class {
    func foobar()
}

class MyClass<T:MyProtocol> where T:UIView {
    var myView: T!
}

protocol UIViewType {
    var view: UIView { get }
}

extension UIView: UIViewType {
    var view: UIView { return self }
}

func use() {
    // the variable
    let myView: UIViewType & MyProtocol = UIView() as! MyProtocol & UIViewType
    print(myView)
}


protocol SomeProtocol {
    func someMethodInSomeProtocol()
}

class SomeType { }

class SomeOtherType: SomeType, SomeProtocol {
    func someMethodInSomeProtocol() { }
}

class SomeOtherOtherType: SomeType, SomeProtocol {
    func someMethodInSomeProtocol() { }
}

func someMethod<T: SomeType>(_ condition: Bool) -> T where T: SomeProtocol {
    var someVar : T
    if (condition) {
        someVar = SomeOtherType() as! T
    }
    else {
        someVar = SomeOtherOtherType() as! T
    }
    
    someVar.someMethodInSomeProtocol()
    return someVar as T
}





