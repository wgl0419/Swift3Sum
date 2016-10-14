//
//  YYEnvironment.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/11.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

/**< 开发环境 */
public enum YYEnvironment: String {
    /**< 开发模式，打印日志，不上报日志 */
    case develope = "develope"
    /**< 调试模式，关闭日志打印，上报日志*/
    case prepared = "prepared"
    /**< 生产模式，关闭日志打印，上报日志 */
    case production = "production"
    
}

public class YYEnvironmentManager {
    public static let `default` = YYEnvironmentManager(.develope)
    
    public var currentEnvironment: YYEnvironment {
        didSet {
            
        }
    }
    
    private init(_ mode: YYEnvironment) {
        self.currentEnvironment = mode
    }
}

/**< 环境控制器 */
public let EnvironmentManager = YYEnvironmentManager.default

























