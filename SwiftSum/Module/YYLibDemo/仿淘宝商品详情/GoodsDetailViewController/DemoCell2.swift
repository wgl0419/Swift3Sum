//
//  DemoCell2.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/2.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

struct DemoCellModel2: YYRenderableCellModel {
    var cellClass: AnyClass? {
        return DemoCell2.self
    }
    
    var text: String?
}


class DemoCell2: UITableViewCell, YYRenderableCell {
    
    func update(with cellModel: YYRenderableCellModel, indexPath: IndexPath?, containerView: UIView?) {
        let model = cellModel as! DemoCellModel2
        textLabel?.text = model.text
    }
    
}
