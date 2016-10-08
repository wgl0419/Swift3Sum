//
//  YYBaseTabBarController.swift
//  SwiftSum
//
//  Created by sihuan on 16/3/31.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit

class YYBaseTabBarController: UITabBarController {
    //自定义转场动画
//    let tabBarTransitionDelegate = YYTabBarTransitionDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = tabBarTransitionDelegate
    }

    //在UITabBarController切换标签的时候添加淡入淡出的动画。
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let transition = CATransition()
        transition.type = kCATransitionFade
        //把动画添加到UITabBarController的视图图层上，于是在标签被替换的时候动画不会被移除。
        view.layer.add(transition, forKey: nil)
    }
}
