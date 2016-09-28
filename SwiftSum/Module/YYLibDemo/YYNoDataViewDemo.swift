//
//  YYNoDataViewDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/28.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

class YYNoDataViewDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addButtonToView(title: "showNoDataView") { [weak self] _ in
            self?.showNoDataView()
        }
    }


}
