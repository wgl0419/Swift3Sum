//
//  MainController.swift
//  SwiftSum
//
//  Created by sihuan on 16/3/31.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit
import YYSDK

class MainController: YYBaseTabBarController {

    let tabBarItemsInfo = [
        TabBarItemInfo(storyBoardName: "SystemDemo", tabTitle: "SystemDemo", imageName: nil, imageNameSelected: nil),
        TabBarItemInfo(storyBoardName: "YYLibDemo", tabTitle: "YYLibDemo", imageName: nil, imageNameSelected: nil),
        TabBarItemInfo(storyBoardName: "ThirdLibDemo", tabTitle: "ThirdLibDemo", imageName: nil, imageNameSelected: nil),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContext()
    }

    func setupContext() {
        setupUI()
    }
    
    func setupUI() {
        appendViewControllers(tabBarItemsInfo: tabBarItemsInfo)
    }
}














