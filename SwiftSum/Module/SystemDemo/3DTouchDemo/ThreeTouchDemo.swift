//
//  ThreeTouchDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/9.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit


/*
 3DTouch为iOS9用户提供了一个额外维度的人机交互界面。在支持3DTouch的设备上，在app外，人们可以在主屏幕上按压app图标来快速选择app可执行的某个具体的操作。在app内，人们可以使用不同的压力来得到不同的内容查看效果：
 
 1. 预览视图
 2. 打开一个单独的视图控制器界面查看视图，进而进行其他交互。
 */

class ThreeTouchDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Home Screen Quick Actions
    /*
     Home Screen Quick Actions分为两种：static quick actions和dynamic quick actions。
     
     那么什么是static quick actions，什么又是dynamic quick actions？
     1. 定义静态快捷操作需要在app的Info.plist文件中配置UIApplicationShortcutItems这个Key，UIApplicationShortcutItems这个Key对应的是一个数组。
     
     2. 定义一个动态快捷操作需要用到“UIApplicationShortcutItem”类和相关的API创建UIApplicationShortcutItem对象。然后需要用UIApplication的sharedApplication方法获取UIApplication对象，然后用UIApplication对象的“shortcutItems”属性，当然shortcutItems是UIApplication的一个新属性。
     
     注意：两种定义快捷操作项的方式都能显示两行文本和一个可选的图标。
     
     注意：quick actions最多显示4项。也就是说，无论是静态还是动态，这两种定义快捷操作项的方式最多显示四个快捷操作项。
     
     静态优先
     */
    class func setupHomeScreenQuickActions() {
        //使用系统提供的ShortcutIcon类型
        let addOpportnityIcon = UIApplicationShortcutIcon(type: .add)
        let addOpportnityItem = UIApplicationShortcutItem(type: "addOpportunity", localizedTitle: "添加机会", localizedSubtitle: nil, icon: addOpportnityIcon, userInfo: nil)
        
        let bookMarkIcon = UIApplicationShortcutIcon(type: .compose)
        let bookMarkItem = UIApplicationShortcutItem(type: "bookMark", localizedTitle: "tian jia xiao ji", localizedSubtitle: "tian jia xiao ji", icon: bookMarkIcon, userInfo: nil)
        
        let searchIcon = UIApplicationShortcutIcon(type: .search)
        let searchItem = UIApplicationShortcutItem(type: "search", localizedTitle: "搜索客户", localizedSubtitle: "搜索客户", icon: searchIcon, userInfo: nil)
        
        //自定义ShortcutIcon
        // 如果设置了自定义的icon，那么系统自带的就不生效
        let myGuestIcon = UIApplicationShortcutIcon(templateImageName: "smile")
        let myGuestItem = UIApplicationShortcutItem(type: "myGuest", localizedTitle: "我的客户", localizedSubtitle: "我的客户", icon: myGuestIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [addOpportnityItem, bookMarkItem, searchItem, myGuestItem]
    }

    class func performActionFor(_ shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        // 方式一：type
        if shortcutItem.type == "addOpportunity" {
            print("点击了添加机会item")
        } else {
            print(shortcutItem.type)
        }
        
        // 方式二：title或者subtitle
        if shortcutItem.localizedTitle == "tian jia xiao ji" {
            print("点击了添加小记item")
        } else {
            print(shortcutItem.localizedTitle)
        }
    }

}
















