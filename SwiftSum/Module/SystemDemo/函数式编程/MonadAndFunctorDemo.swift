//
//  MonadAndFunctorDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/17.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 函子 (Functor)、适用函子 (Applicative Functor) 和单子 (Monad)

class MonadAndFunctorDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
//    func yyMap<T, U>(xs: [T]) -> ((T) -> U) -> [U] {
//
//    }
//    
//    func yyMap<T, U>(optional: T?) -> ((T) -> U) -> U? {
//        
//    }
//    
//    func yyMap<T, U>(result: Result<T>) -> ((T) -> U) -> Result<U> {
//        
//    }
    
    
}

/**<
 像 Int? 这样的可选值也可以被显式地写作 Optional<T>。同样地，我们也可以使用 Array<T> 来替换 [T]。
 
 Optional 与 Array 都是需要一个泛型作为参数来构建具体类型的类型构造体 (Type Constructor)。对于一个实例来说，Array<T> 与 Optional<Int> 是合法的类型，而 Array 本身却并不是。
 每个 map 函数都需要两个参数：一个即将被映射的数据结构，和一个类型为 T -> U 的函数 transform。
 对于数组或可选值参数中所有类型为 T 的值，map 函数会使用 transform 将它们转换为 U。
 
 这种支持 map 运算的类型构造体 —— 比如可选值或数组 —— 有时候也被称作函子 (Functor)。
 */
extension Optional {
//    func map<U>(transform: (Wrapped) -> U) -> Optional<U> { }
}
extension Array {
//    func map<U>(transform: (Element) -> U) -> Array<U> { }
}
















