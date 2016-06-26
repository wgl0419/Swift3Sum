//
//  YYProtocol.swift
//  SwiftSum
//
//  Created by sihuan on 16/6/6.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit

// MARK: - Cell配置协议
public protocol YYCellRenderable {
    func renderWith(model: AnyObject, at indexPath: NSIndexPath?, in viewController: UIViewController?)
}



// MARK: - 通知相关协议
public protocol YYNotification {
    associatedtype Notification: RawRepresentable
    
    static func post(notification: Notification, object: AnyObject?, userInfo: [String : AnyObject]?)
    static func addObserver(_ observer: AnyObject, selector: Selector, notification: Notification, object: AnyObject?)
    static func removeObserver(_ observer: AnyObject, notification: Notification?, object: AnyObject?)
}




