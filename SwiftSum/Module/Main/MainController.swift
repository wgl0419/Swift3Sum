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
        TabBarItemInfo(storyBoardName: "GameDemo", tabTitle: "GameDemo", imageName: nil, imageNameSelected: nil),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContext()
        
        //设置为打印 >= debug级别日志
        yyLogSetDefaultMiniLevel(.debug)
        
        yyLog(.fatal, "fatal")
        yyLogDebug("debug")
        yyLogInfo(12345)
        yyLogWarning(["2": "3", "4": "5"])
        yyLogError(YYLogger.default.miniLevel)
        yyLogFatal(self)
        
        /**< 输入如下：
         😭[FATAL][2016-10-12 02:24:15 +0000][MainController.swift: viewDidLoad(): 28] fatal
         😀[DEBUG][2016-10-12 02:24:15 +0000][MainController.swift: viewDidLoad(): 29] debug
         🤔[INFO][2016-10-12 02:24:15 +0000][MainController.swift: viewDidLoad(): 30] 12345
         😅[WARN][2016-10-12 02:24:15 +0000][MainController.swift: viewDidLoad(): 31] ["2": "3", "4": "5"]
         😱[ERROR][2016-10-12 02:24:15 +0000][MainController.swift: viewDidLoad(): 32] debug
         😭[FATAL][2016-10-12 02:24:15 +0000][MainController.swift: viewDidLoad(): 33] <SwiftSum.MainController: 0x7fbe0c7046d0>
         */
    }

    func setupContext() {
        setupUI()
    }
    
    func setupUI() {
        appendViewControllers(tabBarItemsInfo: tabBarItemsInfo)
    }
}














