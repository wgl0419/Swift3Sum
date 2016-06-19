//
//  YYBaseNavigationController.swift
//  Swift3Sum
//
//  Created by sihuan on 2016/6/19.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class YYBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        viewController.edgesForExtendedLayout = []
        super.pushViewController(viewController, animated: animated)
    }
}
