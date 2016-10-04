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
    // MARK: - info.plist
    public static var infoDictionary: [String : Any] = Bundle.main.infoDictionary!
    
    public static var developmentRegion: String = {
        return infoDictionary["CFBundleDevelopmentRegion"] as! String
    }()
    
    public static var bundleName: String = {
        return infoDictionary["CFBundleName"] as! String
    }()
    
    public static var displayName: String = {
        return infoDictionary["CFBundleDisplayName"] as! String
    }()
    
    public static var identifier: String = {
        return infoDictionary["CFBundleIdentifier"] as! String
    }()
    
    public static var version: String = {
        return infoDictionary["CFBundleShortVersionString"] as! String
    }()
    
    public static var build: String = {
        return infoDictionary["CFBundleVersion"] as! String
    }()
    
    // MARK: -
    public static var keychain: Keychain = Keychain(service: bundleName)
    
    //返回一个全新的唯一 ID, such as "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
    public static var randomUUID: String {
        return UUID().uuidString
    }
    
    public static var uniqueDeviceId: String = {
        var deviceId = keychain["uniqueDeviceId"]
        if deviceId == nil {
            deviceId = UIDevice.current.identifierForVendor?.uuidString
            keychain["uniqueDeviceId"] = deviceId!
        }
       
        return deviceId!
    }()
    
    
}

