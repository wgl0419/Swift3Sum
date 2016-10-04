//
//  YYRenderableTableView.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/29.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

public protocol YYRenderableCellModel {
    
    var cellClass: AnyClass? { get }
    var cellNibName: String? { get }

    /*
     用于cell高度固定或根据model方便的知道cell的高度,
     是nil的话使用UITableView+FDTemplateLayoutCell.h计算高度
     */
    var cellHeight: CGFloat? { get }
}

//实现类似optional var cellHeight 效果
public extension YYRenderableCellModel {
    var cellClass: AnyClass? { return nil }
    var cellNibName: String? { return nil }
    var cellHeight: CGFloat? { return nil }
}


public protocol YYRenderableCell {
    weak var delegate: AnyObject? { get set }
    
    func update(with cellModel: YYRenderableCellModel, indexPath: IndexPath?, containerView: UIView?)
}
public extension YYRenderableCell {
    weak var delegate: AnyObject? {
        get {
            return nil
        }
        set {
            
        }
    }
}

/**
 设置好数据源即可知道如何自动配置数据的UITableView
 */
open class YYRenderableTableView: UITableView {

    public var dataArray = [YYRenderableCellModel]()

}

// MARK: - Override
extension YYRenderableTableView {
    /**
     刷新数据期间，将UITableViewDelegate设置为自己，用于计算高度
     刷新完再置为原来的代理
     */
    open override func reloadData() {
        let originDelegate = delegate
        dataSource = self
        delegate = self
        super.reloadData()
        
        DispatchQueue.main.async {
            self.delegate = originDelegate
        }
    }
}

// MARK: - Delegate
extension YYRenderableTableView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataArray[indexPath.row]
        let identifier = model.cellNibName ?? String(describing: model.cellClass!.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! YYRenderableCell
        cell.delegate = self
        cell.update(with: model, indexPath: indexPath, containerView: tableView)
        return cell as! UITableViewCell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArray[indexPath.row]
        tableView.registerCell(class: model.cellClass, nibName: model.cellNibName)

        var height: CGFloat
        if model.cellHeight != nil {
            height = model.cellHeight!
        } else {
            height = 120
        }
//        print("\(indexPath) height: \(height)")
        return height
    }
}



























