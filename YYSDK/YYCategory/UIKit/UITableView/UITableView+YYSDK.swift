//
//  UITableView+Extension.swift
//  YYSummaryiOS
//
//  Created by sihuan on 15/8/19.
//  Copyright (c) 2015年 sihuan. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: - 清除多余的分割线
    public func clearExtraCellLine() {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        tableFooterView = footerView
    }
    
    // MARK: - 简化dequeueReusableCellWithIdentifier的使用
    /**
     简化dequeueReusableCellWithIdentifier的使用
     let cell = tableView.dequeueReusableCellWithIdentifier("XxxxxCell") as! XxxxxCell
     
     let cell = tableView.dequeueCell(RankingCell)
     */
    public func dequeueCell<T: UITableViewCell>(cell: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: T.className) as! T
    }
}

// MARK: - registerCell
extension UITableView {
    public func registerCell(class cellClass: AnyClass?, nibName: String?) {
        if let nibName = nibName {
            registerNib(nibName)
        } else if let cellClass = cellClass {
            registerClass(cellClass)
        }
    }
    
    public func registerClass(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: cellClass.className)
    }
    
    public func registerNib(_ nibName: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}



