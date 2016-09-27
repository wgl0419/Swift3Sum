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
    
    public static var uniqueDeviceId: String = {
        var deviceId = keychain["uniqueDeviceId"]
        if deviceId == nil {
            deviceId = UIDevice.current.identifierForVendor?.uuidString
            keychain["uniqueDeviceId"] = deviceId!
        }
       
        return deviceId!
    }()
    
    
}

