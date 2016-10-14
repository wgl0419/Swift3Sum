//
//  BooleanTypeyyy.swift
//  SwiftSum
//
//  Created by sihuan on 16/6/1.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit

extension Int8 {
    public var isZero: Bool { return self == 0 }
}
extension Int {
    public var isZero: Bool { return self == 0 }
}
extension Int32 {
    public var isZero: Bool { return self == 0 }
}
extension Int64 {
    public var isZero: Bool { return self == 0 }
}
extension UInt {
    public var isZero: Bool { return self == 0 }
}
extension Double {
    public var isZero: Bool { return self == 0 }
}
extension Float {
    public var isZero: Bool { return self == 0 }
}

extension Optional {
    public var isNil: Bool {
        switch self {
        case .none:
            return true
        case .some(_):
            return false
        }
    }
}








