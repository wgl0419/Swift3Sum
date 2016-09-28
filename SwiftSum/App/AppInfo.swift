//
//  AppInfo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/27.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import KeychainAccess

public struct App {
    public static var name: String = {
        return Bundle.main.infoDictionary?[String(kCFBundleNameKey)] as! String
    }()
    
    public static var keychain: Keychain = Keychain(service: name)
    
    //返回一个全新的唯一 ID, such as "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
    public static var randomId: String = {
        return UUID().uuidString
    }()
    
    public static var uniqueDeviceId: String = {
        var deviceId = keychain["uniqueDeviceId"]
        if deviceId == nil {
            deviceId = UIDevice.current.identifierForVendor?.uuidString
            keychain["uniqueDeviceId"] = deviceId!
        }
       
        return deviceId!
    }()
    
    
}

