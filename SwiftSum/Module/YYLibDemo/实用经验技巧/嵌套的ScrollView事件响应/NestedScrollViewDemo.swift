//
//  NestedScrollViewDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/29.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class NestedScrollViewDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width: 0, height: 1000)
        scrollView.backgroundColor = UIColor.lightGray
        
        let innerScrollView = InnerScrollView(frame: CGRect(x: 10, y: 100, width: 300, height: 300))
        innerScrollView.contentSize = CGSize(width: 0, height: 1000)
        innerScrollView.backgroundColor = UIColor.orange
        innerScrollView.bounces = false
        
        scrollView.addSubview(innerScrollView)
        view.addSubview(scrollView)
    }


}
