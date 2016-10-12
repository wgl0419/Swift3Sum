//
//  YYLogger.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/11.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 公开的便捷调用


/**< 默认输出 >= Info级别日志 */
public func yyLogSetDefaultMiniLevel(_ level: YYLogLevel) {
    YYLogger.default.miniLevel = level
}
public func yyLog(_ level: YYLogLevel, _ items: Any, _ function: StaticString = #function, _ line: Int = #line, _ file: StaticString = #file) {
    YYLogger.default.log(level, items, function, line, file)
}
public func yyLogDebug(_ items: Any, _ function: StaticString = #function, _ line: Int = #line, _ file: StaticString = #file) {
    YYLogger.default.log(.debug, items, function, line, file)
}
public func yyLogInfo(_ items: Any, _ function: StaticString = #function, _ line: Int = #line, _ file: StaticString = #file) {
    YYLogger.default.log(.info, items, function, line, file)
}
public func yyLogWarning(_ items: Any, _ function: StaticString = #function, _ line: Int = #line, _ file: StaticString = #file) {
    YYLogger.default.log(.warning, items, function, line, file)
}
public func yyLogError(_ items: Any, _ function: StaticString = #function, _ line: Int = #line, _ file: StaticString = #file) {
    YYLogger.default.log(.error, items, function, line, file)
}
public func yyLogFatal(_ items: Any, _ function: StaticString = #function, _ line: Int = #line, _ file: StaticString = #file) {
    YYLogger.default.log(.fatal, items, function, line, file)
}


/**< 日志级别 
 DEBUG < INFO < WARN < ERROR < FATAL，分别用来指定这条日志信息的重要程度，
 规则：只输出级别不低于设定级别的日志信息，假设Loggers级别设定为INFO，
 则INFO、WARN、ERROR和FATAL级别的日志信息都会输出，而级别比INFO低的DEBUG则不会输出。
 */
public enum YYLogLevel: Int {
    /// 调试
    case debug = 10
    /// 信息
    case info = 20
    /// 警告
    case warning = 30
    /// 一般错误
    case error = 40
    /// 致命错误
    case fatal = 50
    
    var stringValue: String {
        switch self {
        case .debug:
            return "😀[DEBUG]"
        case .info:
            return "🤔[INFO]"
        case .warning:
            return "😅[WARN]"
        case .error:
            return "😱[ERROR]"
        case .fatal:
            return "😭[FATAL]"
        }
    }
}

public class YYLogger {
    /**< 默认输出 >= Info级别日志 */
    public static let `default` = YYLogger(.info)
    public init(_ level: YYLogLevel) {
        miniLevel = level
    }
    
    //规则：只输出级别不低于设定级别的日志信息
    public var miniLevel: YYLogLevel
    
    /**< 日志在非主线程的一个串行队列中执行 */
    let serialQueue = DispatchQueue(label: "YYLogger")
    
    public func log(_ level: YYLogLevel, _ items: Any, _ function: StaticString, _ line: Int, _ file: StaticString) {
        if level.rawValue < miniLevel.rawValue {
            return
        }
        serialQueue.async {
            let date = Date()
            // [ViewController.swift: viewDidLoad(): 24]
            let details = "[\("\(file)".components(separatedBy: "/").last!): \(function): \(line)]"
            
            /**< 分别为level，时间，文件，方法，行号，内容。 */
            print(level.stringValue + "[\(date)]" + details + " \(items)")
        }
    }
}














