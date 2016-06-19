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
    func rederWithMode(model: AnyObject, indexPath: NSIndexPath?, containerView: UIView?)
}



// MARK: - 通知相关协议
public protocol YYNotificationType {
    associatedtype Notification: RawRepresentable
    
    static func postNotification(notification: Notification, object: AnyObject?, userInfo: [String : AnyObject]?)
    static func addObserver(observer: AnyObject, selector: Selector, notification: Notification, object: AnyObject?)
    static func removeObserver(observer: AnyObject, notification: Notification?, object: AnyObject?)
}




