//
//  DemoCell.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/2.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

struct DemoCellModel: YYRenderableCellModel {
    var cellNibName: String? {
        return "DemoCell"
    }
    
    var text: String?
}


class DemoCell: UITableViewCell, YYRenderableCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func update(with cellModel: YYRenderableCellModel, indexPath: IndexPath?, containerView: UIView?) {
        let model = cellModel as! DemoCellModel
        name.text = model.text
    }
    
}
